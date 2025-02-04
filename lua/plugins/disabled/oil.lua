return {
  "stevearc/oil.nvim",
  -- Optional dependencies
  lazy = false,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    use_default_keymaps = false,
    default_file_explorer = true,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<leader>|"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<leader>-"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<leader><tab><tab>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<M-p>"] = "actions.preview",
      ["q"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["<BS>"] = "actions.parent",
      ["<leader>cwd"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    float = {
      max_width = 120, -- Adjust the width as needed
      max_height = 80, -- Adjust the height as needed
    },
  },
  keys = {
    { "<leader>fo", "<cmd>Oil --float<cr>", desc = "Open Oil" },
    { "<leader>fO", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
