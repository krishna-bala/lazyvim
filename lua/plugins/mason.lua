return {
{
  "mason-org/mason.nvim",
  version = "1.11.0",
  opts = function(_, opts)
    opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed, {
      "clangd",
    })
    return opts
  end,
},
  {"mason-org/mason-lspconfig.nvim", version = "1.32.0"},
}
