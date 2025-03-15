-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local del = vim.keymap.del

-- Windows
map("n", "<leader>wo", "<C-w>o", { noremap = true, desc = "Close all other windows" })
map("n", "<leader>wx", "<C-w>x", { noremap = true, desc = "Exchange current window with next" })
map("n", "<leader>wX", "<C-w>X", { noremap = true, desc = "Exchange current window with previous" })
map("n", "<leader>wr", "<C-w>r", { noremap = true, desc = "Rotate windows downwards/rightwards" })
map("n", "<leader>wR", "<C-w>R", { noremap = true, desc = "Rotate windows upwards/leftwards" })
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

-- allows * to highlight and search but not (preserves jump list)
map("n", "*", "<cmd>keepjumps normal! mi*`i<CR>", { noremap = true, silent = true })

-- Add custom terminal mappings
map("t", "<esc><C-h>", [[<Cmd>wincmd h<CR>]], { noremap = true, desc = "Go to Left window" })
map("t", "<esc><C-j>", [[<Cmd>wincmd j<CR>]], { noremap = true, desc = "Go to Below window" })
map("t", "<esc><C-k>", [[<Cmd>wincmd k<CR>]], { noremap = true, desc = "Go to Above window" })
map("t", "<esc><C-l>", [[<Cmd>wincmd l<CR>]], { noremap = true, desc = "Go to Right window" })

-- Create a command to format docstrings in python using docformatter. Must have docformatter installed.
vim.api.nvim_create_user_command("Docformatter", function()
  -- Check if the current buffer is a Python file
  if vim.bo.filetype ~= "python" then
    print("This command can only be used on Python files.")
    return
  end
  -- Check if docformatter is installed by trying to get its version
  vim.fn.system("docformatter --version")
  -- Check if the command execution was successful
  if vim.v.shell_error ~= 0 then
    print("docformatter is not installed. Please install it to use this command.")
    return
  end

  -- Format the current Python file with docformatter
  local current_file = vim.api.nvim_buf_get_name(0)
  os.execute("docformatter -i " .. vim.fn.shellescape(current_file))

  -- Reload the buffer to reflect changes
  vim.cmd("edit!")
  print("File formatted with docformatter.")
end, { desc = "Format the current Python file with docformatter" })

-- Add filename under cursor to buffer list
map("n", "<leader>ba", function()
  local filename = vim.fn.expand("<cfile>")
  if filename == "" then
    vim.notify("No filename under cursor", vim.log.levels.ERROR)
    return
  end

  -- Add file to buffer list and ensure it's properly loaded
  local buf = vim.fn.bufadd(filename)
  vim.fn.bufload(buf) -- Load the buffer

  if vim.fn.bufexists(buf) == 1 then
    -- Store current window
    local current_win = vim.api.nvim_get_current_win()

    -- Use window-picker to select target window
    local picked_window = require("window-picker").pick_window({ filter_rules = { autoselect_one = false } })

    if picked_window then
      -- Focus picked window and set the buffer
      vim.api.nvim_set_current_win(picked_window)
      vim.api.nvim_win_set_buf(picked_window, buf)
      -- Return to original window
      vim.api.nvim_set_current_win(current_win)
    end
    vim.api.nvim_set_option_value("buflisted", true, { buf = buf })
  end
end, { noremap = true, desc = "Add <cfile> to buffer list and pick window" })
