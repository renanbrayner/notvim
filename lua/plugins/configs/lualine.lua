local loader = require('utils.loader')

local lualine_config = {
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
}

loader.safe_setup('lualine', lualine_config)
