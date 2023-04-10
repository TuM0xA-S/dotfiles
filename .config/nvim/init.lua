vim.cmd.colorscheme("pablo")

local set = vim.opt -- setting options shortcut
set.number = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = true
set.wrap = true
set.mouse = "nvi"
set.breakindent = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = false
set.clipboard =	'unnamedplus'
set.swapfile = false

-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--
vim.g.mapleader = ' '
local map = vim.keymap.set -- keymap.set shortcut
map('n', '<space>', '<nop>', 
	{silent = true, desc='prepare space for leader'})

map('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})

map('n', '<leader>n', '<cmd>nohl<cr>', {desc = 'disable hl after search'})
