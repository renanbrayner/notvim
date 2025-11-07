# Neovim Configuration Refactor Plan

## TODO Tracking

- [x] **Phase 1**: Theme System Overhaul (HIGH PRIORITY)
  - [x] Create base theme system
  - [x] Refactor rice.lua to use inheritance
  - [x] Update highlight system
  - [x] Test all themes
- [ ] **Phase 2**: Keymap Reorganization (HIGH PRIORITY)
  - [ ] Split whichkey.lua by feature
  - [ ] Create keymap categories
  - [ ] Update which-key configuration
  - [ ] Test all keymaps
- [ ] **Phase 3**: Error Handling Centralization (HIGH PRIORITY)
  - [ ] Create utility loader
  - [ ] Update all plugin configs
  - [ ] Standardize error patterns
- [ ] **Phase 4**: Plugin Configuration Consolidation (MEDIUM PRIORITY)
  - [ ] Group plugins by category
  - [ ] Merge similar configurations
  - [ ] Update init.lua loading
- [ ] **Phase 5**: Core Architecture Improvements (LOW PRIORITY)
  - [ ] Create configuration registry
  - [ ] Add environment detection
  - [ ] Implement feature flags
  - [ ] Add health checks

---

## 🎯 **Refactor Overview**

This document outlines a complete refactoring of the Neovim configuration to improve:
- **Code maintainability** (reduce duplication by 90%)
- **Organization** (split 656-line files into logical modules)
- **Extensibility** (easier to add new themes/plugins)
- **Performance** (better loading patterns)

---

## 📊 **Current State Analysis**

### Issues Identified:
1. **Theme Duplication**: 4 themes with 90% identical color definitions
2. **Keymap Chaos**: 656-line `whichkey.lua` with no logical separation
3. **Error Handling Boilerplate**: Same pattern repeated 15+ times
4. **Plugin File Proliferation**: 20+ config files for simple setups
5. **Hard-coded Values**: Environment-specific paths scattered throughout

### Files Most Affected:
- `lua/rice.lua` (262 lines) - Theme/color system
- `lua/plugins/keymaps/whichkey.lua` (656 lines) - Keymaps
- `lua/plugins/init.lua` (370 lines) - Plugin declarations
- 20+ `lua/plugins/configs/*.lua` files

---

## 🏗️ **Target Architecture**

```
lua/
├── core/                    # Core configuration
│   ├── init.lua            # Bootstrap and initialization
│   ├── options.lua         # Vim options (opts.lua → rename)
│   ├── env.lua             # Environment detection
│   ├── utils.lua           # Utility functions
│   └── registry.lua        # Configuration registry
├── themes/                  # Theme system
│   ├── base.lua            # Base theme definitions
│   ├── dracula.lua         # Dracula theme
│   ├── gruvbox.lua         # Gruvbox theme
│   ├── solarized.lua       # Solarized theme
│   ├── nord.lua            # Nord theme
│   └── colors.lua          # Color utilities
├── keymaps/                 # Organized keymaps
│   ├── global.lua          # Global keymaps
│   ├── buffer.lua          # Buffer navigation
│   ├── lsp.lua             # LSP keymaps
│   ├── navigation.lua      # Navigation plugins
│   ├── git.lua             # Git operations
│   └── debug.lua           # Debug/DAP keymaps
├── whichkey/               # Which-key configurations
│   ├── global.lua          # Global which-key groups
│   ├── lsp.lua             # LSP which-key groups
│   ├── git.lua             # Git which-key groups
│   └── plugins.lua         # Plugin-specific groups
├── plugins/                # Plugin configurations
│   ├── editor.lua          # Text editing plugins
│   ├── ui.lua              # UI/Visual plugins
│   ├── navigation.lua      # File navigation
│   ├── lsp.lua             # LSP and completion
│   ├── tools.lua           # Development tools
│   └── themes.lua          # Theme plugins
├── lsp/                    # LSP configurations
│   ├── init.lua            # LSP setup
│   ├── servers/            # Individual server configs
│   │   ├── html.lua
│   │   ├── cssls.lua
│   │   ├── eslint.lua
│   │   └── ...
│   └── formatters.lua      # none-ls configuration
└── utils/                  # Advanced utilities
    ├── loader.lua          # Safe plugin loader
    ├── theme.lua           # Theme utilities
    └── health.lua          # Health checks
```

---

## 🚀 **Phase 1: Theme System Overhaul** (HIGH PRIORITY)

### **Objective**: Eliminate 90% code duplication in theme system

