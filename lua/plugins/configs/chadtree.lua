local keymaps = require "plugins.keymaps.chadtree"

vim.g.chadtree_settings = {
  ['keymap'] = keymaps,
  ['view'] = {
    ['open_direction'] = 'right',
    ['width'] = 30,
  },
}
