return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0",                       -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  cmd = "ASToggle",                         -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    debounce_delay = 1000,
    condition = function(buf)
      -- Don't auto-save for oil buffers
      local excluded_filetypes = { "oil" }
      local buftype = vim.bo[buf].filetype
      return not vim.tbl_contains(excluded_filetypes, buftype)
    end,
  },
}
