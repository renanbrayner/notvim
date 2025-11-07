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

-- Apply base highlights
M.apply_base_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Basic syntax highlighting
  highlight(0, 'Normal', { bg = colors.ui.background_primary, fg = colors.semantic.foreground })
  highlight(0, 'NormalFloat', { bg = colors.ui.background_secondary, fg = colors.semantic.foreground })
  highlight(0, 'FloatBorder', { bg = colors.ui.background_secondary, fg = colors.ui.border })

  -- Cursor and selection
  highlight(0, 'CursorLine', { bg = colors.ui.cursor_line })
  highlight(0, 'CursorLineNr', { bg = colors.ui.cursor_line, fg = colors.ui.foreground_primary })
  highlight(0, 'Visual', { bg = colors.ui.visual, reverse = true })
  highlight(0, 'VisualNOS', { bg = colors.ui.visual })

  -- Line numbers
  highlight(0, 'LineNr', { bg = colors.ui.background_primary, fg = colors.ui.foreground_tertiary })
  highlight(0, 'SignColumn', { bg = colors.ui.background_primary, fg = colors.ui.foreground_tertiary })

  -- Text elements
  highlight(0, 'Comment', { fg = colors.semantic.comment, italic = true })
  highlight(0, 'String', { fg = colors.semantic.string })
  highlight(0, 'Character', { fg = colors.semantic.string })
  highlight(0, 'Number', { fg = colors.semantic.constant })
  highlight(0, 'Boolean', { fg = colors.semantic.constant })
  highlight(0, 'Float', { fg = colors.semantic.constant })

  -- Functions and variables
  highlight(0, 'Function', { fg = colors.semantic.function_name })
  highlight(0, 'Identifier', { fg = colors.semantic.variable })
  highlight(0, 'Variable', { fg = colors.semantic.variable })

  -- Keywords and types
  highlight(0, 'Keyword', { fg = colors.semantic.keyword, bold = true })
  highlight(0, 'Type', { fg = colors.semantic.type })
  highlight(0, 'Structure', { fg = colors.semantic.type })
  highlight(0, 'StorageClass', { fg = colors.semantic.keyword })

  -- Operators and special
  highlight(0, 'Operator', { fg = colors.semantic.operator })
  highlight(0, 'Special', { fg = colors.semantic.special })

  -- Non-text elements
  highlight(0, 'NonText', { fg = colors.ui.foreground_tertiary })
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })
  highlight(0, 'Whitespace', { fg = colors.ui.foreground_tertiary })

  -- Separators
  highlight(0, 'VertSplit', { fg = colors.ui.border, bg = colors.ui.background_primary })
  highlight(0, 'WinSeparator', { fg = colors.ui.border, bg = colors.ui.background_primary })

  -- Search and matches
  highlight(0, 'Search', { bg = colors.ui.match, fg = colors.ui.background_primary })
  highlight(0, 'IncSearch', { bg = colors.ui.accent, fg = colors.ui.background_primary })
  highlight(0, 'MatchParen', { bg = colors.ui.accent, fg = colors.ui.background_primary, bold = true })

  -- Messages
  highlight(0, 'ErrorMsg', { fg = colors.semantic.error, bold = true })
  highlight(0, 'WarningMsg', { fg = colors.semantic.warning, bold = true })
  highlight(0, 'MoreMsg', { fg = colors.semantic.info })
  highlight(0, 'ModeMsg', { fg = colors.semantic.info })

  -- Status line
  highlight(0, 'StatusLine', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_primary })
  highlight(0, 'StatusLineNC', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_secondary })

  -- Tabs
  highlight(0, 'TabLine', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_secondary })
  highlight(0, 'TabLineFill', { bg = colors.ui.background_secondary, fg = colors.ui.background_secondary })
  highlight(0, 'TabLineSel', { bg = colors.ui.accent, fg = colors.ui.background_primary, bold = true })

  -- Menu
  highlight(0, 'Pmenu', { bg = colors.ui.menu, fg = colors.ui.foreground_primary })
  highlight(0, 'PmenuSel', { bg = colors.ui.menu_select, fg = colors.ui.foreground_primary })
  highlight(0, 'PmenuSbar', { bg = colors.ui.scrollbar })
  highlight(0, 'PmenuThumb', { bg = colors.ui.foreground_tertiary })
  highlight(0, 'PmenuKind', { bg = colors.ui.menu, fg = colors.semantic.type })

  -- Wild menu
  highlight(0, 'WildMenu', { bg = colors.ui.accent, fg = colors.ui.background_primary })

  -- Folds
  highlight(0, 'Folded', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_secondary })
  highlight(0, 'FoldColumn', { bg = colors.ui.background_primary, fg = colors.ui.foreground_tertiary })

  -- Diff
  highlight(0, 'DiffAdd', { bg = colors.git.add, fg = colors.semantic.foreground })
  highlight(0, 'DiffChange', { bg = colors.git.change, fg = colors.semantic.foreground })
  highlight(0, 'DiffDelete', { bg = colors.git.delete, fg = colors.semantic.foreground })
  highlight(0, 'DiffText', { bg = colors.git.change, fg = colors.semantic.foreground, bold = true })

  -- Spell
  highlight(0, 'SpellBad', { fg = colors.semantic.error, undercurl = true })
  highlight(0, 'SpellCap', { fg = colors.semantic.warning, undercurl = true })
  highlight(0, 'SpellLocal', { fg = colors.semantic.info, undercurl = true })
  highlight(0, 'SpellRare', { fg = colors.semantic.hint, undercurl = true })

  -- Conceal
  highlight(0, 'Conceal', { fg = colors.ui.foreground_tertiary })
