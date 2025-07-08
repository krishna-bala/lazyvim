return {
  "folke/snacks.nvim",

  ---@param opts snacks.Config
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
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    opts.picker.sources.explorer.hidden = true
    opts.picker.sources.explorer.follow_file = false
  end,
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "<leader>er",
      function()
        local explorer = Snacks.picker.get({ source = "explorer" })[1]
        if explorer then
          explorer:close()
        end

        -- Open explorer at the root directory and reveal the current file
        Snacks.explorer.reveal()
      end,
    },
    {
      "<leader>ee",
      function()
        local explorer = Snacks.picker.get({ source = "explorer" })[1]
        if explorer then
          explorer:close()
        end
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
    },
    {
      "<leader>eE",
      function()
        --   Info  08:52:24 PM notify.info Zoom Mode Enabled **Zoom Mode**
        --    Warn  08:52:25 PM notify.warn Zoom Mode Disabled **Zoom Mode**
        --    Info  08:52:30 PM notify.info Zoom Mode Enabled **Zoom Mode**
        --    Warn  08:52:31 PM notify.warn Zoom Mode Disabled **Zoom Mode**
        --    Info  08:52:34 PM notify.info Zoom Mode Enabled **Zoom Mode**
        --    Warn  08:52:35 PM notify.warn Zoom Mode Disabled **Zoom Mode**
        --    Info  08:52:38 PM notify.info Zoom Mode Enabled **Zoom Mode**
        --    Warn  08:52:38 PM notify.warn Zoom Mode Disabled **Zoom Mode**
        --    Error  08:52:43 PM notify.error Zoom Mode Failed to set state for `Zoom Mode`:
        --
        -- vim/_editor.lua:0: nvim_exec2(), line 1: Vim(normal):Can't re-enter normal mode from terminal mode
        --    Info  08:52:43 PM notify.info Zoom Mode Enabled **Zoom Mode**
        -- 08:52:15 PM msg_showcmd ^Wc
        --    Error  08:53:05 PM msg_show.lua_error Error executing Lua callback: .../lazy/claudecode.nvim/lua/claudecode/terminal/snacks.lua:213: Invalid window id: 1133
        -- stack traceback:
        -- 	[C]: in function 'nvim_set_current_win'
        -- 	.../lazy/claudecode.nvim/lua/claudecode/terminal/snacks.lua:213: in function 'focus_toggle'
        -- 	...re/nvim/lazy/claudecode.nvim/lua/claudecode/terminal.lua:257: in function 'focus_toggle'
        -- 	.../share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua:858: in function <.../share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua:852>
        --
        -- vim/_editor.lua:0: nvim_exec2(), line 1: Vim(normal):Can't re-enter normal mode from terminal mode
        --    Info  08:54:00 PM notify.info Zoom Mode Enabled **Zoom Mode**
        --    Error  08:54:11 PM notify.error ClaudeCode Error [ClaudeCode] [server] [ERROR] WebSocket server error: Client read error: ECONNRESET

        local explorer = Snacks.picker.get({ source = "explorer" })[1]
        if explorer then
          explorer:close()
        end
        Snacks.explorer({ cwd = vim.fn.getcwd() })
      end,
    },
    -- {
    --   "<C-m>",
    --   function()
    --     -- Avoid conflicts with terminal mode when using native terminal provider
    --     if vim.bo.buftype == "terminal" and vim.fn.mode() == "t" then
    --       -- In terminal mode, first exit to normal mode
    --       vim.cmd("stopinsert")
    --       vim.defer_fn(function()
    --         Snacks.toggle.zoom():toggle()
    --       end, 50)
    --     else
    --       Snacks.toggle.zoom():toggle()
    --     end
    --   end,
    --   desc = "Toggle Zoom",
    --   mode = { "n", "v", "t" },
    -- },
  },
}
