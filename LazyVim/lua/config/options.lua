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
vim.o.foldlevel = 1 -- Display all folds except top ones
vim.o.foldnestmax = 10 -- Create folds only for some number of nested levels

vim.g.maplocalleader = ","
vim.opt.timeoutlen = 1000

-- vim.cmd([[ iabbrev ue ü ]])
-- vim.cmd([[ iabbrev Ue Ü ]])
-- vim.cmd([[ iabbrev oe ö ]])
-- vim.cmd([[ iabbrev Oe Ö ]])
-- vim.cmd([[ iabbrev ae ä ]])
-- vim.cmd([[ iabbrev Ae Ä ]])
-- vim.cmd([[ iabbrev sss ß ]])

-- Better way but not working inside a word
vim.cmd.iabbrev("ue", "ü")
vim.cmd.iabbrev("Ue", "Ü")
vim.cmd.iabbrev("oe", "ö")
vim.cmd.iabbrev("Oe", "Ö")
vim.cmd.iabbrev("ae", "ä")
vim.cmd.iabbrev("Ae", "Ä")
vim.cmd.iabbrev("sss", "ß")

-- not working, only when sourcing the lue file
-- vim.cmd("hi! Visual ctermbg=NONE guibg=#eea846")
