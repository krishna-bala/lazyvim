-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local del = vim.keymap.del

-- Windows
map("n", "<leader>wo", "<C-w>o", { noremap = true, desc = "Maximize window" })
map("n", "<leader>wH", "<C-w>H", { noremap = true, desc = "Maximize on the Left edge" })
map("n", "<leader>wJ", "<C-w>J", { noremap = true, desc = "Maximize on the Bottom edge" })
map("n", "<leader>wK", "<C-w>K", { noremap = true, desc = "Maximize on the Top edge" })
map("n", "<leader>wL", "<C-w>L", { noremap = true, desc = "Maximize on the Right edge" })
map("n", "<leader>w=", "<C-w>=", { noremap = true, desc = "Equally high and wide" })

-- System clipboard yank/paste
map("n", "<leader>y", '"+y', { noremap = true })
map("v", "<leader>y", '"+y', { noremap = true })
map("n", "<leader>p", '"+p', { noremap = true })
map("v", "<leader>p", '"+p', { noremap = true })

-- Stop c, x, p from yanking
map("n", "c", '"_c', { noremap = true })
map("x", "c", '"_c', { noremap = true })
map("n", "x", '"_x', { noremap = true })
map("x", "x", '"_x', { noremap = true })

-- Don't use visual mode keymap - it messes with nvim-cmp
-- map("v", "x", '"_x', { noremap = true })
-- map("v", "c", '"_c', { noremap = true })

-- Commenting this out because it interferes with LuaSnip. See https://github.com/L3MON4D3/LuaSnip/discussions/726.
-- map("v", "p", '"_dP', { noremap = true })

-- allows * to highlight and search but not jump (preserves jump list)
map("n", "*", "<cmd>keepjumps normal! mi*`i<CR>", { noremap = true, silent = true })

-- open nvim config
map(
  "n",
  "<leader>nv",
  "<cmd>e ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = "Open nvim/init.lua" }
)
-- map("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true, desc = "lazygit toggle" })

-- Delete the default terminal mappings
del("n", "<leader>ft")
del("n", "<leader>fT")
del("n", "<C-/>")
del("n", "<C-_>")
del("t", "<C-/>")
del("t", "<C-_>")
del("t", "<C-h>")
del("t", "<C-j>")
del("t", "<C-k>")
del("t", "<C-l>")
del("t", "<esc><esc>")

-- Add custom terminal mappings
map("t", "<leader><esc>", [[<C-\><C-n>]], { noremap = true, desc = "Go to Normal mode" })
map("t", "<leader><C-h>", [[<Cmd>wincmd h<CR>]], { noremap = true, desc = "Go to Left window" })
map("t", "<leader><C-j>", [[<Cmd>wincmd j<CR>]], { noremap = true, desc = "Go to Below window" })
map("t", "<leader><C-k>", [[<Cmd>wincmd k<CR>]], { noremap = true, desc = "Go to Above window" })
map("t", "<leader><C-l>", [[<Cmd>wincmd l<CR>]], { noremap = true, desc = "Go to Right window" })

-- Delete default toggle diagnostics and change to toggle diagnostics for a given buffer
del("n", "<leader>ud")
map("n", "<leader>ud", function()
  if vim.diagnostic.is_disabled(0) then
    return vim.diagnostic.enable(0)
  else
    return vim.diagnostic.disable(0)
  end
end, { desc = "toggle buffer diagnostic" })

map("n", "<leader>rf", [[<Cmd>cd %:p:h<CR>]], { noremap = true, desc = "Change directory to current file" })
map("n", "<leader>rc", [[:lua vim.cmd('cd ' .. vim.fn.stdpath('config'))<CR>]],
  { noremap = true, desc = "Change directory to neovim config" })
