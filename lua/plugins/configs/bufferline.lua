local loader = require('utils.loader')

local bufferline_config = {
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    indicator = {
      style = 'none',
    },
  },
}

loader.safe_setup('bufferline', bufferline_config)
