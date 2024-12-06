return {
  "folke/snacks.nvim",
  opts = function(_, opts) -- Options for the plugin
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 2, indent = 2 },
      { section = "recent_files", title = "MRU", gap = 1, padding = 1, indent = 2 },
      { section = "startup" },
    }
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.keys = opts.dashboard.preset.keys or {}
    for _, keymap in ipairs(opts.dashboard.preset.keys) do
      if keymap.key == "n" then
        keymap.action = ":ene"
        break
      end
    end

    return opts
  end,
  keys = {
    { "<leader>gb", false }, -- disable gitbrowse blame line in favor of gitsigns blame
  },
}
