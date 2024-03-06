--  nvim ←[ root folder ]-
-- ├──  lua
-- │  ├──  lsp
-- │  │  ├──  init.lua ←[ lsp setup ]-
-- │  │  ├──  handlers.lua ←[ on_atacch and capabilities etc ]-
-- │  │  ├──  mason-null-ls.lua ←[ bridge between mason and null-ls ]-
-- │  │  ├──  mason.lua ←[ lsp installer ]-
-- │  │  └──  null-ls.lua ←[ formatter linting and etc ]-
-- │  ├──  plugins
-- │  │  ├──  configs ←[ plugins configurations ]-
-- │  │  ├──  keymaps ←[ plugins keymaps and whichkey ]-
-- │  │  └──  init.lua ←[ packer file ]-
-- │  ├──  opts.lua ←[ vim options ]-
-- │  ├──  rice.lua ←[ aesthetics stuff ]-
-- │  └──  utils.lua ←[ utility functions and etc ]-
-- └──  init.lua ←[ this file ]-

require 'rice'
require 'utils'
require 'opts'
require 'plugins'
