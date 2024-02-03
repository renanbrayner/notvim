local M = {}

M.setup = function()
  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8
  vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
end

return M
