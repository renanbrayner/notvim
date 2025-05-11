--  nvim ←[ root folder ]-
-- ├──  lua
-- │  ├──  lsp
-- │  │  ├──  init.lua ←[ lsp setup ]-
-- │  │  ├──  handlers.lua ←[ on_atacch and capabilities etc ]-
-- │  │  ├──  mason-null-ls.lua ←[ bridge between mason and null-ls ]-
-- │  │  ├──  mason.lua ←[ lsp installer ]-
-- │  │  └──  null-ls.lua ←[ formatter linting and etc ]-
-- │  ├──  plugins
-- │  │  ├──  configs ←[ plugins configurations ]-
-- │  │  ├──  keymaps ←[ plugins keymaps and whichkey ]-
-- │  │  └──  init.lua ←[ packer file ]-
-- │  ├──  opts.lua ←[ vim options ]-
-- │  ├──  rice.lua ←[ aesthetics stuff ]-
-- │  └──  utils.lua ←[ utility functions and etc ]-
-- └──  init.lua ←[ this file ]-

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = ' ' -- precisa ser colocado antes de carregar lazy

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  vim.notify("Error loading lazy.nvim", vim.log.levels.ERROR)
  return
end

lazy.setup('plugins')

require 'rice'
require 'utils'
require 'opts'
