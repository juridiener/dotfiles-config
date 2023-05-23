-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("i", "jk", "<ESC>", opts)
keymap("n", "<ESC>", "<cmd>nohlsearch<CR>", opts)

-- Folds
keymap("n", "zz", "za", opts)

-- remap ciw | Ciw to blackhole register
-- so that ciw does not override yank
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
