if true then return {} end

local nls = require("null-ls")

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    opts.sources = vim.tbl_extend("force", opts.sources, {
      -- nls.builtins.formatting.black.with({
      --   extra_args = {
      --     -- "--experimental-string-processing",
      --     "--preview"
      --   }
      -- }),
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.clang_format,
      nls.builtins.formatting.yapf,
      -- nls.builtins.formatting.docformatter,
      -- We do NOT use Buf, we use clang-format
      -- nls.builtins.formatting.buf,
    })
  end,
}
