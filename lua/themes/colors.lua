-- Theme manager and utilities
-- Centralizes theme loading and highlight application

local themes = {
  dracula = require('themes.dracula'),
  gruvbox = require('themes.gruvbox'),
  solarized = require('themes.solarized'),
  nord = require('themes.nord'),
}

local M = {}

-- Cache for loaded themes
local theme_cache = {}

-- Get theme by name
M.get_theme = function(name)
  name = name:lower()

  -- Return cached theme if available
  if theme_cache[name] then
    return theme_cache[name]
  end

  -- Load theme
  local theme = themes[name]
  if not theme then
    vim.notify('Theme not found: ' .. name, vim.log.levels.ERROR)
    return themes.dracula -- fallback
  end

  -- Cache theme
  theme_cache[name] = theme
  return theme
end

-- Get current theme based on colorscheme
M.get_current_theme = function()
  local colorscheme = vim.g.colors_name or 'dracula'
  return M.get_theme(colorscheme:lower())
end

-- Set and apply theme
M.set_theme = function(name)
  local theme = M.get_theme(name)
  if theme then
    vim.cmd('colorscheme ' .. name)
    M.apply_highlights(theme)
  end
end

-- Apply essential base highlights (minimal approach)
M.apply_essential_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Only set the most essential highlight that must match exactly
  -- Let the colorscheme handle the rest
  highlight(0, 'Normal', { bg = colors.ui.background_primary, fg = colors.semantic.foreground })
end

