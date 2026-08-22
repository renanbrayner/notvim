local loader = require('utils.loader')

local whichkey_config = {
  win = {
    border = 'rounded',
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
}

loader.safe_setup('which-key', whichkey_config)
