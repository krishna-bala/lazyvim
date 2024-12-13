return {
  "folke/snacks.nvim",
  opts = function(_, opts) -- Options for the plugin
    -- dashboard tweaks
    local dashboard = opts.dashboard or {}
    dashboard.sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 2, indent = 2 },
      { section = "recent_files", title = "MRU", gap = 1, padding = 1, indent = 2 },
      { section = "startup" },
    }
    dashboard.preset = opts.dashboard.preset or {}
    dashboard.preset.keys = opts.dashboard.preset.keys or {}
    for _, keymap in ipairs(opts.dashboard.preset.keys) do
      if keymap.key == "n" then
        keymap.action = ":ene"
        break
      end
    end
    opts.dashboard = dashboard

    -- -- zen tweaks for "zoom" mode
    -- local zen = opts.zen or {}
    -- zen.toggles = zen.toggles or {}
    -- zen.toggles.dim = true
    -- zen.zoom = zen.zoom or {}
    -- zen.zoom.window = zen.zoom.window or {}
    -- zen.zoom.window.backdrop = true
    -- opts.zen = zen
    --
    -- window tweaks for zen
    local styles = opts.styles or {}
    styles.zen = styles.zen or {}
    styles.zen.backdrop = styles.zen.backdrop or {}
    styles.zen.backdrop.transparent = false
    styles.zen.keys = styles.zen.keys or {}
    styles.zen.keys.q = "close"
    opts.styles = styles

    -- convenience for registering keymap
    -- require("snacks").toggle.zen():map("<leader>uz")
    return opts
  end,
  keys = {
    { "<leader>gb", false }, -- disable gitbrowse blame line in favor of gitsigns blame
  },
}
