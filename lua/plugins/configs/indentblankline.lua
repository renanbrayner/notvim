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
  ibl.setup {
    indent = {
      char = '│',
      tab_char = '│',
      -- Use the custom indent highlights defined in themes
      highlight = {
        'IndentBlanklineIndent1',
        'IndentBlanklineIndent2',
        'IndentBlanklineIndent3',
        'IndentBlanklineIndent4',
        'IndentBlanklineIndent5',
        'IndentBlanklineIndent6',
      },
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      char = '│',
      highlight = 'IndentBlanklineContextChar',
    },
    exclude = {
      filetypes = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      },
    },
  }
end

return M
