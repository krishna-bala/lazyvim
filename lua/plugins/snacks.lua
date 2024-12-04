return {
  "folke/snacks.nvim",
  opts = function(_, opts) -- Options for the plugin
    opts.dashboard.sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 2, indent = 2 },
      { section = "recent_files", title = "MRU", gap = 1, padding = 1, indent = 2 },
      { section = "startup" },
    }
    return opts
  end,
  keys = {
    { "<leader>gb", false }, -- disable gitbrowse blame line in favor of gitsigns blame
  },
}
