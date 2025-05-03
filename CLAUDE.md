# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Format: Use `stylua` for Lua formatting
- Lint: Use language-specific linters configured in `nvim-lint.lua`
  - Shell: `shellcheck`
  - Dockerfile: `hadolint`
  - RST: `doc8`

## Code Style
- Indentation: 2 spaces
- Line length: 120 characters max
- Use Neovim idioms and LazyVim patterns
- Prefer descriptive variable/function names in snake_case
- Organize imports alphabetically
- Keep plugin configurations in separate files under `lua/plugins/`

## AI Tools
- Use custom prompts from `lua/prompts/` when appropriate
- Respect existing plugin structures and naming conventions
- When editing config, maintain user-defined keymaps and options

## Git Workflow
- Always use mcp__git__* tools instead of Bash for git operations
- Commit messages should be clear and follow conventional commits format