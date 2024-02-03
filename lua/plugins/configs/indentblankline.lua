local ibl_status_ok, ibl = pcall(require, 'ibl')
if not ibl_status_ok then
  vim.notify 'Error requiring ibl'
  return
end
local hooks_status_ok, hooks = pcall(require, 'ibl.hooks')
if not hooks_status_ok then
  vim.notify 'Error requiring ibl.hooks'
  return
end

local M = {}

M.setup = function()
  ibl.setup { }
end

return M
