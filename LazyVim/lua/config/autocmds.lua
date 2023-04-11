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