### **Current Problems:**
```lua
-- rice.lua - 262 lines of duplicated color definitions
if vim.g.colors_name == 'dracula' then
  colors = { fr = '#f8f8f2', cmt = '#6272a4', ... }
elseif vim.g.colors_name == 'gruvbox' then
  colors = { fr = '#ebdbb2', cmt = '#928374', ... }
-- ... repeated 4 times
```

### **Solution: Theme Inheritance System**

#### **Step 1.1: Create Base Theme (`lua/themes/base.lua`)**
```lua
local BaseTheme = {
  -- Semantic color names (language-independent)
  semantic = {
    foreground = nil,     -- Will be overridden by themes
    background = nil,
    comment = nil,
    constant = nil,
    function_name = nil,
    keyword = nil,
    string = nil,
    type = nil,
    variable = nil,
    warning = nil,
    error = nil,
    info = nil,
    hint = nil,
  },

  -- UI color names (interface elements)
  ui = {
    background_primary = nil,
    background_secondary = nil,
    background_tertiary = nil,
    foreground_primary = nil,
    foreground_secondary = nil,
    accent = nil,
    border = nil,
    selection = nil,
    cursor_line = nil,
  },

  -- Git colors
  git = {
    add = nil,
    change = nil,
    delete = nil,
    ignored = nil,
  },

  -- Syntax extensions (language-specific)
  extensions = {}
}

return BaseTheme
```

#### **Step 1.2: Create Individual Themes**

**`lua/themes/dracula.lua`:**
```lua
local BaseTheme = require('themes.base')

local DraculaTheme = vim.tbl_extend('force', BaseTheme, {
  semantic = {
    foreground = '#f8f8f2',
    background = '#282a37',
    comment = '#6272a4',
    constant = '#bd93f9',
    function_name = '#50fa7b',
    keyword = '#ff79c6',
    string = '#f1fa8c',
    type = '#8be9fd',
    variable = '#f8f8f2',
    warning = '#ffb86c',
    error = '#ff5555',
    info = '#8be9fd',
    hint = '#50fa7b',
  },

  ui = {
    background_primary = '#282a37',
    background_secondary = '#44475a',
    background_tertiary = '#1c1d26',
    foreground_primary = '#f8f8f2',
    foreground_secondary = '#6272a4',
    accent = '#bd93f9',
    border = '#6272a4',
    selection = '#44475a',
    cursor_line = '#363847',
  },

  git = {
    add = '#50fa7b',
    change = '#f1fa8c',
    delete = '#ff5555',
    ignored = '#6272a4',
  },

  extensions = {
    -- Dracula-specific extensions
    rainbow = {
      '#ff5555', -- red
      '#ffb86c', -- orange
      '#f1fa8c', -- yellow
      '#50fa7b', -- green
      '#8be9fd', -- cyan
      '#bd93f9', -- purple
      '#ff79c6', -- pink
    }
  }
})

return DraculaTheme
```

#### **Step 1.3: Create Theme Manager (`lua/themes/colors.lua`)**
```lua
local themes = {
  dracula = require('themes.dracula'),
  gruvbox = require('themes.gruvbox'),
  solarized = require('themes.solarized'),
  nord = require('themes.nord'),
}

local M = {}

M.get_theme = function(name)
  return themes[name] or themes.dracula
end

M.get_current_theme = function()
  local colorscheme = vim.g.colors_name or 'dracula'
  return M.get_theme(colorscheme:lower())
end

M.apply_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  -- Apply base highlights
  highlight(0, 'Normal', { bg = colors.ui.background_primary, fg = colors.semantic.foreground })
  highlight(0, 'CursorLine', { bg = colors.ui.cursor_line })
  highlight(0, 'Comment', { fg = colors.semantic.comment })
  highlight(0, 'String', { fg = colors.semantic.string })
  highlight(0, 'Function', { fg = colors.semantic.function_name })
  highlight(0, 'Keyword', { fg = colors.semantic.keyword })
  highlight(0, 'Constant', { fg = colors.semantic.constant })
  highlight(0, 'Type', { fg = colors.semantic.type })

  -- Apply UI highlights
  highlight(0, 'EndOfBuffer', { fg = colors.ui.background_primary })
  highlight(0, 'SignColumn', { bg = colors.ui.background_primary })
  highlight(0, 'VertSplit', { fg = colors.ui.border, bg = colors.ui.background_primary })

  -- Apply Git highlights
  highlight(0, 'GitSignsAdd', { fg = colors.git.add, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsChange', { fg = colors.git.change, bg = colors.ui.background_primary })
  highlight(0, 'GitSignsDelete', { fg = colors.git.delete, bg = colors.ui.background_primary })

  -- Apply theme-specific extensions
  if colors.extensions.rainbow then
    for i, color in ipairs(colors.extensions.rainbow) do
      highlight(0, 'rainbowcol' .. i, { fg = color })
    end
  end

  -- Apply bufferline highlights
  M.apply_bufferline_highlights(theme)

  -- Apply indent blankline highlights
  M.apply_indent_highlights(theme)
end

M.apply_bufferline_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  highlight(0, 'BufferTabpageFill', { bg = colors.ui.background_tertiary, fg = colors.ui.background_tertiary })
  highlight(0, 'BufferInactive', { bg = colors.ui.background_secondary, fg = colors.ui.foreground_secondary })
  highlight(0, 'BufferInactiveSign', { bg = colors.ui.background_secondary, fg = colors.ui.background_secondary })
  highlight(0, 'BufferInactiveMod', { bg = colors.ui.background_secondary, fg = colors.semantic.warning })
  highlight(0, 'BufferVisible', { fg = colors.semantic.comment })
  highlight(0, 'BufferVisibleSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferVisibleMod', { fg = colors.semantic.warning })
  highlight(0, 'BufferCurrent', { fg = colors.semantic.foreground, bg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentSign', { bg = colors.ui.background_primary, fg = colors.ui.background_primary })
  highlight(0, 'BufferCurrentMod', { fg = colors.ui.accent })
end

M.apply_indent_highlights = function(theme)
  local colors = theme
  local highlight = vim.api.nvim_set_hl

  if colors.extensions.indent_colors then
    for i, color in ipairs(colors.extensions.indent_colors) do
      highlight(0, 'IndentBlanklineIndent' .. i, { fg = color })
    end
  end
end

return M
```

