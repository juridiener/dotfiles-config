-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- autosave when loose focus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = function()
    vim.cmd([[
      :au FocusLost * silent! wa
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.*" },
  desc = "Save view (folds), when closing file",
  command = "mkview",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*" },
  desc = "Load view (folds), when opening file",
  command = "silent! loadview",
})

-- for folding without nvim-ufo
-- vim.o.foldmethod = 'expr'
-- -- Default to treesitter folding
-- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- -- Prefer LSP folding if client supports it
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--          local client = vim.lsp.get_client_by_id(args.data.client_id)
--          if client:supports_method('textDocument/foldingRange') then
--              local win = vim.api.nvim_get_current_win()
--              vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
--         end
--     end,
--  })

-- -- Apply colorscheme on VimEnter
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("colorscheme poimandres")
--   end,
-- })

-- vim.api.nvim_create_augroup("InnerAbbreviations", { clear = true })
--
-- local abbreviations = {
--   ue = "ü",
--   Ue = "Ü",
--   oe = "ö",
--   Oe = "Ö",
--   ae = "ä",
--   Ae = "Ä",
--   sss = "ß",
-- }
--
-- vim.api.nvim_create_autocmd("TextChangedI", {
--   pattern = "*",
--   group = "InnerAbbreviations",
--   callback = function()
--     local col = vim.fn.col(".")
--     local line = vim.fn.getline(".")
--     local leading = string.sub(line, 1, col - 1)
--
--     for abbr, replacement in pairs(abbreviations) do
--       if string.sub(leading, -#abbr) == abbr then
--         vim.fn.feedkeys(string.rep("\b", #abbr) .. replacement)
--         return
--       end
--     end
--   end,
-- })
