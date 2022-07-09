local fn = vim.fn

-- AUTO INSTALL PACKER
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	}
	print 'Installing packer close and reopen Neovim...'
	vim.cmd [[packadd packer.nvim]]
end

-- AUTO SYNC ON SAVE THIS FILE
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	vim.notify('Error requiring packer', 'error')
	return
end

packer.init {
	display = {
		open_fn = require('packer.util').float
	}
}

local use = packer.use
packer.reset()

packer.startup(function()
	-- Packer can manage itself
	use {
		'wbthomason/packer.nvim',
		opt = false
	}

	-- code completion
	use 'hrsh7th/nvim-cmp' -- The completion plugin
	use 'hrsh7th/cmp-buffer' -- buffer completions
	use 'hrsh7th/cmp-path' -- path completions
	use 'hrsh7th/cmp-cmdline' -- cmdline completions
	use 'saadparwaiz1/cmp_luasnip' -- snippet completions
	use 'hrsh7th/cmp-nvim-lsp' -- lsp completions

	-- snippets
	use 'L3MON4D3/LuaSnip' -- snippets engine
	use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

	-- movement
	use 'justinmk/vim-sneak' -- friendship ended with s, cl is my new best friend
	use 'unblevable/quick-scope' -- better FfTt

	-- comments
	use 'JoosepAlviste/nvim-ts-context-commentstring' -- comments for vue, jsx and more
	use 'numToStr/Comment.nvim' -- auto comment

	-- LSP
	use 'neovim/nvim-lspconfig' -- lsp plugin from the neovim development team
	use 'williamboman/nvim-lsp-installer' -- intall language servers
	use 'jose-elias-alvarez/null-ls.nvim' -- code actions, diagnostics, formating etc

	-- performance
	use 'antoinemadec/FixCursorHold.nvim' -- fix some shit
	use 'lewis6991/impatient.nvim' -- better performance for lua plugins

	-- color stuff
	use 'norcalli/nvim-colorizer.lua' -- color highlight alt(Rethy/vim-hexokinase)
	-- use { 'm00qek/baleia.nvim', tag = 'v1.1.0' } -- this enables ansi scapes codes

	-- git stuff
	use 'tpope/vim-fugitive'
	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}

	use 'nvim-lua/popup.nvim'
	use 'rcarriga/nvim-notify' -- better notifications
	use 'stevearc/dressing.nvim' -- vim.ui select
	use 'tpope/vim-surround' -- surround
	use 'akinsho/toggleterm.nvim' -- terminal inside vim
	use 'dbeniamine/cheat.sh-vim' -- wierd search stuff
	use 'AndrewRadev/tagalong.vim' -- auto change both tags
	use 'tmsvg/pear-tree' -- nice bracket magic that works
	use 'editorconfig/editorconfig-vim' -- editorconfig per project
	use 'folke/which-key.nvim' -- mappings at bottom
	use 'goolord/alpha-nvim' -- fancy startpage
	use 'junegunn/fzf.vim' -- fzf files
	use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' } -- fzf files
	use { 'dracula/vim', as = 'dracula' } -- colortheme
	use 'ellisonleao/gruvbox.nvim' -- colortheme
	use 'shaunsingh/nord.nvim' -- colortheme
	use 'ishan9299/nvim-solarized-lua' -- colortheme
	use 'lukas-reineke/indent-blankline.nvim' -- indent lines highlight
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'romgrk/barbar.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use {
		'Shatur/neovim-session-manager',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'evanleck/vim-svelte'
	use 'pangloss/vim-javascript'
	use 'HerringtonDarkholme/yats.vim'

	-- AUTO SET UP CONFIG AFTER CLONING
	-- PUT THIS AT THE END
	if PACKER_BOOTSTRAP then
		require 'packer'.sync()
	end
end)
