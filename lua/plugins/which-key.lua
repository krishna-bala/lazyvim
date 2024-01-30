return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      ["<leader>r"] = { name = "+root" },
      ["<leader>p"] = { name = "+project" },
      ["<leader>t"] = { name = "+toggle onedark colorscheme" },
    })
  end,
}
