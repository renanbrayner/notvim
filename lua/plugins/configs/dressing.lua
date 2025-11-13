local loader = require('utils.loader')

local dressing_config = {
  select = {
    fzf = {
      window = {
        width = 0.9,
        height = 0.8,
      },
    },
  },
}

loader.safe_setup('dressing', dressing_config)
