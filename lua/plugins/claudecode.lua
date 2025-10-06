return {
  {
    "coder/claudecode.nvim",
    enabled = true,
    opts = {
      -- Terminal Configuration
      terminal = {
        provider = "external", -- "auto", "snacks", "native", or "external"
        provider_opts = {
          external_terminal_cmd = "/home/krishna/.config/kitty/launch.sh -- %s",
        },
        show_native_term_exit_tip = true, -- Show exit tip for native terminal
        auto_close = true, -- Auto-close terminal after command completion
        snacks_win_opts = {
          position = "right",
          width = 0.4,
          height = 1.0,
          keys = {
            claude_hide = {
              "<C-,>",
              function(self)
                self:hide()
              end,
              mode = "t",
              desc = "Hide",
            },
          },
        },
      },
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = false,
        open_in_new_tab = true, -- Opens diffs in a new tab instead of splitting current window
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Override the default commands to prevent closing running instances
      local terminal = require("claudecode.terminal")

      -- Track the last known width
      local last_width = nil

      -- Capture current terminal width if visible
      local function capture_terminal_width()
        local bufnr = terminal.get_active_terminal_bufnr()
        if bufnr then
          local wins = vim.fn.win_findbuf(bufnr)
          if #wins > 0 then
            local width = vim.api.nvim_win_get_width(wins[1])
            local total_width = vim.o.columns
            last_width = width / total_width
          end
        end
      end

      -- Track if we have a running instance (external provider specific)
      local function is_external_running()
        local terminal_info = terminal._get_managed_terminal_for_test and terminal._get_managed_terminal_for_test()
        if terminal_info and terminal_info.jobid then
          return terminal_info.jobid > 0
        end
        return false
      end

      -- Override ClaudeCode command to only open, never close
      vim.api.nvim_create_user_command("ClaudeCode", function(opt)
        local current_mode = vim.fn.mode()
        if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end
        local cmd_args = opt.args and opt.args ~= "" and opt.args or nil

        -- Check if external terminal is already running
        if is_external_running() then
          -- Already running, just notify the user
          vim.notify("Claude Code is already running in an external terminal", vim.log.levels.INFO)
          return
        end

        -- Not running, open it
        terminal.open({}, cmd_args)
      end, {
        nargs = "*",
        desc = "Open Claude Code (won't close if already running)",
        force = true, -- Override existing command
      })

      -- Override ClaudeCodeFocus command with width preservation
      vim.api.nvim_create_user_command("ClaudeCodeFocus", function(opt)
        local current_mode = vim.fn.mode()
        if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end
        local cmd_args = opt.args and opt.args ~= "" and opt.args or nil

        -- Check if external terminal is already running
        if is_external_running() then
          -- Already running, just notify the user
          vim.notify("Claude Code is already running in an external terminal", vim.log.levels.INFO)
          return
        end

        -- Capture width before toggling
        capture_terminal_width()

        -- Use focus_toggle
        terminal.focus_toggle({}, cmd_args)

        -- Restore width after toggle if we have a saved width
        if last_width then
          vim.schedule(function()
            local bufnr = terminal.get_active_terminal_bufnr()
            if bufnr then
              local wins = vim.fn.win_findbuf(bufnr)
              if #wins > 0 then
                local target_width = math.floor(vim.o.columns * last_width)
                vim.api.nvim_win_set_width(wins[1], target_width)
              end
            end
          end)
        end
      end, {
        nargs = "*",
        desc = "Focus Claude Code with width preservation",
        force = true, -- Override existing command
      })
    end,
    keys = {
      { "<leader>a", nil, desc = "+AI/Claude Code" },
      { "<C-,>", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude", mode = { "t", "n" } },
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
