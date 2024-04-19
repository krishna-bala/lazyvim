return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>cS",
      "<cmd>Trouble lsp toggle focus=true win.position=bottom<cr>",
      desc = "LSP references/definitions/... (Trouble)",
    },
  },
}
