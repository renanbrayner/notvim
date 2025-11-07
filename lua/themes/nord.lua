-- Nord theme implementation
-- Based on the Nord colorscheme

local base = require('themes.base')

local nord_config = {
  semantic = {
    foreground = '#D8DEE9',        -- Main text color
    background = '#2E3440',        -- Main background
    comment = '#616e88',           -- Comments
    constant = '#B48EAD',          -- Constants, numbers
    function_name = '#A3BE8C',     -- Function names
    keyword = '#81A1C1',           -- Keywords, control structures
    string = '#EBCB8B',            -- String literals
    type = '#8FBCBB',              -- Type names
    variable = '#D8DEE9',          -- Variable names
    identifier = '#D8DEE9',        -- General identifiers
    operator = '#81A1C1',          -- Operators
    preproc = '#81A1C1',           -- Preprocessor directives
    special = '#B48EAD',           -- Special characters

    -- Diagnostic colors
    error = '#BF616A',             -- Error messages
    warning = '#D08770',           -- Warning messages
    info = '#88C0D0',              -- Info messages
    hint = '#A3BE8C',              -- Hint messages
  },

  ui = {
    -- Background hierarchy
    background_primary = '#2E3440',    -- Main editor background
    background_secondary = '#3B4252',  -- Secondary backgrounds
    background_tertiary = '#242a33',   -- Tertiary backgrounds

    -- Foreground hierarchy
    foreground_primary = '#D8DEE9',    -- Main text
    foreground_secondary = '#616e88',  -- Secondary text
    foreground_tertiary = '#485164',   -- Tertiary text (dimmed)

    -- Interactive elements
    accent = '#B48EAD',                -- Primary accent color
    accent_secondary = '#88C0D0',      -- Secondary accent
    border = '#616e88',                -- Borders and separators
    selection = '#3B4252',             -- Text selection
    cursor_line = '#3B4252',           -- Cursor line highlight
    visual = '#3B4252',                -- Visual mode selection

    -- UI elements
    scrollbar = '#3B4252',             -- Scrollbar
    menu = '#242a33',                  -- Menu background
    menu_select = '#3B4252',           -- Menu selection
    prompt = '#D8DEE9',                -- Prompt text
    match = '#B48EAD',                 -- Search match
  },

  git = {
    add = '#A3BE8C',                   -- Added lines
    change = '#EBCB8B',                -- Changed lines
    delete = '#BF616A',                -- Deleted lines
    ignored = '#616e88',               -- Ignored files
    conflict = '#BF616A',              -- Merge conflicts
  },

  extensions = {
    -- Rainbow colors for indent guides and syntax
    rainbow = {
      '#BF616A', -- red
      '#D08770', -- orange
      '#EBCB8B', -- yellow
      '#A3BE8C', -- green
      '#88C0D0', -- cyan
      '#8FBCBB', -- blue
      '#B48EAD', -- purple
    },

    -- Indent line colors (subtle variations)
    indent = {
      '#774b55', -- red variant
      '#7f5e58', -- orange variant
      '#8d8066', -- yellow variant
      '#697966', -- green variant
      '#5b7a88', -- cyan variant
      '#716177', -- purple variant
    },

    -- Diagnostic-specific colors
    diagnostic = {
      error_bg = '#4b2e31',    -- Subtle red background
      warning_bg = '#4d3930',  -- Subtle orange background
      info_bg = '#2e4d4d',     -- Subtle cyan background
      hint_bg = '#2e4d32',     -- Subtle green background
    },
  },
}

return base.create('nord', nord_config)