local alpha = require 'alpha'
local headers = require 'plugins.configs.alpha.headers'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = headers.shadow

dashboard.section.buttons.val = {
  dashboard.button('f', '  Find file', ':lua require("utils").ControlP()<CR>'),
  dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('l', '  Load Last session', ':SessionManager load_last_session<CR>'),
  dashboard.button('s', '  Load session', ':SessionManager load_session<CR>'),
  -- dashboard.button( "m", "  Bookmarks", ":Marks <CR>"),
  dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>:cd %:p:h<CR>:pwd<CR>'),
  dashboard.button('e', '  New file', ':ene<CR>'),
  dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
}

local function footer()
  local plugins = vim.fn.len(vim.fn.globpath('~/.data/nvim/site/pack/packer/start', '*', 0, 1))
  local v = vim.version()
  local datetime = os.date ' %d-%m-%Y'
  return string.format(' %s   v%s.%s.%s  %s', plugins, v.major, v.minor, v.patch, datetime)
end

dashboard.section.footer.val = footer()

vim.cmd [[
autocmd FileType alpha setlocal nofoldenable
autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
]]

alpha.setup(dashboard.opts)
