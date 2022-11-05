local set = vim.opt

set.number = true -- number column
set.relativenumber = true -- relative number column
set.clipboard = "unnamedplus" -- share clipboard with system
set.mouse = "a" -- mouse suport
set.splitright = true -- non retarded splits
set.splitbelow = true -- non retarded splits
set.list = true
set.listchars:append("eol:﬋")
set.listchars:append("trail:")
set.autoindent = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = -1
set.expandtab = true

vim.g.mapleader = " "
