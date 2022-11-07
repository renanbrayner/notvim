local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
  vim.notify("Error requiring dressing", error)
  return
end

dressing.setup({
  select = {
    fzf = {
      window = {
        width = 0.9,
        height = 0.8,
      },
    },
  },
})
