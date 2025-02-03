return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.spec = vim.tbl_deep_extend("force", opts.defaults, {
      { "<leader>p", group = "project" },
    })
  end,
}
