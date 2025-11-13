local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' ' -- precisa ser colocado antes de carregar lazy

require 'opts'

local lazy_ok, lazy = pcall(require, 'lazy')
if not lazy_ok then
  vim.notify('Error loading lazy.nvim', vim.log.levels.ERROR)
  return
end

lazy.setup('plugins', {
  defaults = { lazy = false },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

require 'utils'
require 'rice'
require 'core.autocmds'
