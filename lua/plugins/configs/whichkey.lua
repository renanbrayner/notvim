local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
  vim.notify('Error requiring which-key', error)
  return
end

wk.setup {
  window = {
    border = 'rounded',
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
}
