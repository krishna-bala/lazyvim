return {
  {
    "coder/claudecode.nvim",
    enabled = true,
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Guard selection tracking against diffview buffers. Diffview's synthetic
      -- bufnames (diffview://...) aren't real files, and it wipes/rewrites the
      -- buffers on refresh -- a debounced update landing mid-wipe throws from
      -- nvim_buf_get_lines and can desync the diffview view.
      local selection = require("claudecode.selection")
      local orig_update = selection.update_selection
      selection.update_selection = function(...)
        local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        if buf_name and buf_name:match("^diffview://") then
          if selection.state.demotion_timer then
            selection.state.demotion_timer:stop()
            selection.state.demotion_timer:close()
            selection.state.demotion_timer = nil
          end
          return
        end
        return orig_update(...)
      end

      -- Guard MCP tools against trampling diffview's window layout.
      -- The tools registry (claudecode.tools.init) caches handlers at server
      -- start (inside setup() above), so we patch tools.tools[name].handler
      -- directly -- patching the source module's exported handler is too late.
      local tools = require("claudecode.tools.init")
      local orig_list_wins = vim.api.nvim_list_wins

      local function is_diffview_win(win)
        if not vim.api.nvim_win_is_valid(win) then
          return false
        end
        if vim.wo[win].diff then
          return true
        end
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("^diffview://") then
          return true
        end
        local ft = vim.bo[buf].filetype or ""
        return ft:match("^Diffview") ~= nil
      end

      -- closeAllDiffTabs: upstream closes any window with diff mode set, plus
      -- any buffer matching "diff://" (unanchored, so it also matches
      -- "diffview://"). Claude Code invokes this on every prompt submit, which
      -- is what tears down diffview's two diff windows.
      local cadt = tools.tools["closeAllDiffTabs"]
      if cadt then
        local orig_cadt = cadt.handler
        cadt.handler = function(params)
          local saved = {}
          local saved_diff = {}
          for _, w in ipairs(orig_list_wins()) do
            if is_diffview_win(w) then
              saved[w] = true
              saved_diff[w] = vim.wo[w].diff
              vim.wo[w].diff = false
            end
          end
          local saved_names = {}
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(b) then
              local n = vim.api.nvim_buf_get_name(b)
              if n:match("^diffview://") then
                saved_names[b] = n
                pcall(vim.api.nvim_buf_set_name, b, "")
              end
            end
          end
          local ok, result = pcall(orig_cadt, params)
          for w, d in pairs(saved_diff) do
            if vim.api.nvim_win_is_valid(w) then
              vim.wo[w].diff = d
            end
          end
          for b, n in pairs(saved_names) do
            if vim.api.nvim_buf_is_valid(b) then
              pcall(vim.api.nvim_buf_set_name, b, n)
            end
          end
          if not ok then
            error(result)
          end
          return result
        end
      end

      -- openFile: upstream find_main_editor_window doesn't exclude diffview
      -- windows. Pre-create a tab if no safe window exists, then shadow
      -- nvim_list_wins to hide diffview windows from the iteration.
      local of = tools.tools["openFile"]
      if of then
        local orig_of = of.handler
        local function has_safe_editor_win()
          for _, w in ipairs(orig_list_wins()) do
            if not is_diffview_win(w) then
              local cfg = vim.api.nvim_win_get_config(w)
              if not cfg.relative or cfg.relative == "" then
                local buf = vim.api.nvim_win_get_buf(w)
                local bt = vim.bo[buf].buftype
                if bt ~= "terminal" and bt ~= "nofile" and bt ~= "prompt" then
                  return true
                end
              end
            end
          end
          return false
        end
        of.handler = function(params)
          if not has_safe_editor_win() then
            vim.cmd("tabnew")
          end
          vim.api.nvim_list_wins = function()
            return vim.tbl_filter(function(w)
              return not is_diffview_win(w)
            end, orig_list_wins())
          end
          local ok, result = pcall(orig_of, params)
          vim.api.nvim_list_wins = orig_list_wins
          if not ok then
            error(result)
          end
          return result
        end
      end
    end,
    opts = {
      -- Top-Level Configuration
      -- log_level = "debug", -- "trace", "debug", "info", "warn", "error"
      auto_start = true, -- Automatically start Claude Code server
      focus_after_send = false, -- Focus terminal after sending context
      track_selection = true, -- Enable real-time selection tracking

      -- Terminal Configuration
      terminal = {
        split_side = "right", -- "left" or "right"
        split_width_percentage = 0.30, -- Width of terminal split
        provider = "external", -- "auto", "snacks", "native", "external", or "none"
        provider_opts = {
          external_terminal_cmd = vim.fn.expand("~/.config/kitty/launch.sh") .. " -- %s",
        },
        snacks_win_opts = {}, -- Options for floating window (when using snacks provider)
        auto_close = true, -- Auto-close terminal after command completion
        -- Working directory options
        -- cwd = nil, -- Static working directory
        -- cwd_provider = function(ctx) return vim.fn.getcwd() end, -- Dynamic cwd
        -- git_repo_cwd = false, -- Resolve git root automatically
      },

      -- Diff Configuration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_new_tab = true,
        -- open_in_current_tab = false, -- Keep as false to match your preference
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
    keys = {
      { "<leader>a", nil, desc = "+AI/Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Start Claude", mode = { "t", "n" } },
      { "<C-,>", "<cmd>ClaudeCodeStart<cr>", desc = "Start Claude", mode = { "t", "n" } },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeSend<cr>",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
        desc = "Add file to Claude",
      },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      -- Diff management
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
