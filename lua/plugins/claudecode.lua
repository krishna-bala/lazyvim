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
          -- external_terminal_cmd = function(cmd, env)
          --   -- Use kitty remote control with socket and preserve environment
          --   local user = vim.fn.getenv("USER")
          --   local socket = string.format("unix:/tmp/kitty-%s", user)
          --   local cwd = vim.fn.getcwd()
          --
          --   -- Build the kitty command with environment variables
          --   local kitty_cmd = {
          --     "kitty",
          --     "@",
          --     "--to",
          --     socket,
          --     "launch",
          --     "--type=window",
          --     "--cwd",
          --     cwd,
          --   }
          --
          --   -- Add environment variables
          --   for key, value in pairs(env) do
          --     table.insert(kitty_cmd, "--env")
          --     table.insert(kitty_cmd, string.format("%s=%s", key, value))
          --   end
          --
          --   -- Add the command separator and the actual command
          --   table.insert(kitty_cmd, "--")
          --
          --   -- Parse and add command parts
          --   local cmd_parts = vim.split(cmd, " ")
          --   for _, part in ipairs(cmd_parts) do
          --     table.insert(kitty_cmd, part)
          --   end
          --
          --   return kitty_cmd
          -- end,
        },
        show_native_term_exit_tip = true, -- Show exit tip for native terminal
        auto_close = true, -- Auto-close terminal after command completion
      },
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = false,
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Override the default commands to prevent closing running instances
      local terminal = require("claudecode.terminal")

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

      -- Override ClaudeCodeFocus command to only open, never close
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

        -- Not running, open it
        terminal.open({}, cmd_args)
      end, {
        nargs = "*",
        desc = "Focus Claude Code (won't close if already running)",
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
  -- {
  --   "pittcat/claude-fzf.nvim",
  --   dependencies = {
  --     "ibhagwan/fzf-lua",
  --     "coder/claudecode.nvim",
  --   },
  --   opts = {
  --     auto_context = true,
  --     batch_size = 10,
  --
  --     -- Claude integration configuration
  --     claude_opts = {
  --       auto_open_terminal = true, -- Auto open terminal after sending
  --       context_lines = 5, -- Additional context lines
  --       source_tag = "claude-fzf", -- Source tag
  --     },
  --   },
  --   cmd = {
  --     "ClaudeFzf",
  --     "ClaudeFzfHealth",
  --     "ClaudeFzfFiles",
  --     "ClaudeFzfGrep",
  --     "ClaudeFzfBuffers",
  --     "ClaudeFzfGitFiles",
  --   },
  --   keys = {
  --     { "<leader>cf", false },
  --     { "<leader>cg", false },
  --     { "<leader>cb", false },
  --     { "<leader>cgf", false },
  --     { "<leader>cd", false },
  --     { "<leader>a<leader>", "<cmd>ClaudeFzfFiles<cr>", desc = "Claude: Add files" },
  --     { "<leader>a/", "<cmd>ClaudeFzfGrep<cr>", desc = "Claude: Search and add" },
  --     { "<leader>a,", "<cmd>ClaudeFzfBuffers<cr>", desc = "Claude: Add buffers" },
  --     { "<leader>af", "<cmd>ClaudeFzfGitFiles<cr>", desc = "Claude: Add Git files" },
  --     -- { "<leader>ad", "<cmd>ClaudeFzfDirectory<cr>", desc = "Claude: Add directory files" },
  --   },
  -- },
}
