local status_ok, packer = pcall(require, "packer")
if not status_ok then
  -- Guard clause
  vim.notify("Error requiring packer", error)
  return
end

-- AUTO SYNC ON SAVE THIS FILE
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]])

packer.init({
  display = {
    open_fn = require("packer.util").float,
  },
})

packer.reset()

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Plugin manager
  use {
    -- File tree
    "ms-jpq/chadtree",
    branch = "chad",
    run = {
      "python3 -m chadtree deps",
      ":CHADdeps",
    },
    config = function()
      require("plugins.configs.chadtree")
    end
  }
  use {
    -- Commands cheatsheet at the bottom
    "folke/which-key.nvim",
    config = function()
      require("plugins.configs.whichkey")
      require("plugins.keymaps.whichkey")
    end
  }
  use {
    -- Highlighter and stuff
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("plugins.configs.telescope")
    end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("plugins.configs.bufferline")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.configs.lualine')
    end
  }
  use {
    'goolord/alpha-nvim',
    config = function()
      require('plugins.configs.alpha')
    end
  }
  -- [[ Auto completion ]]
  use {
    "ms-jpq/coq_nvim",
    branch = "coq",
    run = {
      ":COQdeps"
    },
    setup = function()
      require("plugins.configs.coq")
    end,
    config = function()
      -- Load LSP after COQ
      require("lsp")
    end
  }
  -- use {
  -- 	"ms-jpq/coq.artifacts",
  -- 	branch = "artifacts",
  -- }
  -- use {
  -- 	"ms-jpq/coq.thirdparty",
  -- 	branch = "3p",
  -- }
  -- [[ LSP ]]
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  -- [[ Colorthemes ]]
  use {
    "dracula/vim",
    as = "dracula"
  }
  use"ellisonleao/gruvbox.nvim"
  use"shaunsingh/nord.nvim"
  use"ishan9299/nvim-solarized-lua"
end)
