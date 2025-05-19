return {
  "krishna-bala/claude-code.nvim",
  branch = "krishna.add-floating-window",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Terminal window settings
    window = {
      split_ratio = 0.4,  -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
      position = "float", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
      float = {
        width = "90%",
        height = "90%",
        row = "center",
        col = "center",
        relative = "editor",
        border = "rounded",
      },
      enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
      hide_numbers = true,    -- Hide line numbers in the terminal window
      hide_signcolumn = true, -- Hide the sign column in the terminal window
    },
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>",       desc = "Claude Code" },
    { "<leader>ap", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code" },
    -- { "<leader>acp", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code Interactive Session Picker" },
  },
}
