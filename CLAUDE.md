# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Code Formatting
- `stylua` - Format Lua files using the configuration in `.stylua.toml`
- Configuration uses 2-space indentation, Unix line endings, and prefers single quotes

### Plugin Management
- This configuration uses **lazy.nvim** for plugin management
- Plugins are defined in `lua/plugins/init.lua`
- Plugin configurations are in `lua/plugins/configs/`
- Keymaps are organized in `lua/plugins/keymaps/`

### LSP and Formatting
- LSP servers managed through **mason.nvim** and **mason-lspconfig.nvim**
- Formatting and linting handled by **none-ls.nvim**
- Automatic formatting on save for supported filetypes
- ESLint integration for JavaScript/TypeScript/Vue projects

## Architecture Overview

### Configuration Structure
- `init.lua` - Main entry point, sets up lazy.nvim and loads core modules
- `lua/opts.lua` - Vim options and settings
- `lua/rice.lua` - Theme and appearance configuration
- `lua/utils.lua` - Utility functions

### Plugin Organization
- **Plugin specs**: `lua/plugins/init.lua` contains all plugin declarations
- **Plugin configs**: `lua/plugins/configs/` houses individual plugin setup files
- **Keymaps**: `lua/plugins/keymaps/` contains keymap definitions, particularly for which-key

### LSP Architecture
- **Server setup**: `lua/lsp/servers.lua` configures LSP servers with Coq integration
- **Formatting**: `lua/lsp/none-ls.lua` handles code formatting and linting
- **Mason integration**: Automatic installation and management of language servers

### Key Features
- **Advanced theme system**: Inheritance-based architecture (`lua/themes/base.lua`) with semantic color naming and multi-theme support (Dracula default, Gruvbox, Solarized, Nord)
- **File management**: CHADTree file explorer on the right side with intelligent navigation
- **Intelligent file search**: Git-aware file detection (ControlP) that automatically switches between git files and all files based on repository context
- **Fuzzy finding**: Telescope for file search, live grep, recent files, and treesitter symbols
- **Session management**: Persistent workspace sessions with auto-restore capabilities
- **Buffer management**: Bufferline with Alt+number navigation and intuitive buffer cycling
- **Completion**: Coq.nvim for autocompletion with Supermaven integration for enhanced suggestions

### Keybinding System
- **Leader key**: Space
- **Which-key**: Integrated keybinding discovery system
- **Buffer navigation**: Alt+number keys, Alt+,/. for buffer switching
- **File operations**: Ctrl+P for intelligent file search (git-aware)
- **Git operations**: `<leader>g` group with git-blame commands (toggle blame, open commit URL, copy SHA/file URL)
- **LSP actions**: Standard LSP keybindings (gd, gr, gi, etc.)

### Workflow Integration
- **Git integration**: Gitsigns for inline git status, git-blame.nvim for line-by-line commit information, lazygit/lazydocker available via floaterm
- **Debugging**: DAP (Debug Adapter Protocol) with comprehensive F5-F12 function key shortcuts and UI integration
- **Rest client**: Built-in REST client for API testing
- **Terminal management**: Floaterm for embedded terminal sessions with quick access to development tools
- **Code actions**: Extensive use of none-ls for formatting and linting actions

### Filetype Support
- **Web**: HTML, CSS, JavaScript/TypeScript with advanced Vue.js integration (dual LSP setup with vtsls + vue_ls and request forwarding)
- **Lua**: Lazydev.nvim for intelligent Lua development
- **General**: Shell, Python, and other common languages via Mason with automatic server installation

### Performance Architecture
- **Strategic lazy loading**: All plugins load only when needed with precise event triggers
- **Plugin caching**: Disabled unused default Neovim plugins for optimal startup performance
- **Priority system**: Alpha dashboard loads first (priority 1000), followed by notifications, then UI elements

### Configuration Notes
- **Modular architecture**: Separate config files for each plugin in `lua/plugins/configs/` with dedicated keymap files
- **Performance focus**: Strategic lazy loading with deferred plugin initialization and cached theme loading
- **Theme system**: Dynamic color generation across UI elements, bufferline, git signs, git-blame, and indent lines with legacy compatibility
- **Git-blame integration**: Custom highlight group `GitBlameVirtualText` that matches cursorline background for optimal visibility
- **Development environment**: Pre-configured .NET development paths and environment variables in `opts.lua`
- **Storage**: Undo files stored in `~/.config/nvim/.undo/`
- **Portability**: Designed to work across different environments with minimal setup requirements