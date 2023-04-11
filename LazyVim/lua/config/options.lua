-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- UNDO TREE
vim.opt.swapfile = false -- creates a swapfile
vim.opt.backup = false -- creates a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = false -- enable persistent undo
-- END UNDO TRREE

vim.o.foldmethod = "indent" -- Set 'indent' folding method
vim.o.foldlevel = 20 -- Display all folds except top ones
vim.o.foldnestmax = 10 -- Create folds only for some number of nested levels
