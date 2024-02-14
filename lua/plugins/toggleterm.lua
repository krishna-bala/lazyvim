return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  init = function()
  end,
  opts = {
    size = 30,
    open_mapping = [[<c-\>]],
    autochdir = true,
    auto_scroll = false,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "-30",
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    float_opts = {
      border = "curved",
    },
    close_on_exit = true,
    shell = vim.o.shell,
  },
  keys = {

    {
      [[<leader><c-\>]],
      [[<cmd>2ToggleTerm direction="vertical" size=]] .. vim.o.columns * 0.5 .. [[<cr>]],
      desc = "Toggle Terminal (vertical)"

    }

  }
}
