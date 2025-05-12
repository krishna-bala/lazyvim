return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed, {
      "clangd",
    })
    return opts
  end,
}