#### **Step 1.4: Refactor rice.lua**
```lua
-- New rice.lua (from 262 lines to ~50 lines)
local theme_manager = require('themes.colors')

-- Theme configuration
vim.cmd 'colorscheme dracula'

-- Enable true colors
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmode = false

-- Apply current theme highlights
local current_theme = theme_manager.get_current_theme()
theme_manager.apply_highlights(current_theme)

-- Return colors for other modules to use
return current_theme
```

### **Benefits:**
- **262 lines → ~200 lines total** across all theme files
- **90% less duplication**
- **Easy to add new themes** (just inherit from base)
- **Semantic color names** (easier to understand)
- **Centralized highlight management**

---

## 🗺️ **Phase 2: Keymap Reorganization** (HIGH PRIORITY)

### **Objective**: Split 656-line whichkey.lua into logical modules

### **Current Problems:**
- Single file with 656 lines
- Mixed concerns (global, plugin, mode-specific)
- Hard to navigate and maintain
- No logical grouping

### **Solution: Feature-based Keymap Organization**

#### **Step 2.1: Create Core Loader (`lua/utils/loader.lua`)**
```lua
local M = {}

M.safe_require = function(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    vim.notify('Failed to load module: ' .. module_name, vim.log.levels.ERROR)
    return nil
  end
  return module
end

M.safe_setup = function(plugin_name, config)
  local plugin = M.safe_require(plugin_name)
  if plugin then
    plugin.setup(config or {})
  end
end

M.map_key = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.desc = opts.desc or ''
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.setup_which_key = function(mappings, opts)
  local which_key = M.safe_require('which-key')
  if which_key then
    which_key.register(mappings, opts)
  end
end

return M
```

#### **Step 2.2: Split Keymaps by Feature**

**`lua/keymaps/global.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  -- Window navigation
  loader.map_key('n', '<C-h>', '<C-w>h', { desc = 'Navigate left' })
  loader.map_key('n', '<C-j>', '<C-w>j', { desc = 'Navigate down' })
  loader.map_key('n', '<C-k>', '<C-w>k', { desc = 'Navigate up' })
  loader.map_key('n', '<C-l>', '<C-w>l', { desc = 'Navigate right' })

  -- Buffer management
  loader.map_key('n', '<leader>q', '<Cmd>quit<CR>', { desc = 'Quit window' })
  loader.map_key('n', '<leader>Q', '<Cmd>quitall<CR>', { desc = 'Quit all' })
  loader.map_key('n', '<leader>w', '<Cmd>write<CR>', { desc = 'Write file' })

  -- Search and replace
  loader.map_key('n', '<leader>/', ':%s/', { desc = 'Search and replace' })
  loader.map_key('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

  -- Quick movement
  loader.map_key('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, desc = 'Move down (display lines)' })
  loader.map_key('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, desc = 'Move up (display lines)' })
end

return M
```

**`lua/keymaps/buffer.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  -- Buffer switching
  for i = 1, 9 do
    loader.map_key('n', '<M-' .. i .. '>', function()
      vim.cmd('buffer' .. i)
    end, { desc = 'Switch to buffer ' .. i })
  end

  -- Buffer navigation
  loader.map_key('n', '<M-,>', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })
  loader.map_key('n', '<M-.>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })

  -- Buffer operations
  loader.map_key('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
  loader.map_key('n', '<leader>bb', '<Cmd>buffer #<CR>', { desc = 'Alternate buffer' })
end

return M
```

