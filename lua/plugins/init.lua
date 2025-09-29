return {
  -- Dashboard - deve carregar primeiro na inicialização
  {
    'goolord/alpha-nvim',
    priority = 1000,
    event = 'VimEnter',
    config = function()
      require 'plugins.configs.alpha'
    end,
  },

  -- Sistema de notificações - carrega cedo mas não imediato
  {
    'rcarriga/nvim-notify',
    priority = 900,
    event = 'VeryLazy',
    config = function()
      local notify_ok, notify = pcall(require, 'notify')
      if notify_ok then
        vim.notify = notify.notify
        require 'plugins.configs.nvim-notify'
      end
    end,
  },

  -- File explorer - só quando usar <leader>op
  {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = 'python3 -m chadtree deps && :CHADdeps',
    cmd = { 'CHADopen' },
    config = function()
      require 'plugins.configs.chadtree'
    end,
  },

  -- Text manipulation - lazy até usar
  {
    'kylechui/Nvim-surround',
    tag = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup()
    end,
  },

  -- Which-key - carrega nos primeiros keymaps mas não imediato
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'plugins.configs.whichkey'
      require 'plugins.keymaps.whichkey'
    end,
  },

  -- Treesitter - importante para syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  -- Movement enhancement - só quando usar f/t/F/T
  {
    'gukz/ftFT.nvim',
    keys = { 'f', 't', 'F', 'T' },
    opts = {
      keys = { 'f', 't', 'F', 'T' },
      modes = { 'n', 'v' },
      hl_group = 'TelescopeMultiSelection',
      sight_hl_group = 'HopNextKey',
    },
  },

  -- Cheat sheet - só quando usar <leader>c
  {
    'renanbrayner/nvim-cheat.sh',
    dependencies = { 'RishabhRD/popfix' },
    cmd = 'Cheat',
    config = function()
      require 'plugins.configs.nvim-cheat'
    end,
  },

  -- Telescope - fuzzy finder, carrega com <C-p> ou comandos Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
      require 'plugins.configs.telescope'
      require 'plugins.keymaps.telescope'
    end,
  },

  -- Bufferline - deve carregar quando usar comandos de buffer
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  },

  -- Statusline - importante para UI, carrega cedo mas não imediato
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      require 'plugins.configs.lualine'
    end,
  },

  -- Terminal flutuante - só quando usar <leader>t
  {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermNew', 'FloatermToggle' },
    config = function()
      require('plugins.configs.floaterm').setup()
    end,
  },

  -- Session manager - só quando usar (alpha já tem keymaps)
  {
    'Shatur/neovim-session-manager',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'VeryLazy',
    config = function()
      require 'plugins.configs.sessionmanager'
    end,
  },

  -- UI improvements - carrega cedo para melhorar UIs
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require 'plugins.configs.dressing'
    end,
  },

  -- Movement plugin
  {
    'smoka7/hop.nvim',
    tag = '*',
    config = function()
      require('hop').setup()
    end,
  },

  -- Indent guides - quando editar arquivos
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('plugins.configs.indentblankline').setup()
    end,
  },

  -- Color highlighter - quando editar arquivos com cores
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    ft = { 'css', 'scss', 'html', 'javascript', 'typescript', 'lua' },
    config = function()
      require 'plugins.configs.colorizer'
    end,
  },

  -- Comment plugin - quando usar <C-_>
  {
    'numToStr/Comment.nvim',
    keys = { '<C-_>' },
    config = function()
      require('Comment').setup()
    end,
  },

  -- EditorConfig - quando editar arquivos
  {
    'gpanders/editorconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'plugins.configs.gitsigns'
    end,
  },

  -- Auto tag - específico para HTML/XML
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'xml', 'jsx', 'tsx', 'vue', 'svelte' },
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  -- Auto pairs - quando começar a editar
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup { map_cr = true }
    end,
  },

  -- LSP - quando abrir arquivos que têm LSP ou usar keymaps LSP
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mason-org/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      'gd',
      'gD',
      'gi',
      'gr',
      'gl',
      'K',
      '[d',
      ']d',
      '<F2>',
      '<F3>',
      '<leader>l',
    },
    config = function()
      require 'lsp.servers'
    end,
  },

  -- None-ls - formatters/linters
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'lsp.none-ls'
    end,
  },

  -- Completion - quando começar a digitar
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    build = ':COQdeps',
    event = 'InsertEnter',
    config = function()
      require 'plugins.configs.coq'
    end,
  },

  {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
    event = 'InsertEnter',
  },

  {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
    event = 'InsertEnter',
  },

  -- AI completion - quando começar a digitar
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    config = function()
      require 'plugins.configs.supermaven'
    end,
  },

  -- Lazydev - só para arquivos Lua
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    config = function()
      require('lazydev').setup {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      }
    end,
  },

  -- Themes - podem ser lazy, exceto o principal
  { 'dracula/vim', name = 'dracula', lazy = false }, -- seu tema principal
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'shaunsingh/nord.nvim', lazy = true },
  { 'ishan9299/nvim-solarized-lua', lazy = true },
}
