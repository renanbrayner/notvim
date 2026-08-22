-- Theme configuration and highlight management
-- Refactored to use the new theme inheritance system

local theme_manager = require('themes.colors')

-- ============================================================================
-- THEME INITIALIZATION
-- ============================================================================

-- Set default theme (can be overridden by user)
vim.cmd 'colorscheme dracula'

-- Enable true colors and UI options
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmode = false

-- Set up terminal colors for true color support
vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
  ]]

-- Remove startup message
vim.opt.shortmess:append 'I'

-- ============================================================================
-- THEME APPLICATION
-- ============================================================================

-- Get and apply current theme highlights
local current_theme = theme_manager.get_current_theme()
theme_manager.apply_highlights(current_theme)

-- Set up fzf colors for compatibility
theme_manager.setup_fzf_colors(current_theme)

-- ============================================================================
-- LEGACY COMPATIBILITY
-- ============================================================================

-- Return colors in legacy format for existing code compatibility
-- This ensures that any code expecting the old color structure continues to work
local legacy_colors = theme_manager.get_legacy_colors(current_theme)

-- Export for other modules
return legacy_colors