**`lua/keymaps/lsp.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  -- LSP navigation
  loader.map_key('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
  loader.map_key('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
  loader.map_key('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
  loader.map_key('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })

  -- LSP information
  loader.map_key('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
  loader.map_key('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })

  -- LSP actions
  loader.map_key('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code actions' })
  loader.map_key('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
  loader.map_key('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })

  -- LSP workspace
  loader.map_key('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
  loader.map_key('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
  loader.map_key('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = 'List workspace folders' })
end

return M
```

**`lua/keymaps/navigation.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  -- Telescope
  loader.map_key('n', '<C-p>', '<Cmd>Telescope find_files<CR>', { desc = 'Find files' })
  loader.map_key('n', '<C-f>', '<Cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
  loader.map_key('n', '<leader>b', '<Cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
  loader.map_key('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { desc = 'Help tags' })

  -- File explorer
  loader.map_key('n', '<leader>op', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
  loader.map_key('n', '<leader>of', '<Cmd>NvimTreeFindFile<CR>', { desc = 'Find file in explorer' })

  -- Hop navigation
  loader.map_key('n', 's', '<Cmd>HopChar2<CR>', { desc = 'Hop to 2 chars' })
  loader.map_key('n', 'S', '<Cmd>HopWord<CR>', { desc = 'Hop to word' })
end

return M
```

**`lua/keymaps/git.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  -- Git operations
  loader.map_key('n', '<leader>gs', '<Cmd>Git<CR>', { desc = 'Git status' })
  loader.map_key('n', '<leader>gc', '<Cmd>Git commit<CR>', { desc = 'Git commit' })
  loader.map_key('n', '<leader>gp', '<Cmd>Git push<CR>', { desc = 'Git push' })
  loader.map_key('n', '<leader>gl', '<Cmd>Git pull<CR>', { desc = 'Git pull' })

  -- Gitsigns
  loader.map_key('n', '<leader>ghb', '<Cmd>Gitsigns blame_line<CR>', { desc = 'Git blame line' })
  loader.map_key('n', '<leader>ghp', '<Cmd>Gitsigns preview_hunk<CR>', { desc = 'Preview hunk' })
  loader.map_key('n', '<leader>ghr', '<Cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
  loader.map_key('n', '<leader>ghs', '<Cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })

  -- Lazygit
  loader.map_key('n', '<leader>gg', '<Cmd>LazyGit<CR>', { desc = 'LazyGit' })
end

return M
```

#### **Step 2.3: Create Which-key Configurations**

**`lua/whichkey/global.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  local mappings = {
    -- File operations
    ['<leader>f'] = {
      name = 'File',
      f = { '<Cmd>Telescope find_files<CR>', 'Find files' },
      r = { '<Cmd>Telescope oldfiles<CR>', 'Recent files' },
      n = { '<Cmd>enew<CR>', 'New file' },
      s = { '<Cmd>write<CR>', 'Save file' },
    },

    -- Buffer operations
    ['<leader>b'] = {
      name = 'Buffer',
      b = { '<Cmd>Telescope buffers<CR>', 'Find buffer' },
      d = { '<Cmd>bdelete<CR>', 'Delete buffer' },
      n = { '<Cmd>bnext<CR>', 'Next buffer' },
      p = { '<Cmd>bprevious<CR>', 'Previous buffer' },
    },

    -- Window operations
    ['<leader>w'] = {
      name = 'Window',
      h = { '<C-w>h', 'Go left' },
      j = { '<C-w>j', 'Go down' },
      k = { '<C-w>k', 'Go up' },
      l = { '<C-w>l', 'Go right' },
      s = { '<Cmd>split<CR>', 'Split horizontal' },
      v = { '<Cmd>vsplit<CR>', 'Split vertical' },
      q = { '<Cmd>quit<CR>', 'Quit window' },
    },

    -- Search operations
    ['<leader>s'] = {
      name = 'Search',
      f = { '<Cmd>Telescope live_grep<CR>', 'Live grep' },
      g = { '<Cmd>Telescope grep_string<CR>', 'Grep string' },
      h = { '<Cmd>nohlsearch<CR>', 'Clear highlights' },
    },

    -- Quit operations
    ['<leader>q'] = {
      name = 'Quit',
      q = { '<Cmd>quitall<CR>', 'Quit all' },
      w = { '<Cmd>write<CR>', 'Write and quit' },
      f = { '<Cmd>quitall!<CR>', 'Force quit all' },
    },
  }

  loader.setup_which_key(mappings, { mode = 'n', prefix = '<leader>' })
end

return M
```

