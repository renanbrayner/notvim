local actions_ok, actions = pcall(require, 'telescope.actions')
if not actions_ok then
  vim.notify('Error requiring telescope.actions', vim.log.levels.ERROR)
  return
end

local mappings = {
  i = {
    ['<C-h>'] = actions.which_key,
  },
}

return mappings
