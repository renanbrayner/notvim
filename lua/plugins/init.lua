local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('Error requiring packer', error)
  return
end

-- AUTO SYNC ON SAVE THIS FILE
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]]

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

packer.reset()

-- Before all plugins set the configuration for notifications
vim.notify = require 'notify'
require 'plugins.configs.nvim-notify'

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Plugin manager
  use {
    'rcarriga/nvim-notify',
  }
  use {
    -- File tree
    'ms-jpq/chadtree',
    branch = 'chad',
    run = {
      'python3 -m chadtree deps',
      ':CHADdeps',
    },
    config = function()
      require 'plugins.configs.chadtree'
    end,
  }
  use {
    -- Commands cheatsheet at the bottom
    'folke/which-key.nvim',
    config = function()
      require 'plugins.configs.whichkey'
      require 'plugins.keymaps.whichkey'
    end,
  }
  use {
    -- Highlighter and stuff
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  }
  use {
    -- press Ctrl + p
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'plugins.configs.telescope'
    end,
  }
  use {
    -- tabs
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  }
  use {
    -- status bar
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.lualine'
    end,
  }
  use {
    -- startup dashboard
    'goolord/alpha-nvim',
    config = function()
      require 'plugins.configs.alpha'
    end,
  }
  use {
    -- session manager
    'Shatur/neovim-session-manager',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.sessionmanager'
    end,
  }
  use {
    -- better interface for selections etc
    'stevearc/dressing.nvim',
    config = function()
      require 'plugins.configs.dressing'
    end,
  }
  use {
    -- movement plugin
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('hop').setup()
    end,
  }
  use {
    -- indent lines highlight
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'plugins.configs.indentblankline'
    end,
  }
  use {
    'unblevable/quick-scope',
    config = function()
      vim.g['qs_highlight_on_keys'] = { 'f', 'F', 't', 'T' }
    end,
  }
  use {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'plugins.configs.colorizer'
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use {
    'gpanders/editorconfig.nvim',
  }
  -- [[ Auto completion ]]
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    run = {
      ':COQdeps',
    },
    setup = function()
      require 'plugins.configs.coq'
    end,
    config = function()
      -- Load LSP after COQ
      require 'lsp'
    end,
  }
  -- use {
  --   "ms-jpq/coq.artifacts",
  --   branch = "artifacts",
  -- }
  -- use {
  --   "ms-jpq/coq.thirdparty",
  --   branch = "3p",
  -- }
  -- [[ LSP ]]
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  }
  -- [[ Colorthemes ]]
  use {
    'dracula/vim',
    as = 'dracula',
  }
  use 'ellisonleao/gruvbox.nvim'
  use 'shaunsingh/nord.nvim'
  use 'ishan9299/nvim-solarized-lua'
end)
