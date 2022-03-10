-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██║   ██║██║████╗ ████║
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
--           CONFIG FILE
-- BY: https://github.com/renanbrayner

-- Press leader (deffault = <space>) to see keybindings

-- This was made in a vertical screen, maybe some things wont fit
-- porprely on horizontal screens

-- Recomended font: JetBrainsMono Nerd Font

--lua
-- ├── configs
-- │   ├── init.lua   imports everything on configs
-- │   ├── opts.lua   set options
-- │   └── utils.lua  autocmds, functions and misc
-- │
-- ├── plugins
-- │   └── init.lua   packer config and plugins
-- │
-- ├── pluginsconfig  plugins configuration files
-- │   └── init.lua   imports every plugin configuration
-- │
-- └── rice
--     └── init.lua   highlights and colorthemet

require("impatient")
require("plugins")
require("pluginsconfig")
require("configs")
require("lsp")
require("rice")
require("colorizer").setup()

-- This needs to be called here for some misterious reason