-- Apply global bufferline highlights (from original rice.lua)
M.apply_global_bufferline_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- NvimTree highlights (from original)
  highlight(0, 'NvimTreeNormal', { bg = colors.ui.background_tertiary })
  highlight(0, 'NvimTreeVertSplit', { bg = colors.ui.background_tertiary })
  highlight(0, 'NvimTreeEndOfBuffer', { fg = colors.ui.background_tertiary })

  -- Bufferline highlights (from original - exact match)
  highlight(0, 'BufferTabpageFill', { bg = colors.ui.background_tertiary, fg = colors.ui.background_tertiary })
  highlight(0, 'BufferInactive', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_tertiary })
  highlight(0, 'BufferInactiveSign', { bg = colors.ui.background_secondary, fg = colors.ui.background_secondary })
  highlight(0, 'BufferInactiveMod', { bg = colors.ui.background_secondary, fg = colors.semantic.warning })
  highlight(0, 'BufferVisible', { fg = colors.semantic.comment })
  highlight(0, 'BufferVisibleSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferVisibleMod', { fg = colors.semantic.warning })
  highlight(0, 'BufferCurrent', { fg = colors.semantic.foreground, bg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentMod', { fg = colors.semantic.warning })

  -- QuickScope highlights (from original)
  highlight(0, 'QuickScopeSecondary', { link = 'healthWarning' })
  highlight(0, 'QuickScopePrimary', { link = 'healthSuccess' })
end

-- Apply essential plugin highlights (minimal approach)
M.apply_essential_plugin_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Only rainbow highlights (if available) - essential for functionality
  if colors.extensions.rainbow then
    for i, color in ipairs(colors.extensions.rainbow) do
      highlight(0, 'rainbowcol' .. i, { fg = color })
    end
  end
end

-- Apply bufferline highlights
M.apply_bufferline_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  highlight(0, 'BufferTabpageFill', { bg = colors.ui.background_tertiary, fg = colors.ui.background_tertiary })
  highlight(0, 'BufferInactive', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_secondary })
  highlight(0, 'BufferInactiveSign', { bg = colors.ui.background_secondary, fg = colors.ui.background_secondary })
  highlight(0, 'BufferInactiveMod', { bg = colors.ui.background_secondary, fg = colors.semantic.warning })
  highlight(0, 'BufferVisible', { fg = colors.ui.foreground_secondary })
  highlight(0, 'BufferVisibleSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferVisibleMod', { fg = colors.semantic.warning })
  highlight(0, 'BufferCurrent', { fg = colors.ui.foreground_primary, bg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentMod', { fg = colors.ui.accent })
end

-- Apply indent blankline highlights
M.apply_indent_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  if colors.extensions.indent then
    for i, color in ipairs(colors.extensions.indent) do
      highlight(0, 'IndentBlanklineIndent' .. i, { fg = color, nocombine = true })
    end
  end

  -- Context highlight
  highlight(0, 'IndentBlanklineContextChar', { fg = colors.ui.accent, nocombine = true })

  -- Context start/end
  highlight(0, 'IndentBlanklineContextStart', { bg = colors.extensions.diagnostic and colors.extensions.diagnostic.info_bg or colors.ui.background_secondary })
  highlight(0, 'IndentBlanklineContextEnd', { bg = colors.ui.background_secondary })
end

-- Apply git-blame highlights
M.apply_git_blame_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Custom highlight for git-blame virtual text
  -- Match cursorline background with comment foreground for readability
  highlight(0, 'GitBlameVirtualText', {
    bg = colors.ui.cursor_line,    -- Match cursorline background
    fg = colors.semantic.comment,  -- Use comment color for readability
    italic = true,                 -- Subtle styling to differentiate
  })
end

-- Apply all highlights for a theme
M.apply_highlights = function(theme)
  -- Apply only essential base highlights
  M.apply_essential_highlights(theme)

  -- Apply global bufferline highlights (from original rice.lua)
  M.apply_global_bufferline_highlights(theme)

  -- Apply theme-specific highlights
  if theme.name == 'dracula' then
    M.apply_dracula_highlights(theme)
  elseif theme.name == 'gruvbox' then
    M.apply_gruvbox_highlights(theme)
  elseif theme.name == 'solarized' then
    M.apply_solarized_highlights(theme)
  elseif theme.name == 'nord' then
    M.apply_nord_highlights(theme)
  end

  -- Apply essential plugin highlights
  M.apply_essential_plugin_highlights(theme)

  -- Apply git-blame highlights
  M.apply_git_blame_highlights(theme)

  -- Apply indent highlights (important for colored indent lines)
  M.apply_indent_highlights(theme)
end

-- Theme-specific highlight adjustments (matching original exactly)
M.apply_dracula_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Override CursorLine to match our theme's cursor_line color
  -- This ensures git-blame background matches the actual cursorline
  highlight(0, 'CursorLine', { bg = colors.ui.cursor_line })

  -- General configs (exact match to original)
  highlight(0, 'NonText', { fg = colors.ui.foreground_tertiary })
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })

  -- Indent lines (exact match to original)
  highlight(0, 'IndentBlanklineIndent1', { fg = '#7e444f' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#816e52' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#5a7051' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#396975' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#3f668c' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#714a83' })

  -- Git symbols at the side (exact match to original)
  highlight(0, 'SignifySignDelete', { fg = colors.semantic.error })
end

M.apply_gruvbox_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Indent lines (exact match to original)
  highlight(0, 'IndentBlanklineIndent1', { fg = '#864b4f' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#887652' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#617751' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#3f7077' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#456d8d' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#795184' })

  -- Cleaner visual (exact match to original)
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })
  highlight(0, 'SignColumn', { link = 'Normal' })
end

M.apply_solarized_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Indent blankline (exact match to original)
  highlight(0, 'IndentBlanklineContextChar', { fg = '#b1cc00' })
  highlight(0, 'IndentBlanklineIndent1', { fg = '#6e2f33' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#5b5a1b' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#43621b' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#156667' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#364e7d' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#6a315c' })

  
  -- Cleaner visual (exact match to original)
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })
  highlight(0, 'LineNr', { bg = colors.ui.background_primary })

  -- Git signs (exact match to original)
  highlight(0, 'GitSignsChange', { bg = colors.ui.background_primary, fg = colors.semantic.warning })
  highlight(0, 'GitSignsAdd', { bg = colors.ui.background_primary, fg = colors.semantic.string })
  highlight(0, 'GitSignsDelete', { bg = colors.ui.background_primary, fg = colors.semantic.error })
end

M.apply_nord_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Indent lines (exact match to original)
  highlight(0, 'IndentBlanklineIndent1', { fg = '#774b55' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#7f5e58' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#8d8066' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#697966' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#5b7a88' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#716177' })

  -- Nord-specific highlights (exact match to original)
  highlight(0, 'NonText', { fg = colors.ui.foreground_tertiary })
  highlight(0, 'Folded', { link = 'Visual' })

  -- Indent context (exact match to original)
  vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#88C0D0' })

  -- Visual and split (exact match to original)
  highlight(0, 'VertSplit', { bg = colors.ui.background_primary, fg = colors.ui.cursor_line })

  
  -- End of buffer (exact match to original)
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })
end

-- Legacy compatibility - return colors in old format
M.get_legacy_colors = function(theme)
  return theme.legacy
end

-- Setup fzf colors (for compatibility)
M.setup_fzf_colors = function(theme)
  local colors = theme

  vim.g['fzf_colors'] = {
    ['fg+'] = { 'fg', 'Normal', 'CursorColumn', 'Normal' },
    ['bg+'] = { 'bg', 'Normal', 'CursorColumn' },
    ['hl+'] = { 'fg', 'SpellLocal' },
    fg = { 'fg', 'Normal' },
    bg = { 'bg', 'Normal' },
    hl = { 'fg', 'Function' },
    info = { 'fg', 'PreProc' },
    border = { 'fg', 'Comment' },
    prompt = { 'fg', 'Function' },
    pointer = { 'fg', 'Exception' },
    marker = { 'fg', 'Keyword' },
    spinner = { 'fg', 'Label' },
    header = { 'fg', 'Comment' },
  }
end

return M