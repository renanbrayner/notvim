-- Base theme system with inheritance
-- Provides semantic color names and structure for all themes

local BaseTheme = {
  -- Semantic colors (language elements)
  semantic = {
    foreground = nil,        -- Main text color
    background = nil,        -- Main background
    comment = nil,           -- Comments
    constant = nil,          -- Constants, numbers
    function_name = nil,     -- Function names
    keyword = nil,           -- Keywords, control structures
    string = nil,            -- String literals
    type = nil,              -- Type names
    variable = nil,          -- Variable names
    identifier = nil,        -- General identifiers
    operator = nil,          -- Operators
    preproc = nil,           -- Preprocessor directives
    special = nil,           -- Special characters

    -- Diagnostic colors
    error = nil,             -- Error messages
    warning = nil,           -- Warning messages
    info = nil,              -- Info messages
    hint = nil,              -- Hint messages
  },

  -- UI colors (interface elements)
  ui = {
    -- Background hierarchy
    background_primary = nil,    -- Main editor background
    background_secondary = nil,  -- Secondary backgrounds (sidebar, etc.)
    background_tertiary = nil,   -- Tertiary backgrounds (popup, etc.)

    -- Foreground hierarchy
    foreground_primary = nil,    -- Main text
    foreground_secondary = nil,  -- Secondary text
    foreground_tertiary = nil,   -- Tertiary text (dimmed)

    -- Interactive elements
    accent = nil,                -- Primary accent color
    accent_secondary = nil,      -- Secondary accent
    border = nil,                -- Borders and separators
    selection = nil,             -- Text selection
    cursor_line = nil,           -- Cursor line highlight
    visual = nil,                -- Visual mode selection

    -- UI elements
    scrollbar = nil,             -- Scrollbar
    menu = nil,                  -- Menu background
    menu_select = nil,           -- Menu selection
    prompt = nil,                -- Prompt text
    match = nil,                 -- Search match
  },

  -- Git colors
  git = {
    add = nil,                   -- Added lines
    change = nil,                -- Changed lines
    delete = nil,                -- Deleted lines
    ignored = nil,               -- Ignored files
    conflict = nil,              -- Merge conflicts
  },

  -- Syntax extensions (theme-specific)
  extensions = {
    rainbow = {},               -- Rainbow indent colors
    indent = {},                -- Indent line colors
    diagnostic = {},            -- Diagnostic-specific colors
  },

  -- Legacy color mappings (for backward compatibility)
  legacy = {
    fr = nil,   -- foreground
    cmt = nil,  -- comment
    cya = nil,  -- cyan
    grn = nil,  -- green
    org = nil,  -- orange
    pnk = nil,  -- pink
    pur = nil,  -- purple
    red = nil,  -- red
    ylw = nil,  -- yellow
    bg = nil,   -- background
    curli = nil, -- cursor line
    ntxt = nil,  -- non-text
    dark = nil,  -- dark background
    darker = nil, -- darker background
  }
}

-- Helper function to update legacy mappings
local function update_legacy_mappings(theme)
  theme.legacy.fr = theme.semantic.foreground
  theme.legacy.cmt = theme.semantic.comment
  theme.legacy.cya = theme.semantic.type or theme.semantic.identifier
  theme.legacy.grn = theme.semantic.string
  theme.legacy.org = theme.semantic.keyword or theme.semantic.function_name
  theme.legacy.pnk = theme.semantic.special or theme.semantic.identifier
  theme.legacy.pur = theme.semantic.constant or theme.semantic.type
  theme.legacy.red = theme.semantic.error
  theme.legacy.ylw = theme.semantic.warning

  theme.legacy.bg = theme.ui.background_primary
  theme.legacy.curli = theme.ui.cursor_line
  theme.legacy.ntxt = theme.ui.foreground_tertiary
  theme.legacy.dark = theme.ui.background_secondary
  theme.legacy.darker = theme.ui.background_tertiary
end

-- Theme constructor
local function create_theme(theme_name, theme_config)
  local theme = vim.deepcopy(BaseTheme)

  -- Apply theme-specific configuration
  theme = vim.tbl_extend('force', theme, theme_config)

  -- Set theme name
  theme.name = theme_name

  -- Update legacy mappings for backward compatibility
  update_legacy_mappings(theme)

  return theme
end

-- Export base theme and constructor
return {
  BaseTheme = BaseTheme,
  create = create_theme,
}