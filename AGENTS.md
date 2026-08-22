# AI Agent Instructions

This file contains instructions and guidelines for AI assistants working on this Neovim configuration project.

## Project Overview

This is a modern Neovim configuration using:
- **lazy.nvim** for plugin management
- **Avante.nvim** for AI-powered coding assistance
- Mason for LSP server management
- Multiple themes available (Dracula default, Gruvbox, Solarized, Nord)

## Development Guidelines

### Code Style
- Follow the existing Lua coding patterns
- Use 2-space indentation (as configured in .stylua.toml)
- Prefer single quotes for strings
- Add English comments for complex logic

### Plugin Development
- New plugins should be added to `lua/plugins/init.lua`
- Plugin configurations should go in `lua/plugins/configs/`
- Keymaps should be organized in `lua/plugins/keymaps/`

### File Structure
- Main entry point: `init.lua`
- Core modules: `lua/opts.lua`, `lua/rice.lua`, `lua/utils.lua`
- LSP configuration: `lua/lsp/`
- Plugin configurations: `lua/plugins/configs/`

### AI Assistant Guidelines
When working on this codebase:
1. Respect the existing architecture and conventions
2. Use the lazy loading patterns already established
3. Follow the modular configuration approach
4. Test changes thoroughly before committing
5. Use the existing formatting tools (stylua) for code formatting

### Key Features to Understand
- **Git-aware file search**: Ctrl+P switches between git files and all files
- **Advanced theme system**: Inheritance-based architecture with semantic color naming
- **Coq.nvim integration**: For autocompletion with Supermaven
- **CHADTree file explorer**: Right-side file management
- **Buffer management**: Alt+number navigation and intuitive cycling

## Available Commands

### Code Formatting
- `stylua` - Format Lua files using .stylua.toml configuration

### Plugin Management
- Managed through lazy.nvim with automatic updates

### LSP and Formatting
- Automatic formatting on save for supported filetypes
- ESLint integration for JavaScript/TypeScript projects

## Notes for AI Assistants
- Always run `stylua` after making code changes
- Test plugin configurations thoroughly
- Respect the existing keybinding system (leader key is Space)
- Follow the established pattern of lazy loading for performance

