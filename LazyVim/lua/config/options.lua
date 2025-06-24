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

vim.g.maplocalleader = ","
vim.opt.timeoutlen = 1000

vim.opt.wrap = false
vim.opt.expandtab = true
-- if set to 999 then the cursor stays always in the middle.
vim.opt.scrolloff = 4
-- vim.opt.virtualedit = "block"
vim.opt.inccommand = "split" -- creat a split buffer for substitute command (search/replace)
vim.opt.termguicolors = true

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

vim.o.grepprg = "rg --vimgrep --hidden -g !.git"

-- Ignore some folders and files with find
vim.opt.wildignore = {
  "**/node_modules/**",
  "**/coverage/**",
  "**/.idea/**",
  "**/.git/**",
  "**/.nuxt/**",
}

vim.g.root_spec = { "cwd" }

-- vim.lsp.inlay_hint.enable = function(bufnr)
--   return false
-- end
--
--

-- Nice and simple folding: instead of nvim-ufo, comment out in autocmds.lua too
-- vim.o.foldenable = true
-- vim.o.foldlevel = 99
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldtext = ""
-- vim.opt.foldcolumn = "0"
-- vim.opt.fillchars:append({fold = " "})
