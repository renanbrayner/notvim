local status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not status_ok then
  vim.notify('Error requiring mason-null-ls', vim.log.levels.ERROR)
  return
end

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "eslint_d",
    "black",
    "stylua",
    "pylint",
  },
  automatic_installation = true,
  automatic_setup = true,
})
