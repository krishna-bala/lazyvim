-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Windows
map("n", "<leader>wo", "<C-w>o", { noremap = true })
map("n", "<leader>wH", "<C-w>H", { noremap = true })
map("n", "<leader>wJ", "<C-w>J", { noremap = true })
map("n", "<leader>wK", "<C-w>K", { noremap = true })
map("n", "<leader>wL", "<C-w>L", { noremap = true })
map("n", "<leader>w=", "<C-w>=", { noremap = true, desc = "Equally high and wide" })

-- System clipboard yank/paste
map("n", "<leader>y", '"+y', { noremap = true })
map("v", "<leader>y", '"+y', { noremap = true })
map("n", "<leader>p", '"+p', { noremap = true })
map("v", "<leader>p", '"+p', { noremap = true })

-- Stop c, x, p from yanking
map("n", "c", '"_c', { noremap = true })
map("x", "c", '"_c', { noremap = true })
map("v", "c", '"_c', { noremap = true })
map("n", "x", '"_x', { noremap = true })
map("x", "x", '"_x', { noremap = true })
map("v", "x", '"_x', { noremap = true })
map("v", "p", '"_dP', { noremap = true })

-- allows * to highlight and search but not jump (preserves jump list)
map("n", "*", "<cmd>keepjumps normal! mi*`i<CR>", { noremap = true, silent = true })

-- open nvim config
map(
  "n",
  "<leader>nv",
  "<cmd>e ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = "Open nvim/init.lua" }
)