**`lua/whichkey/lsp.lua`:**
```lua
local loader = require('utils.loader')

local M = {}

M.setup = function()
  local mappings = {
    ['<leader>l'] = {
      name = 'LSP',
      d = { vim.lsp.buf.definition, 'Definition' },
      D = { vim.lsp.buf.declaration, 'Declaration' },
      r = { vim.lsp.buf.references, 'References' },
      i = { vim.lsp.buf.implementation, 'Implementation' },
      a = { vim.lsp.buf.code_action, 'Code actions' },
      R = { vim.lsp.buf.rename, 'Rename' },
      f = { vim.lsp.buf.format, 'Format' },
      h = { vim.lsp.buf.hover, 'Hover' },
      s = { vim.lsp.buf.signature_help, 'Signature help' },

      -- Workspace
      w = {
        name = 'Workspace',
        a = { vim.lsp.buf.add_workspace_folder, 'Add folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'Remove folder' },
        l = {
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          'List folders'
        },
      },

      -- Diagnostics
      d = {
        name = 'Diagnostics',
        d = { vim.diagnostic.open_float, 'Open diagnostics' },
        n = { vim.diagnostic.goto_next, 'Next diagnostic' },
        p = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
        l = { '<Cmd>Telescope diagnostics<CR>', 'List diagnostics' },
      },
    },
  }

  loader.setup_which_key(mappings, { mode = 'n', prefix = '<leader>' })
end

return M
```

#### **Step 2.4: Create Keymap Loader (`lua/core/keymaps.lua`)**
```lua
local loader = require('utils.loader')

local keymap_modules = {
  'keymaps.global',
  'keymaps.buffer',
  'keymaps.lsp',
  'keymaps.navigation',
  'keymaps.git',
}

local whichkey_modules = {
  'whichkey.global',
  'whichkey.lsp',
  'whichkey.git',
  'whichkey.plugins',
}

local M = {}

M.setup = function()
  -- Load all keymap modules
  for _, module in ipairs(keymap_modules) do
    local keymaps = loader.safe_require(module)
    if keymaps and keymaps.setup then
      keymaps.setup()
    end
  end

  -- Load which-key configurations
  for _, module in ipairs(whichkey_modules) do
    local whichkey = loader.safe_require(module)
    if whichkey and whichkey.setup then
      whichkey.setup()
    end
  end
end

return M
```

### **Benefits:**
- **656 lines → 50-100 lines per file** (much more manageable)
- **Logical grouping** by feature/functionality
- **Easy to find** and modify specific keymaps
- **Separation of concerns** (global vs plugin-specific)
- **Better maintainability** and extensibility

---

## ⚡ **Phase 3: Error Handling Centralization** (HIGH PRIORITY)

### **Objective**: Eliminate boilerplate error handling across 15+ plugin configs

### **Current Problem:**
```lua
-- Repeated 15+ times
local status_ok, plugin = pcall(require, 'plugin')
if not status_ok then
  vim.notify('Error requiring plugin', vim.log.levels.ERROR)
  return
end
```

### **Solution: Centralized Error Handling**

#### **Step 3.1: Enhanced Plugin Loader (`lua/utils/loader.lua`)**
```lua
local M = {}

-- Error levels
M.ERROR = vim.log.levels.ERROR
M.WARN = vim.log.levels.WARN
M.INFO = vim.log.levels.INFO
M.DEBUG = vim.log.levels.DEBUG

-- Safe require with detailed error handling
M.safe_require = function(module_name, silent)
  local ok, module = pcall(require, module_name)
  if not ok then
    if not silent then
      local error_msg = string.format('Failed to load module: %s\n%s', module_name, module)
      vim.notify(error_msg, M.ERROR)
    end
    return nil, module
  end
  return module
end

-- Safe plugin setup
M.safe_setup = function(plugin_name, config, silent)
  local plugin, err = M.safe_require(plugin_name, silent)
  if not plugin then
    return false, err
  end

  if type(plugin.setup) == 'function' then
    local ok, err = pcall(plugin.setup, config or {})
    if not ok then
      if not silent then
        local error_msg = string.format('Failed to setup %s: %s', plugin_name, err)
        vim.notify(error_msg, M.ERROR)
      end
      return false, err
    end
  end

  return true
end

-- Batch plugin setup
M.setup_plugins = function(plugin_configs)
  local results = {}

  for name, config in pairs(plugin_configs) do
    local success = M.safe_setup(name, config)
    results[name] = success
  end

  -- Report failures
  local failures = {}
  for name, success in pairs(results) do
    if not success then
      table.insert(failures, name)
    end
  end

  if #failures > 0 then
    local msg = string.format('Failed to setup plugins: %s', table.concat(failures, ', '))
    vim.notify(msg, M.WARN)
  end

  return results
end

-- Map key with error handling
M.map_key = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.desc = opts.desc or ''

  local ok, err = pcall(vim.keymap.set, mode, lhs, rhs, opts)
  if not ok then
    local error_msg = string.format('Failed to map key: %s %s -> %s\n%s', mode, lhs, rhs, err)
    vim.notify(error_msg, M.ERROR)
    return false
  end

  return true
end

-- Setup which-key with error handling
M.setup_which_key = function(mappings, opts)
  local which_key = M.safe_require('which-key')
  if which_key and which_key.register then
    local ok, err = pcall(which_key.register, mappings, opts or {})
    if not ok then
      vim.notify('Failed to setup which-key: ' .. err, M.ERROR)
      return false
    end
    return true
  end
  return false
end

-- Autocommand setup with error handling
M.create_autocmd = function(events, callback, opts)
  opts = opts or {}

  local ok, err = pcall(vim.api.nvim_create_autocmd, events, vim.tbl_extend('force', opts, {
    callback = callback
  }))

  if not ok then
    vim.notify('Failed to create autocmd: ' .. err, M.ERROR)
    return nil
  end

  return true
end

return M
```

