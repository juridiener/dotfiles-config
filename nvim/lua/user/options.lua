vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = false                         -- highlight all matches on previous search pattern
vim.opt.incsearch = true
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
-- vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)

--set colors
vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#ffff00', fg = '#000000'})
vim.api.nvim_set_hl(0, 'Search', { bg = '#ffff00', fg = '#000000' })
vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#ffff00', fg = '#000000' })

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffff00'})

vim.opt_local.spell = true
vim.opt_local.spelllang = {'en_us', 'de_de'}

-- UNDO TREE
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.backup = false                          -- creates a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = false                         -- enable persistent undo
-- END UNDO TRREE

-- vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.updatetime = 50                        -- faster completion (4000ms default)

vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
-- vim.opt.wrapscan = false                       -- for searches or macro if hints the end it print a error message

vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- options for nvimorg
-- Links are concealed with Vim's conceal feature (see :help conceal). To enable concealing, add this to your
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
-- If you are using Windows, paths are by default written with backslashes. To use forward slashes, you must enable
vim.opt.shellslash = true                       
