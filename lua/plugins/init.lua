return {
  {
    "rcarriga/nvim-notify",
    priority = 1000,
    lazy = false,
    config = function()
      local notify_ok, notify = pcall(require, 'notify')
      if notify_ok then
        vim.notify = notify.notify -- em vez de vim.notify = notify
        require 'plugins.configs.nvim-notify'
      end
    end
  },

  {
    "ms-jpq/chadtree",
    branch = "chad",
    build = "python3 -m chadtree deps && :CHADdeps",
    config = function()
      require "plugins.configs.chadtree"
    end
  },

  {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end
  },

  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons", "kyazdani42/nvim-web-devicons" },
    config = function()
      require "plugins.configs.whichkey"
      require "plugins.keymaps.whichkey"
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end
  },

  {
    "gukz/ftFT.nvim",
    opts = {
      keys = { "f", "t", "F", "T" }, -- the keys that enable highlights.
      modes = { "n", "v" },          -- the modes this plugin works in.
      hl_group = "TelescopeMultiSelection",           -- this property specify the hi group
      sight_hl_group = "HopNextKey",           -- this property specify the hi group for sight line, if not set, the sight line will not show.
    },
    config = true,
  },

  {
    "renanbrayner/nvim-cheat.sh",
    dependencies = { "RishabhRD/popfix" },
    init = function()
      require "plugins.configs.nvim-cheat"
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.configs.telescope"
    end
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.configs.bufferline"
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.configs.lualine"
    end
  },

  {
    "voldikss/vim-floaterm",
    config = function()
      require("plugins.configs.floaterm").setup()
    end
  },

  {
    "goolord/alpha-nvim",
    config = function()
      require "plugins.configs.alpha"
    end
  },

  {
    "Shatur/neovim-session-manager",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.configs.sessionmanager"
    end
  },

  {
    "stevearc/dressing.nvim",
    config = function()
      require "plugins.configs.dressing"
    end
  },

  {
    "smoka7/hop.nvim",
    tag = "*",
    config = function()
      require("hop").setup()
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("plugins.configs.indentblankline").setup()
    end
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require "plugins.configs.colorizer"
    end
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },

  { "gpanders/editorconfig.nvim" },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.configs.gitsigns"
    end
  },

  { "windwp/nvim-ts-autotag" },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup { map_cr = true }
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    config = function()
      require("lsp.servers")
    end
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require("lsp.none-ls")
    end
  },

  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    build = ":COQdeps",
    init = function()
      require "plugins.configs.coq"
    end
  },

  { "ms-jpq/coq.artifacts",  branch = "artifacts" },
  { "ms-jpq/coq.thirdparty", branch = "3p" },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("plugins.configs.supermaven")
    end
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = function()
      require("lazydev").setup {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        }
      }
    end
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.configs.rest-client")
    end
  },

  -- Themes
  { "dracula/vim",        name = "dracula" },
  { "ellisonleao/gruvbox.nvim" },
  { "shaunsingh/nord.nvim" },
  { "ishan9299/nvim-solarized-lua" },
}