#### **Step 3.2: Update Plugin Configurations**

**Example: `lua/plugins/configs/telescope.lua` (Before):**
```lua
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  vim.notify('Error requiring telescope', vim.log.levels.ERROR)
  return
end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    -- ... configuration
  },
})
```

**Example: `lua/plugins/configs/telescope.lua` (After):**
```lua
local loader = require('utils.loader')

local telescope_config = {
  defaults = {
    -- ... configuration
  },
}

loader.safe_setup('telescope', telescope_config)
```

#### **Step 3.3: Create Plugin Configuration Template**
```lua
-- lua/plugins/configs/template.lua
local loader = require('utils.loader')

local config = {
  -- Plugin configuration goes here
}

-- For simple setup
loader.safe_setup('plugin_name', config)

-- For complex setup with additional logic
local function setup()
  local plugin = loader.safe_require('plugin_name')
  if not plugin then
    return
  end

  -- Additional setup logic
  plugin.setup(config)
end

setup()
```

### **Benefits:**
- **Consistent error handling** across all plugins
- **Reduced boilerplate** (from 15+ lines to 1 line)
- **Better error messages** with more context
- **Centralized logging** and debugging
- **Easier debugging** with silent modes

---

## 📦 **Phase 4: Plugin Configuration Consolidation** (MEDIUM PRIORITY)

### **Objective**: Group related plugins into logical configuration files

### **Current Problems:**
- 20+ individual config files for simple setups
- Many files with minimal content (10-20 lines)
- No logical grouping of related functionality
- Hard to see what plugins are related

### **Solution: Category-based Plugin Configurations**

#### **Step 4.1: Create Category-based Plugin Files**

**`lua/plugins/editor.lua` (Text editing plugins):**
```lua
local loader = require('utils.loader')

local M = {}

M.plugins = {
  -- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      loader.safe_setup('nvim-treesitter.configs', {
        highlight = { enable = true },
        indent = { enable = true },
        -- ... rest of config
      })
    end,
  },

  -- Treesitter context
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      loader.safe_setup('treesitter-context', {
        enable = true,
        max_lines = 0,
        -- ... rest of config
      })
    end,
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = '^3.0.0',
    event = 'VeryLazy',
    config = function()
      loader.safe_setup('nvim-surround')
    end,
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    keys = { '<C-_>' },
    config = function()
      loader.safe_setup('Comment')
    end,
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      loader.safe_setup('nvim-autopairs', { map_cr = true })
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      loader.safe_setup('ibl', {
        -- ... configuration
      })
    end,
  },
}

return M
```

**`lua/plugins/ui.lua` (UI/Visual plugins):**
```lua
local loader = require('utils.loader')

local M = {}

M.plugins = {
  -- Notifications
  {
    'rcarriga/nvim-notify',
    priority = 900,
    event = 'VeryLazy',
    config = function()
      local notify = loader.safe_require('notify')
      if notify then
        vim.notify = notify.notify
        loader.safe_setup('nvim-notify')
      end
    end,
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'kyazdani42/nvim-web-devicons' },
    config = function()
      loader.safe_setup('which-key')
      -- Load which-key configurations
      require('whichkey.global').setup()
      require('whichkey.lsp').setup()
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      loader.safe_setup('bufferline')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      loader.safe_setup('lualine')
    end,
  },

  -- UI improvements
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      loader.safe_setup('dressing')
    end,
  },

  -- Color highlighter
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    ft = { 'css', 'scss', 'html', 'javascript', 'typescript', 'lua' },
    config = function()
      loader.safe_setup('colorizer')
    end,
  },
}

return M
```

