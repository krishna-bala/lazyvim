return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      ["<leader>r"] = { name = "+root" },
      ["<leader>p"] = { name = "+project" },
      ["<leader>t"] = { name = "+toggle onedark colorscheme" },
    })
    -- Uncomment for `modes.nvim` plugin to work w/ cut/paste
    -- opts.triggers_blacklist = vim.tbl_deep_extend("force", opts.defaults, {
    --   n = { "d", "y" },
    -- })
  end,
}
