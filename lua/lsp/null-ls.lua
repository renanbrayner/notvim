local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    vim.notify("Error requiring null-ls", "error")
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      prefer_local = "node_modules/.bin"
    }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua.with({ extra_args = { "--indent-width", "2", "--indent-type", "Spaces", "-" } }),
    -- diagnostics.flake8
	},
})
