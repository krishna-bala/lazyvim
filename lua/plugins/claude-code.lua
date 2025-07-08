return {
  "greggh/claude-code.nvim",
  enabled = true,
  dir = "/home/krishna/src/claude-code.nvim", -- Use local directory instead of remote
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Terminal window settings
    window = {
      split_ratio = 0.5,
      -- position = "float",
      position = "vertical",
      -- float = {
      --   width = "50%",
      --   height = "95%",
      --   row = "center",
      --   col = "50%",
      --   relative = "editor",
      --   border = "rounded",
      -- },
      enter_insert = true,
      hide_numbers = true,
      hide_signcolumn = true,
    },
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
    { "<leader>ar", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code" },
  },
}
