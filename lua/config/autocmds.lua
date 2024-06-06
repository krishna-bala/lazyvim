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
    -- vim.opt.formatoptions = vim.opt.formatoptions - "r"
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

-- vim.api.nvim_create_autocmd({
--   "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
--   "BufWinEnter",
--   "CursorHold",
--   "InsertLeave",
-- }, {
--   group = vim.api.nvim_create_augroup("barbecue.updater", {}),
--   callback = function()
--     require("barbecue").setup({
--       show_navic = false,
--       create_autocmd = false,
--       attach_navic = false,
--       show_dirname = false,
--     })
--     require("barbecue.ui").update()
--   end,
-- })
-- -- Autocommand to clear winbar on window leave
-- vim.api.nvim_create_autocmd({ "WinLeave" }, {
--   callback = function()
--     local win_id = vim.api.nvim_get_current_win()
--     require("barbecue").setup({
--       show_navic = false,
--       create_autocmd = false,
--       attach_navic = false,
--       show_dirname = false,
--     })
--     require("barbecue.ui").update(win_id)
--   end,
-- })

-- -- Autocommand to set nvim navic on winbar on window enter
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--   callback = function()
--     -- vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
--     if require("nvim-navic").is_available() then
--       vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
--     end
--   end,
-- })
--
