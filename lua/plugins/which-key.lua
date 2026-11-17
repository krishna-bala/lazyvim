return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    error("ci canary: deliberate error, revert me")
    opts.spec = vim.tbl_deep_extend("force", opts.defaults, {
      -- Format:
      -- { "<keymap>", group = "<name>" },
      { "<leader>a", group = "+ai" },
    })
  end,
}
