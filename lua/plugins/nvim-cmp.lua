return {
  -- "hrsh7th/nvim-cmp",
  -- ---@param opts cmp.ConfigSchema
  -- opts = function(_, opts)
  --   -- Initialize with all sources
  --   local cmp = require("cmp")
  --
  --   local M = {}
  --
  --   M.sources = {
  --     {
  --       { name = "snippets", priority = 1000 },
  --       { name = "nvim_lsp", priority = 100 },
  --       { name = "path", priority = 100 },
  --     },
  --     {
  --       { name = "buffer", priority = 100 },
  --     },
  --   }
  --
  --   M.default = true
  --
  --   M.cycle_next_source = function()
  --     M.default = not M.default
  --     -- Update cmp sources
  --     if M.default then
  --       M.sources[1].priority = 10000
  --       M.sources[2].priority = 100
  --       print("default sources: " .. vim.inspect(M.sources))
  --       cmp.setup.buffer(M.sources)
  --     else
  --       M.sources[1].priority = 100
  --       M.sources[2].priority = 10000
  --       print("sources: " .. vim.inspect(M.sources))
  --       cmp.setup.buffer(M.sources)
  --     end
  --     cmp.complete()
  --   end
  --
  --   -- opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --   --   ["<C-t>"] = cmp.mapping(function()
  --   --     M.cycle_next_source()
  --   --   end),
  --   -- })
  --   --
  --   opts.sources = vim.tbl_extend("force", opts.sources, { group_index = 1, name = "snippets", priority = 10000 })
  --   print(vim.inspect(opts.sources))
  --
  --   return opts
  -- end,
}
