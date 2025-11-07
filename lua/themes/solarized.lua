-- Solarized theme implementation
-- Based on the Solarized colorscheme (dark variant)

local base = require('themes.base')

local solarized_config = {
  semantic = {
    foreground = '#839496',        -- Main text color
    background = '#002b36',        -- Main background
    comment = '#586e75',           -- Comments
    constant = '#d33682',          -- Constants, numbers
    function_name = '#859900',     -- Function names
    keyword = '#cb4b16',           -- Keywords, control structures
    string = '#2aa198',            -- String literals
    type = '#268bd2',              -- Type names
    variable = '#839496',          -- Variable names
    identifier = '#839496',        -- General identifiers
    operator = '#cb4b16',          -- Operators
    preproc = '#cb4b16',           -- Preprocessor directives
    special = '#d33682',           -- Special characters

    -- Diagnostic colors
    error = '#dc322f',             -- Error messages
    warning = '#b58900',           -- Warning messages
    info = '#2aa198',              -- Info messages
    hint = '#859900',              -- Hint messages
  },

  ui = {
    -- Background hierarchy
    background_primary = '#002b36',    -- Main editor background
    background_secondary = '#073642',  -- Secondary backgrounds
    background_tertiary = '#002129',   -- Tertiary backgrounds

    -- Foreground hierarchy
    foreground_primary = '#839496',    -- Main text
    foreground_secondary = '#586e75',  -- Secondary text
    foreground_tertiary = '#657b83',   -- Tertiary text (dimmed)

    -- Interactive elements
    accent = '#6c71c4',                -- Primary accent color
    accent_secondary = '#2aa198',      -- Secondary accent
    border = '#586e75',                -- Borders and separators
    selection = '#073642',             -- Text selection
    cursor_line = '#073642',           -- Cursor line highlight
    visual = '#073642',                -- Visual mode selection

    -- UI elements
    scrollbar = '#073642',             -- Scrollbar
    menu = '#002129',                  -- Menu background
    menu_select = '#073642',           -- Menu selection
    prompt = '#839496',                -- Prompt text
    match = '#6c71c4',                 -- Search match
  },

  git = {
    add = '#859900',                   -- Added lines
    change = '#b58900',                -- Changed lines
    delete = '#dc322f',                -- Deleted lines
    ignored = '#586e75',               -- Ignored files
    conflict = '#dc322f',              -- Merge conflicts
  },

  extensions = {
    -- Rainbow colors for indent guides and syntax
    rainbow = {
      '#dc322f', -- red
      '#cb4b16', -- orange
      '#b58900', -- yellow
      '#859900', -- green
      '#2aa198', -- cyan
      '#268bd2', -- blue
      '#6c71c4', -- violet
    },

    -- Indent line colors (subtle variations)
    indent = {
      '#6e2f33', -- red variant
      '#5b5a1b', -- orange variant
      '#43621b', -- green variant
      '#156667', -- cyan variant
      '#364e7d', -- blue variant
      '#6a315c', -- violet variant
    },

    -- Diagnostic-specific colors
    diagnostic = {
      error_bg = '#331517',    -- Subtle red background
      warning_bg = '#332915',  -- Subtle orange background
      info_bg = '#153333',     -- Subtle cyan background
      hint_bg = '#153329',     -- Subtle green background
    },
  },
}

return base.create('solarized', solarized_config)