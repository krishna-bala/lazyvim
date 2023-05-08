return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = function(_, opts)
    opts.context_commentstring = vim.tbl_extend("force", opts.context_commentstring, {
      enable = true,
      config = {
        c = "// %s",
        cpp = "// %s",
      },
    })
  end,
}
