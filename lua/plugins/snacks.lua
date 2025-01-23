return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- dashboard tweaks
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

    -- window tweaks for zen
    opts.styles = opts.styles or {}
    opts.styles.zen = opts.styles.zen or {}
    opts.styles.zen.backdrop = opts.styles.zen.backdrop or {}
    opts.styles.zen.backdrop.transparent = false
    opts.styles.zen.keys = opts.styles.zen.keys or {}
    opts.styles.zen.keys.q = "close"

    -- gitbrowse tweaks until patch is in
    opts.gitbrowse = opts.gitbrowse or {}
    opts.gitbrowse.url_patterns = opts.gitbrowse.url_patterns or {}
    opts.gitbrowse.url_patterns["bitbucket%.org"] = {
      branch = "/src/{branch}",
      file = "/src/{branch}/{file}#lines-{line_start}:{line_end}",
      commit = "/commits/{commit}",
    }

    -- picker tweaks for git_status
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.git_status = {
      finder = "git_status",
      format = "git_status",
      preview = "git_status",
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "select_and_next", mode = { "n", "i" } },
          },
        },
      },
    }
  end,
}
