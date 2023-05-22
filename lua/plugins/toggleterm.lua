return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  init = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      autochdir = true,
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
      direction = "horizontal",
      size = 50,
      hidden = true,
      start_in_insert = true,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end
  end,
  opts = {
    size = 30,
    open_mapping = [[<c-\>]],
    autochdir = true,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "-20",
    start_in_insert = true,
    insert_mappings = true,
    persist_size = false,
    direction = "horizontal",
    float_opts = {
      border = "curved",
    },
    close_on_exit = true,
    shell = vim.o.shell,
  },
}
