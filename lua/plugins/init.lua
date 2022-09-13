local fn = vim.fn

-- AUTO INSTALL PACKER
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- AUTO SYNC ON SAVE THIS FILE
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Error requiring packer", "error")
  return
end

packer.init({
  display = {
    open_fn = require("packer.util").float,
  },
})

local use = packer.use
packer.reset()

packer.startup({
  function()
    -- Packer can manage itself
    use({
      "wbthomason/packer.nvim",
      opt = false,
    })

    -- LSP
    use({
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig", -- lsp plugin from the neovim development team
    })

    -- better than stack overflow
    use({ "renanbrayner/cheat-sheet" })
    -- use({ "Djancyp/cheat-sheet" })

    -- code actions, diagnostics, formating etc
    use("jose-elias-alvarez/null-ls.nvim")

    -- completion
    use({
      "ms-jpq/coq_nvim",
      branch = "coq",
    })
    use({
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    })
    use({
      "ms-jpq/coq.thirdparty",
      branch = "3p",
    })

    -- fixes
    use("antoinemadec/FixCursorHold.nvim") -- fix some shit required by A LOT of plugins
    use("lewis6991/impatient.nvim") -- better startup for lua plugins

    -- movement
    use({
      "phaazon/hop.nvim",
      branch = "v2", -- optional but strongly recommended
    })
    use("unblevable/quick-scope")

    -- comments
    use("JoosepAlviste/nvim-ts-context-commentstring") -- comments for vue, jsx and more using treesitter
    use("numToStr/Comment.nvim") -- auto comment

    -- color stuff
    use({
      "rrethy/vim-hexokinase",
      run = "cd ~/.data/nvim/site/pack/packer/start/vim-hexokinase/ && make hexokinase",
    })
    -- use { 'm00qek/baleia.nvim', tag = 'v1.1.0' } -- this enables ansi scapes codes

    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })

    use("nvim-lua/popup.nvim") -- used by a lot of plugins
    use("stevearc/dressing.nvim") -- vim.ui select
    use("rcarriga/nvim-notify") -- better notifications
    use("kylechui/nvim-surround") -- surround
    use("akinsho/toggleterm.nvim") -- terminal inside vim
    use("editorconfig/editorconfig-vim") -- editorconfig per project
    use("folke/which-key.nvim") -- mappings at bottom
    use("goolord/alpha-nvim") -- fancy startpage
    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
    })
    -- use("junegunn/fzf.vim") -- fzf files
    -- use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" }) -- fzf files

    -- colorthemes
    use({ "dracula/vim", as = "dracula" })
    use("ellisonleao/gruvbox.nvim")
    use("shaunsingh/nord.nvim")
    use("ishan9299/nvim-solarized-lua")

    use("windwp/nvim-autopairs") -- bracket magic
    use("windwp/nvim-ts-autotag") -- html tag magic

    use("lukas-reineke/indent-blankline.nvim") -- indent lines highlight
    -- use({
    --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- lsp in virtual text bellow line
    --   config = function()
    --     require("lsp_lines").setup()
    --   end,
    -- })

    -- better folds
    use({
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })

    use({
      "Shatur/neovim-session-manager",
      requires = { "nvim-lua/plenary.nvim" },
    })

    use({
      "ms-jpq/chadtree",
      branch = "chad",
      run = {
        "python3 -m chadtree deps",
        ":CHADdeps",
      },
    })

    use({"elkowar/yuck.vim"}) -- for eww widgets development

    -- syntax and highlight
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    })
    use("p00f/nvim-ts-rainbow")
    use("evanleck/vim-svelte") -- TODO: test svelte highlighting without this plugin

    use("petertriho/nvim-scrollbar") -- scrollbar
    use("kevinhwang91/nvim-hlslens") -- search indicators

    -- AUTO SET UP CONFIG AFTER CLONING
    -- PUT THIS AT THE END
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})
