local status_ok, aerial = pcall(require, 'aerial')
if not status_ok then
  vim.notify('Error requiring aerial', error)
  return
end

aerial.setup({
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end
})
