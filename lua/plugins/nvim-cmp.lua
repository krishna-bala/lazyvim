return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  opts = function(_, opts)
    table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))

    local cmp = require("cmp")
    opts.mapping = vim.tbl_extend(
      "force",
      opts.mapping,
      cmp.mapping.preset.insert({
        -- This mapping allows me to switch to copilot completion source
        ["<C-l>"] = cmp.mapping.complete({
          config = {
            sources = {
              { name = "copilot" },
            },
          },
        }),
      })
    )
  end,
}
