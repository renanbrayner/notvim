local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  vim.notify('Error requiring null_ls', error)
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
      prefer_local = 'node_modules/.bin',
    },
    diagnostics.eslint,
    formatting.black.with { extra_args = { '--fast' } },
    formatting.stylua.with { extra_args = { '--indent-width', '2', '--indent-type', 'Spaces', '-' } },
    code_actions.eslint,
    -- diagnostics.flake8
  },
}
