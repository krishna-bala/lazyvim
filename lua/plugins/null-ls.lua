local nls = require("null-ls")

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    opts.sources = vim.tbl_extend("force", opts.sources, {
      nls.builtins.formatting.black,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.clang_format,
      -- We do NOT use Buf, we use clang-format
      -- nls.builtins.formatting.buf,
    })
  end,
}
