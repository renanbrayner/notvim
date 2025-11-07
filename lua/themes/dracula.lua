-- Dracula theme implementation
-- Based on the original Dracula colorscheme

local base = require('themes.base')

local dracula_config = {
  semantic = {
    foreground = '#f8f8f2',        -- Main text color
    background = '#282a37',        -- Main background
    comment = '#6272a4',           -- Comments
    constant = '#bd93f9',          -- Constants, numbers
    function_name = '#50fa7b',     -- Function names
    keyword = '#ff79c6',           -- Keywords, control structures
    string = '#f1fa8c',            -- String literals
    type = '#8be9fd',              -- Type names
    variable = '#f8f8f2',          -- Variable names
    identifier = '#f8f8f2',        -- General identifiers
    operator = '#ff79c6',          -- Operators
    preproc = '#ff79c6',           -- Preprocessor directives
    special = '#ff79c6',           -- Special characters

    -- Diagnostic colors
    error = '#ff5555',             -- Error messages
    warning = '#ffb86c',           -- Warning messages
    info = '#8be9fd',              -- Info messages
    hint = '#50fa7b',              -- Hint messages
  },

  ui = {
    -- Background hierarchy
    background_primary = '#282a37',    -- Main editor background
    background_secondary = '#44475a',  -- Secondary backgrounds
    background_tertiary = '#1c1d26',   -- Tertiary backgrounds

    -- Foreground hierarchy
    foreground_primary = '#f8f8f2',    -- Main text
    foreground_secondary = '#6272a4',  -- Secondary text
    foreground_tertiary = '#6272a4',   -- Tertiary text (dimmed)

    -- Interactive elements
    accent = '#bd93f9',                -- Primary accent color
    accent_secondary = '#8be9fd',      -- Secondary accent
    border = '#6272a4',                -- Borders and separators
    selection = '#44475a',             -- Text selection
    cursor_line = '#363847',           -- Cursor line highlight
    visual = '#44475a',                -- Visual mode selection

    -- UI elements
    scrollbar = '#44475a',             -- Scrollbar
    menu = '#1c1d26',                  -- Menu background
    menu_select = '#44475a',           -- Menu selection
    prompt = '#f8f8f2',                -- Prompt text
    match = '#bd93f9',                 -- Search match
  },

  git = {
    add = '#50fa7b',                   -- Added lines
    change = '#f1fa8c',                -- Changed lines
    delete = '#ff5555',                -- Deleted lines
    ignored = '#6272a4',               -- Ignored files
    conflict = '#ff5555',              -- Merge conflicts
  },

  extensions = {
    -- Rainbow colors for indent guides and syntax
    rainbow = {
      '#ff5555', -- red
      '#ffb86c', -- orange
      '#f1fa8c', -- yellow
      '#50fa7b', -- green
      '#8be9fd', -- cyan
      '#bd93f9', -- purple
      '#ff79c6', -- pink
    },

    -- Indent line colors (subtle variations)
    indent = {
      '#7e444f', -- red variant
      '#816e52', -- orange variant
      '#5a7051', -- green variant
      '#396975', -- cyan variant
      '#3f668c', -- blue variant
      '#714a83', -- purple variant
    },

    -- Diagnostic-specific colors
    diagnostic = {
      error_bg = '#3d1f1f',    -- Subtle red background
      warning_bg = '#3d2e1a',  -- Subtle orange background
      info_bg = '#1a3d3d',     -- Subtle cyan background
      hint_bg = '#1a3d2e',     -- Subtle green background
    },
  },
}

return base.create('dracula', dracula_config)