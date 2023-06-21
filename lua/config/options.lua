-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Wrap text display at 80 characters
vim.opt.wrap = true

-- Disable swap files
vim.o.swapfile = false

-- vim.g.node_host_prog = "/home/krishna/.nvm/versions/node/v16.20.0/bin/node"
vim.fn.setenv("GIT_EDITOR", "nvr -cc split --remote-wait")