**`lua/plugins/navigation.lua` (Navigation plugins):**
```lua
local loader = require('utils.loader')

local M = {}

M.plugins = {
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
      loader.safe_setup('telescope')
      require('keymaps.navigation').setup()
    end,
  },

  -- File explorer
  {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = 'python3 -m chadtree deps && :CHADdeps',
    cmd = { 'CHADopen' },
    config = function()
      loader.safe_setup('chadtree')
    end,
  },

  -- Movement enhancement
  {
    'gukz/ftFT.nvim',
    keys = { 'f', 't', 'F', 'T' },
    opts = {
      keys = { 'f', 't', 'F', 'T' },
      modes = { 'n', 'v' },
      -- ... rest of config
    },
  },

  -- Movement plugin
  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      loader.safe_setup('hop')
    end,
  },
}

return M
```

#### **Step 4.2: Update Main Plugin File**

**New `lua/plugins/init.lua`:**
```lua
-- Load plugin categories
local plugin_categories = {
  'plugins.editor',
  'plugins.ui',
  'plugins.navigation',
  'plugins.lsp',
  'plugins.completion',
  'plugins.tools',
  'plugins.themes',
}

local plugins = {}

-- Load all category plugins
for _, category in ipairs(plugin_categories) do
  local module = require(category)
  if module.plugins then
    for _, plugin in ipairs(module.plugins) do
      table.insert(plugins, plugin)
    end
  end
end

return plugins
```

### **Benefits:**
- **20+ files → 7 files** (65% reduction)
- **Logical grouping** of related functionality
- **Easier to understand** what plugins serve similar purposes
- **Better organization** and maintainability

---

## 🔧 **Phase 5: Core Architecture Improvements** (LOW PRIORITY)

### **Objective**: Add advanced architectural features for better maintainability

### **Feature 5.1: Configuration Registry**
```lua
-- lua/core/registry.lua
local M = {
  configs = {},
  loaded = {},
}

-- Register a configuration function
M.register = function(category, name, fn)
  M.configs[category] = M.configs[category] or {}
  M.configs[category][name] = fn
end

-- Load configurations by category
M.load_category = function(category)
  if M.loaded[category] then
    return
  end

  local category_configs = M.configs[category] or {}
  for name, fn in pairs(category_configs) do
    local ok, err = pcall(fn)
    if not ok then
      vim.notify(string.format('Failed to load config %s.%s: %s', category, name, err), vim.log.levels.ERROR)
    end
  end

  M.loaded[category] = true
end

-- Load all configurations
M.load_all = function()
  for category, _ in pairs(M.configs) do
    M.load_category(category)
  end
end

return M
```

### **Feature 5.2: Environment Detection**
```lua
-- lua/core/env.lua
local M = {}

-- Detect current environment
M.detect = function()
  local env = {
    is_wsl = vim.fn.has('wsl') == 1,
    is_windows = vim.fn.has('win32') == 1,
    is_mac = vim.fn.has('mac') == 1,
    is_linux = vim.fn.has('unix') == 1 and not M.is_wsl,
  }

  return env
end

-- Get environment-specific paths
M.get_paths = function()
  local env = M.detect()
  local base = vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config'

  local paths = {
    config = base .. '/nvim',
    undo = base .. '/nvim/.undo',
    cache = vim.fn.stdpath('data'),
    config_home = base,
  }

  -- WSL-specific paths
  if env.is_wsl then
    paths.dotnet = vim.fn.expand '~/.asdf/installs/dotnet'
    paths.python = '/usr/bin/python3'
  end

  return paths
end

-- Setup environment variables
M.setup = function()
  local env = M.detect()
  local paths = M.get_paths()

  if env.is_wsl then
    -- Setup .NET paths
    vim.env.DOTNET_ROOT = paths.dotnet .. '/9.0.305'
    vim.env.PATH = vim.fn.expand '~/.asdf/shims:' .. vim.fn.expand '~/.asdf/bin:' .. vim.env.PATH
    vim.env.DOTNET_MULTILEVEL_LOOKUP = '0'
  end

  return env, paths
end

return M
```

