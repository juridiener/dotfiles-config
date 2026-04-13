return {
  "neovim/nvim-lspconfig",
  init = function()
    -- workaround for neovim bug (present in 0.11.x and 0.12.1): sync.lua:195 assertion failed
    -- in compute_end_range during incremental text sync — use full sync to avoid it
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          client.server_capabilities.textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Full
        end
      end,
    })
  end,
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = { virtual_text = false },
    servers = {
      eslint = {
        on_init = function(client)
          -- eslint flat config has circular refs in plugin objects that break
          -- pull diagnostics (textDocument/diagnostic) serialization
          client.server_capabilities.diagnosticProvider = nil
        end,
      },
    },
  },
}
