local M = {}

local filetype = vim.bo.filetype

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

M.add_tables = function(a, b)
  local result = {}
  for k, v in pairs(a) do
    table.insert(result, v)
  end
  for k, v in pairs(b) do
    table.insert(result, v)
  end
  return result
end

M.ControlP = function()
  local excluded_filetypes = {
    'coc-explorer',
    'NvimTree',
    'CHADTree',
  }
  if has_value(excluded_filetypes, filetype) then
    vim.api.nvim_command 'wincmd h' -- go left to leave the tree on the right
  end
  vim.fn.system 'git rev-parse --is-inside-work-tree'
  if vim.v.shell_error == 0 then
    -- vim.cmd([[:GFiles]])
    vim.cmd [[:Telescope git_files]]
  else
    -- vim.cmd([[:Files]])
    vim.cmd [[:Telescope find_files]]
  end
end

return M
