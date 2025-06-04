return {
  "krishna-bala/claude-code.nvim",
  dir = "/home/krishna/src/claude-code.nvim", -- Use local directory instead of remote
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Terminal window settings
    window = {
      split_ratio = 0.4,
      position = "float",
      float = {
        width = "85%",
        height = "85%",
        row = "center",
        col = "center",
        relative = "editor",
        border = "rounded",
      },
      enter_insert = true,
      hide_numbers = true,
      hide_signcolumn = true,
    },
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>",       desc = "Claude Code" },
    { "<leader>ap", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code" },
  },
}
