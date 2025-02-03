return {
  "folke/trouble.nvim",
  opts = {
    auto_preview = false,
    focus = true,
  },
  keys = {
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle win.position=bottom focus=true<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cS",
      "<cmd>Trouble lsp toggle focus=true win.position=bottom focus=true<cr>",
      desc = "LSP references/definitions/... (Trouble)",
    },
  },
}
