return {
  {
    "coder/claudecode.nvim",
    enabled = true,
    config = true,
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
          external_terminal_cmd = "/home/krishna/.config/kitty/launch.sh -- %s",
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
