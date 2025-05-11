local set = vim.opt
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config'

set.number = true -- number column
set.relativenumber = true -- relative number column
set.clipboard = 'unnamedplus' -- share clipboard with system
set.mouse = 'a' -- mouse suport
set.splitright = true -- non retarded splits
set.splitbelow = true -- non retarded splits
set.list = true -- ghost text on invisible characters
-- set.listchars:append 'eol:X﬋' -- character at the end of line
set.listchars:append 'trail:' -- character at trailing spaces
set.signcolumn = 'yes' -- extra column at the left
set.undofile = true -- set undo file
set.undodir = { prefix .. '/nvim/.undo' } -- set undodir to $XDG_CONFIG_HOME/nvim/.undo
set.scrolloff = 8 -- leave a space at the top and bottom of curso
set.diffopt:append 'vertical' -- dif on a vertical split

set.shortmess = set.shortmess + 'c'
set.autoindent = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = -1
set.laststatus = 3
set.expandtab = true
set.writebackup = false
set.hidden = true
set.backup = false
set.swapfile = false

vim.g.vim_svelte_plugin_load_full_syntax = 1
vim.g.vim_svelte_plugin_use_typescript = 1
vim.g.vim_svelte_plugin_use_sass = 1
