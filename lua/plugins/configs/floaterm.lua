local loader = require('utils.loader')

local M = {}

M.setup = function()
  local floaterm_vars = {
    width = 0.8,
    height = 0.8,
    borderchars = '─│─│╭╮╯╰',
  }

  local ok, err = pcall(function()
    vim.g.floaterm_width = floaterm_vars.width
    vim.g.floaterm_height = floaterm_vars.height
    vim.g.floaterm_borderchars = floaterm_vars.borderchars
  end)

  if not ok then
    vim.notify('Failed to setup floaterm variables: ' .. err, loader.ERROR)
  end
end

M.setup()

return M
