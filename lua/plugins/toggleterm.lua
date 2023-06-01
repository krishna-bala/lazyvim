function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<leader><esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<leader><C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<leader><C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<leader><C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<leader><C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  init = function()
  end,
  opts = {
    size = 30,
    open_mapping = [[<c-\>]],
    autochdir = true,
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
}
