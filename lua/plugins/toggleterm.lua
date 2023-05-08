return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 0.8,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
      close_on_exit = true,
      shell = vim.o.shell,
    })
  end,
}
