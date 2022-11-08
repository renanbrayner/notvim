local status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not status_ok then
  vim.notify('Error requiring mason-null-ls', error)
  return
end

mason_null_ls.setup {
  automatic_setup = true,
}
