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
- **Multi-theme support**: Dracula (default), Gruvbox, Solarized, Nord with dynamic color definitions
- **File management**: CHADTree file explorer on the right side
- **Fuzzy finding**: Telescope for file search and grep
- **Session management**: Neovim session manager with persistent sessions
- **Buffer management**: Bufferline with intuitive buffer navigation
- **Completion**: Coq.nvim for autocompletion with Supermaven integration

### Keybinding System
- **Leader key**: Space
- **Which-key**: Integrated keybinding discovery system
- **Buffer navigation**: Alt+number keys, Alt+,/. for buffer switching
- **File operations**: Ctrl+P for intelligent file search (git-aware)
- **LSP actions**: Standard LSP keybindings (gd, gr, gi, etc.)

### Workflow Integration
- **Git integration**: Gitsigns for inline git status, lazygit/lazydocker available via floaterm
- **Rest client**: Built-in REST client for API testing
- **Terminal management**: Floaterm for embedded terminal sessions
- **Code actions**: Extensive use of none-ls for formatting and linting actions

### Filetype Support
- **Web**: HTML, CSS, JavaScript/TypeScript, Vue with full LSP support
- **Lua**: Lazydev.nvim for intelligent Lua development
- **General**: Shell, Python, and other common languages via Mason

### Configuration Notes
- All plugins are lazy-loaded for optimal startup performance
- Theme colors are dynamically generated and applied across all UI elements
- Undo files are stored in `~/.config/nvim/.undo/`
- The configuration is designed to be portable across different environments