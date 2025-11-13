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
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
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

  -- Treesitter context - mostra contexto da função/classe no topo
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
      }
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
    version = '*',
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

  -- Git blame - mostra informações do commit ao lado das linhas
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    config = function()
      require 'plugins.configs.git-blame'
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
      'gbprod/none-ls-shellcheck.nvim',
    },
    config = function()
      require 'lsp.none-ls'
    end,
  },

  -- Completion - quando começar a digitar
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    build = ':COQdeps',
    config = function()
      require 'plugins.configs.coq'
    end,
    init = function()
      -- Definir configurações antes do plugin carregar
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        display = {
          ['ghost_text.context'] = { '  ❬ ', ' ❭ ' },
          pum = {
            kind_context = { '(', ')' },
            source_context = { '⌈ ', ' ⌋' },
          },
          icons = {
            mappings = {
              Text = '',
              Method = 'm',
              Function = '',
              Constructor = '',
              Field = '',
              Variable = '',
              Class = '',
              Interface = '',
              Module = '',
              Property = '',
              Unit = '',
              Value = '',
              Enum = '',
              Keyword = '',
              Snippet = '',
              Color = '',
              File = '',
              Reference = '',
              Folder = '',
              EnumMember = '',
              Constant = '',
              Struct = '',
              Event = '',
              Operator = '',
              TypeParameter = '',
            },
          },
        },
        keymap = {
          jump_to_mark = '<c-b>',
          ['repeat'] = '^.',
        },
      }
    end,
  },

  {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
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

  -- Debugging - DAP (Debug Adapter Protocol)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require 'plugins.configs.dap'
    end,
  },

  -- Cursor animation - smear effect
  {
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Themes - podem ser lazy, exceto o principal
  { 'dracula/vim', name = 'dracula', lazy = false }, -- seu tema principal
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'shaunsingh/nord.nvim', lazy = true },
  { 'ishan9299/nvim-solarized-lua', lazy = true },
}
