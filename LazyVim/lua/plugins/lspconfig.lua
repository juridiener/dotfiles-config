return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = { virtual_text = false },
    },
    init = function()
      -- Workaround for blink.cmp triggering incremental LSP sync assertion failures.
      -- Forces full document sync on every client after attach.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            local sync = client.server_capabilities.textDocumentSync
            if type(sync) == "table" then
              -- Only override the change kind, preserve openClose/save/etc.
              sync.change = vim.lsp.protocol.TextDocumentSyncKind.Full
            elseif type(sync) == "number" and sync == vim.lsp.protocol.TextDocumentSyncKind.Incremental then
              client.server_capabilities.textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Full
            end
          end
        end,
      })
    end,
  },
}