end

-- Apply plugin-specific highlights
M.apply_plugin_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Bufferline highlights
  M.apply_bufferline_highlights(theme)

  -- Rainbow highlights
  if colors.extensions.rainbow then
    for i, color in ipairs(colors.extensions.rainbow) do
      highlight(0, 'rainbowcol' .. i, { fg = color })
    end
  end

  -- Indent blankline highlights
  M.apply_indent_highlights(theme)

  -- Git signs highlights
  highlight(0, 'GitSignsAdd', { fg = colors.git.add, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsChange', { fg = colors.git.change, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsDelete', { fg = colors.git.delete, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsAddNr', { fg = colors.git.add, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsChangeNr', { fg = colors.git.change, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsDeleteNr', { fg = colors.git.delete, bg = colors.ui.background_primary })

  -- Telescope highlights
  highlight(0, 'TelescopeNormal', { bg = colors.ui.background_primary, fg = colors.ui.foreground_primary })
  highlight(0, 'TelescopeBorder', { bg = colors.ui.background_primary, fg = colors.ui.border })
  highlight(0, 'TelescopePromptTitle', { bg = colors.ui.accent, fg = colors.ui.background_primary, bold = true })
  highlight(0, 'TelescopeResultsTitle', { bg = colors.ui.accent, fg = colors.ui.background_primary, bold = true })
  highlight(0, 'TelescopePreviewTitle', { bg = colors.ui.accent, fg = colors.ui.background_primary, bold = true })
  highlight(0, 'TelescopeSelection', { bg = colors.ui.selection, fg = colors.ui.foreground_primary })
  highlight(0, 'TelescopeSelectionCaret', { fg = colors.ui.accent, bg = colors.ui.selection })
  highlight(0, 'TelescopeMatching', { fg = colors.ui.accent, bold = true })

  -- Which-key highlights
  highlight(0, 'WhichKeyFloat', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_primary })
  highlight(0, 'WhichKeyBorder', { bg = colors.ui.background_secondary, fg = colors.ui.border })
  highlight(0, 'WhichKeyGroup', { fg = colors.ui.accent, bold = true })
  highlight(0, 'WhichKeySeparator', { fg = colors.ui.foreground_secondary })
  highlight(0, 'WhichKeyDesc', { fg = colors.ui.foreground_primary })

  -- QuickScope highlights
  highlight(0, 'QuickScopePrimary', { fg = colors.ui.accent, underline = true })
  highlight(0, 'QuickScopeSecondary', { fg = colors.ui.accent_secondary, underline = true })
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

-- Apply all highlights for a theme
M.apply_highlights = function(theme)
  -- Apply base highlights
  M.apply_base_highlights(theme)

  -- Apply plugin-specific highlights
  M.apply_plugin_highlights(theme)

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
end

-- Theme-specific highlight adjustments
M.apply_dracula_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Dracula-specific adjustments
  highlight(0, 'NonText', { fg = colors.ui.foreground_tertiary })
  highlight(0, 'SignifySignDelete', { fg = colors.semantic.error })
end

M.apply_gruvbox_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Gruvbox-specific adjustments
  highlight(0, 'SignColumn', { link = 'Normal' })
end

M.apply_solarized_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Solarized-specific adjustments
  highlight(0, 'LineNr', { bg = colors.ui.background_primary })
  highlight(0, 'IndentBlanklineContextChar', { fg = '#b1cc00' })
  highlight(0, 'QuickScopeSecondary', { link = 'ReplaceMode' })
  highlight(0, 'QuickScopePrimary', { link = 'InsertMode' })
end

M.apply_nord_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Nord-specific adjustments
  highlight(0, 'NonText', { fg = colors.ui.foreground_tertiary })
  highlight(0, 'Folded', { link = 'Visual' })
  highlight(0, 'VertSplit', { bg = colors.ui.background_primary, fg = colors.ui.cursor_line })
  highlight(0, 'QuickScopeSecondary', { link = 'LeapLabelPrimary' })
  highlight(0, 'QuickScopePrimary', { link = 'LeapLabelPrimary' })
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