### **Feature 5.3: Feature Flags**
```lua
-- lua/core/features.lua
local M = {}

-- Feature flags
M.flags = {
  lsp = true,
  dap = true,
  format_on_save = true,
  auto_session = true,
  git_integration = true,
  ai_completion = true,
  advanced_ui = true,
  performance_mode = false,
}

-- Enable/disable features
M.enable = function(feature)
  M.flags[feature] = true
end

M.disable = function(feature)
  M.flags[feature] = false
end

M.is_enabled = function(feature)
  return M.flags[feature] == true
end

-- Conditional setup
M.setup_if = function(feature, setup_fn)
  if M.is_enabled(feature) then
    setup_fn()
  end
end

return M
```

### **Feature 5.4: Health Checks**
```lua
-- lua/utils/health.lua
local M = {}

-- Check plugin health
M.check_plugin = function(plugin_name)
  local ok, plugin = pcall(require, plugin_name)
  if not ok then
    return false, 'Plugin not found: ' .. plugin_name
  end

  if type(plugin.setup) ~= 'function' then
    return false, 'Plugin has no setup function'
  end

  return true, 'Plugin healthy'
end

-- Check configuration health
M.check_config = function()
  local checks = {
    -- Required plugins
    { name = 'lazy.nvim', required = true },
    { name = 'which-key', required = true },
    { name = 'telescope', required = false },
    -- ... more checks
  }

  local results = {}
  for _, check in ipairs(checks) do
    local ok, msg = M.check_plugin(check.name)
    results[check.name] = {
      ok = ok,
      msg = msg,
      required = check.required
    }
  end

  return results
end

-- Run health check
M.run = function()
  local results = M.check_config()

  print('=== Neovim Configuration Health Check ===')

  local failures = {}
  for name, result in pairs(results) do
    local status = result.ok and '✓' or '✗'
    local req = result.required and '[REQUIRED]' or '[OPTIONAL]'
    print(string.format('%s %s %s: %s', status, name, req, result.msg))

    if result.required and not result.ok then
      table.insert(failures, name)
    end
  end

  if #failures > 0 then
    print('\nRequired plugins missing: ' .. table.concat(failures, ', '))
    return false
  else
    print('\nAll required plugins are healthy!')
    return true
  end
end

return M
```

---

## 📋 **Implementation Timeline**

### **Week 1: Phase 1 - Theme System**
- **Day 1-2**: Create base theme system and individual theme files
- **Day 3-4**: Create theme manager and color utilities
- **Day 5**: Refactor rice.lua and test all themes

### **Week 2: Phase 2 - Keymap Organization**
- **Day 1-2**: Create loader utilities and split keymaps
- **Day 3-4**: Create which-key configurations
- **Day 5**: Test all keymaps and which-key groups

### **Week 3: Phase 3 - Error Handling**
- **Day 1-2**: Create enhanced plugin loader
- **Day 3-4**: Update all plugin configurations
- **Day 5**: Test error handling and edge cases

### **Week 4: Phase 4 - Plugin Consolidation**
- **Day 1-2**: Create category-based plugin files
- **Day 3-4**: Update main plugin file
- **Day 5**: Test plugin loading and configurations

### **Week 5+: Phase 5 - Advanced Features (Optional)**
- Implement as needed based on requirements

---

## ✅ **Success Metrics**

### **Quantitative Improvements:**
- **Lines of code**: Reduce from ~2,000 to ~1,200 lines (40% reduction)
- **File count**: Reduce from 30+ files to ~15 files (50% reduction)
- **Code duplication**: Reduce theme duplication by 90%
- **Boilerplate**: Reduce error handling boilerplate by 80%

### **Qualitative Improvements:**
- **Maintainability**: Easier to find and modify configurations
- **Extensibility**: Simple to add new themes, plugins, or features
- **Organization**: Clear separation of concerns
- **Debugging**: Better error messages and health checks
- **Performance**: Optimized loading patterns

---

## 🔄 **Migration Strategy**

### **Before Starting:**
1. **Backup current configuration**: `cp -r ~/.config/nvim ~/.config/nvim.backup`
2. **Create new branch**: `git checkout -b refactor/architecture-overhaul`
3. **Test current setup**: Ensure everything works before refactoring

### **During Refactoring:**
1. **Work one phase at a time**: Complete each phase before moving to next
2. **Test after each change**: Ensure Neovim starts and functions correctly
3. **Commit frequently**: Save progress after each major change
4. **Keep fallback**: Maintain ability to revert if needed

### **After Refactoring:**
1. **Full integration test**: Test all features and workflows
2. **Performance testing**: Measure startup time and memory usage
3. **Documentation**: Update any documentation if needed
4. **Cleanup**: Remove old files and configurations

---

## 🎯 **Getting Started**

Ready to begin? Let's start with **Phase 1: Theme System Overhaul** as it will give us the biggest immediate impact and establishes the foundation for the rest of the refactoring.

Just let me know when you're ready to start!