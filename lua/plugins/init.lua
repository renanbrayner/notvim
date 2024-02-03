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
local notify_ok, notify = pcall(require, 'notify')
if notify_ok then
  vim.notify = notify
  require 'plugins.configs.nvim-notify'
end

return packer.startup(function(use)
  use {
    'rest-nvim/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.rest-client'
    end,
  }
  use 'wbthomason/packer.nvim' -- Plugin manager
  use {
    -- Notifications
    'rcarriga/nvim-notify',
  }
  use {
    -- File tree
    'renanbrayner/chadtree',
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
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-surround').setup()
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
  -- use {
  --   'leafOfTree/vim-svelte-plugin'
  -- }
  use {
    -- Highlighter and stuff
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  }
  use {
    -- Press Ctrl + p
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'plugins.configs.telescope'
    end,
  }
  use {
    -- Tabs
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  }
  use {
    -- Status bar
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.lualine'
    end,
  }
  use {
    -- foating terminal
    'voldikss/vim-floaterm',
    config = function()
      require 'plugins.configs.floaterm'.setup()
    end,
  }
  use {
    -- Startup dashboard
    'goolord/alpha-nvim',
    config = function()
      require 'plugins.configs.alpha'
    end,
  }
  use {
    -- Session manager
    'Shatur/neovim-session-manager',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.sessionmanager'
    end,
  }
  use {
    -- Better interface for selections etc
    'stevearc/dressing.nvim',
    config = function()
      require 'plugins.configs.dressing'
    end,
  }
  use {
    -- Movement plugin
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('hop').setup()
    end,
  }
  use {
    -- Indent lines highlight
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require 'plugins.configs.indentblankline'.setup()
    end,
  }
  use {
    -- Better fFtT
    'unblevable/quick-scope',
    config = function()
      vim.g['qs_highlight_on_keys'] = { 'f', 'F', 't', 'T' }
    end,
  }
  use {
    -- Color codes highlight example: #FF0000
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'plugins.configs.colorizer'
    end,
  }
  use {
    -- Press Ctrl + /
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use {
    -- Editorconfig parsing
    'gpanders/editorconfig.nvim',
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.gitsigns'
    end,
  }
  -- use {
  --   'steelsojka/pears.nvim',
  --   config = function()
  --     require 'plugins.configs.pears'
  --   end,
  -- }
  use {
    -- TODO: configure
    'windwp/nvim-ts-autotag',
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup { map_cr = true }
    end,
  }
  -- [[ Auto completion ]]
  use {
    'ms-jpq/coq_nvim',
    -- 'renanbrayner/coq_nvim', -- my fork to avoid using old coq version and fix bug bellow
    branch = 'coq',
    -- commit = '5eddd31bf8a98d1b893b0101047d0bb31ed20c49', -- This solves the css autocomplete bug
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
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
  }
  use {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
  }
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
