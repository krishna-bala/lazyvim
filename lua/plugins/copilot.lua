return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
  keys = {
    {
      "<leader>at",
      "<Cmd>Copilot toggle<cr>",
      desc = "Toggle Copilot Suggestion",
    },
  },
}
