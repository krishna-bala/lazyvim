-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_config_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("commentstring"),
--   pattern = { "*.cc", "*.c", "*.h" },
--   callback = function()
--     vim.opt.commentstring = "// %s"
--   end,
--   desc = "Change commentstring for c/c++ files",
-- })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("formatoptions"),
  pattern = {
    "*",
  },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "r"
    vim.opt.formatoptions = vim.opt.formatoptions - "o"
    vim.opt.formatoptions = vim.opt.formatoptions - "l"
  end,
  desc = "Don't continue comments on new lines, with o, or with O",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("git"),
  pattern = {
    "gitcommit",
    "gitrebase",
    "gitconfig",
  },
  callback = function()
    vim.opt.bufhidden = "delete"
  end,
})
