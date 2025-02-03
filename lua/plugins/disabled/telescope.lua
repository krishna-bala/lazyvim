return {
  "telescope.nvim",
  dependencies = {},
  keys = {
    { "<leader>/", false },
    { "<leader>sw", mode = { "n", "v" }, false },
    { "<leader>gs", false },
    {
      "q/",
      "<cmd>Telescope search_history<cr>",
      desc = "Show search history",
    },
    {
      "q:",
      "<cmd>Telescope command_history<cr>",
      desc = "Show command history",
    },
  },
}
