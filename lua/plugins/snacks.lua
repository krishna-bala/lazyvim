return {
  "folke/snacks.nvim",
  opts = function(_, opts) -- Options for the plugin
    opts.dashboard.sections = {
      -- {
      --   section = "terminal",
      --   cmd = "chafa ~/Pictures/fox_logos/horizontal_-_orange_on_transparent.png --stretch; sleep .1",
      --   padding = 1,
      -- },
      { section = "header" },
      { section = "keys", gap = 1, padding = 2, indent = 2 },
      { section = "recent_files", title = "MRU", gap = 1, padding = 1, indent = 2 },
      { section = "startup" },
    }
    return opts
  end,
}
