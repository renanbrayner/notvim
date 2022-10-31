local status_ok, packer = pcall(require, "packer")
if not status_ok then
	-- Guard clause
	vim.notify("Error requiring packer", error)
	return
end

return packer.startup(function(use)
	use 'wbthomason/packer.nvim' -- Plugin manager
	-- [[ LSP ]]
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
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
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey")
			require("plugins.keymaps.whichkey")
		end
	}
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end
	}

	-- colorthemes
	use {
		"dracula/vim",
		as = "dracula"
	}
	use"ellisonleao/gruvbox.nvim"
	use"shaunsingh/nord.nvim"
	use"ishan9299/nvim-solarized-lua"
end)
