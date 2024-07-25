return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.spec = vim.tbl_deep_extend("force", opts.defaults, {
      { "<leader>e", group = "edgy" },
      { "<leader>p", group = "project" },
      { "<leader>r", group = "root" },
      { "<leader>t", group = "toggle onedark colorscheme" },
    })
    -- Uncomment for `modes.nvim` plugin to work w/ cut/paste
    -- opts.triggers_blacklist = vim.tbl_deep_extend("force", opts.defaults, {
    --   n = { "d", "y" },
    -- })
  end,
}
