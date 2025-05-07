# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Format: Use `stylua` for Lua formatting
- Lint: Use language-specific linters configured in `nvim-lint.lua`
  - Shell: `shellcheck -x`
  - Dockerfile: `hadolint`
  - RST: `doc8 --quiet`

## Code Style
- Indentation: 2 spaces
- Line length: 120 characters max
- Use Neovim idioms and LazyVim patterns
- Prefer descriptive variable/function names in snake_case
- Organize imports alphabetically
- Keep plugin configurations in separate files under `lua/plugins/`
- Follow `return { plugin, config }` pattern for plugin definitions

## Development Patterns
- Use Plenary for testing when needed
- Custom AI prompts should be placed in `lua/plugins/ai/prompts/`
- Extensions should be organized in dedicated subdirectories 
- Respect LazyVim's plugin structure with opts, keys, and dependencies

## Git Workflow
- Always use mcp__git__* tools instead of Bash for git operations
- Follow conventional commits format (feat/fix/refactor/docs)