local keymaps = require "plugins.keymaps.chadtree"

vim.g.chadtree_settings = {
  ['keymap'] = keymaps,
  ['view'] = {
    ['open_direction'] = 'right',
    ['width'] = 30,
  },
}

vim.cmd [[ autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif ]] -- autocloses when chadtree is the last window
