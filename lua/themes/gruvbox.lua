-- Gruvbox theme implementation
-- Based on the Gruvbox colorscheme (dark variant)

local base = require('themes.base')

local gruvbox_config = {
  semantic = {
    foreground = '#ebdbb2',        -- Main text color
    background = '#282828',        -- Main background
    comment = '#928374',           -- Comments
    constant = '#d3869b',          -- Constants, numbers
    function_name = '#8ec07c',     -- Function names
    keyword = '#fb4934',           -- Keywords, control structures
    string = '#b8bb26',            -- String literals
    type = '#8ec07c',              -- Type names
    variable = '#ebdbb2',          -- Variable names
    identifier = '#ebdbb2',        -- General identifiers
    operator = '#fb4934',          -- Operators
    preproc = '#fb4934',           -- Preprocessor directives
    special = '#d3869b',           -- Special characters

    -- Diagnostic colors
    error = '#fb4934',             -- Error messages
    warning = '#fabd2f',           -- Warning messages
    info = '#83a598',              -- Info messages
    hint = '#8ec07c',              -- Hint messages
  },

  ui = {
    -- Background hierarchy
    background_primary = '#282828',    -- Main editor background
    background_secondary = '#3c3836',  -- Secondary backgrounds
    background_tertiary = '#1d2021',   -- Tertiary backgrounds

    -- Foreground hierarchy
    foreground_primary = '#ebdbb2',    -- Main text
    foreground_secondary = '#928374',  -- Secondary text
    foreground_tertiary = '#665c54',   -- Tertiary text (dimmed)

    -- Interactive elements
    accent = '#d3869b',                -- Primary accent color
    accent_secondary = '#83a598',      -- Secondary accent
    border = '#928374',                -- Borders and separators
    selection = '#3c3836',             -- Text selection
    cursor_line = '#32302f',           -- Cursor line highlight
    visual = '#3c3836',                -- Visual mode selection

    -- UI elements
    scrollbar = '#3c3836',             -- Scrollbar
    menu = '#1d2021',                  -- Menu background
    menu_select = '#3c3836',           -- Menu selection
    prompt = '#ebdbb2',                -- Prompt text
    match = '#d3869b',                 -- Search match
  },

  git = {
    add = '#8ec07c',                   -- Added lines
    change = '#fabd2f',                -- Changed lines
    delete = '#fb4934',                -- Deleted lines
    ignored = '#928374',               -- Ignored files
    conflict = '#fb4934',              -- Merge conflicts
  },

  extensions = {
    -- Rainbow colors for indent guides and syntax
    rainbow = {
      '#fb4934', -- red
      '#fe8019', -- orange
      '#fabd2f', -- yellow
      '#8ec07c', -- green
      '#83a598', -- cyan
      '#d3869b', -- purple
      '#d65d0e', -- deep orange
    },

    -- Indent line colors (subtle variations)
    indent = {
      '#864b4f', -- red variant
      '#887652', -- orange variant
      '#617751', -- green variant
      '#3f7077', -- cyan variant
      '#456d8d', -- blue variant
      '#795184', -- purple variant
    },

    -- Diagnostic-specific colors
    diagnostic = {
      error_bg = '#3d1e1e',    -- Subtle red background
      warning_bg = '#3d2d1a',  -- Subtle orange background
      info_bg = '#1a3d3d',     -- Subtle cyan background
      hint_bg = '#1a3d2e',     -- Subtle green background
    },
  },
}

return base.create('gruvbox', gruvbox_config)