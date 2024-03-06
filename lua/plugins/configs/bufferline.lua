local bufferline = require 'bufferline'
bufferline.setup {
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    indicator = {
      style = 'none',
    },
  },
}
