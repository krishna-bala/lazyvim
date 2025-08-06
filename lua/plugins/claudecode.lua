return {
  -- "krishna-bala/claudecode.nvim",
  "coder/claudecode.nvim",
  enabled = true,
  -- dir = "/home/krishna/src/claudecode.nvim", -- Use local directory instead of remote
  opts = {
    -- Terminal Configuration
    terminal = {
      split_side = "right", -- "left" or "right"
      split_width_percentage = 0.40, -- Width as percentage (0.0 to 1.0)
      provider = "snacks", -- "auto", "snacks", or "native"
      show_native_term_exit_tip = true, -- Show exit tip for native terminal
      auto_close = true, -- Auto-close terminal after command completion
    },
  },
  keys = {
    { "<leader>a", nil, desc = "+AI/Claude Code" },
    { "<C-,>", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude", mode = { "t", "n" } },
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
}
