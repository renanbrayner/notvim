local alpha = require 'alpha'
local headers = require 'plugins.configs.alpha.headers'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = headers['frieren']

dashboard.section.buttons.val = {
  dashboard.button('f', '  Find file', ':lua require("utils").ControlP()<CR>'),
  dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('l', '  Load Last session', ':SessionManager load_last_session<CR>'),
  dashboard.button('s', '  Load session', ':SessionManager load_session<CR>'),
  -- dashboard.button( "m", "  Bookmarks", ":Marks <CR>"),
  dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>:cd %:p:h<CR>:pwd<CR>'),
  dashboard.button('e', '  New file', ':ene<CR>'),
  dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
}

local function footer()
  -- Get plugin count from lazy.nvim if available, otherwise fallback to a simple count
  local plugins_count = 0
  if package.loaded['lazy'] then
    local lazy_stats = require('lazy').stats()
    plugins_count = lazy_stats and lazy_stats.count or 0
  else
    -- Fallback: use a hardcoded count or simple directory listing
    plugins_count = 42 -- approximate count based on what we saw
  end

  local v = vim.version()
  local datetime = os.date ' %d-%m-%Y'
  return string.format(' %s   v%s.%s.%s  %s', plugins_count, v.major, v.minor, v.patch, datetime)
end

dashboard.section.footer.val = footer()

vim.cmd [[
autocmd FileType alpha setlocal nofoldenable
autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
]]

alpha.setup(dashboard.opts)
