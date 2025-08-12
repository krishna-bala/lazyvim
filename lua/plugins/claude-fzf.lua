-- return {}
return {
  {
    "pittcat/claude-fzf.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
      "coder/claudecode.nvim",
    },
    opts = {
      auto_context = true,
      batch_size = 10,

      -- Claude integration configuration
      claude_opts = {
        auto_open_terminal = true, -- Auto open terminal after sending
        context_lines = 5, -- Additional context lines
        source_tag = "claude-fzf", -- Source tag
      },
    },
    cmd = {
      "ClaudeFzf",
      "ClaudeFzfHealth",
      "ClaudeFzfFiles",
      "ClaudeFzfGrep",
      "ClaudeFzfBuffers",
      "ClaudeFzfGitFiles",
    },
    keys = {
      { "<leader>a<leader>", "<cmd>ClaudeFzfFiles<cr>", desc = "Claude: Add files" },
      { "<leader>a/", "<cmd>ClaudeFzfGrep<cr>", desc = "Claude: Search and add" },
      { "<leader>a,", "<cmd>ClaudeFzfBuffers<cr>", desc = "Claude: Add buffers" },
      { "<leader>af", "<cmd>ClaudeFzfGitFiles<cr>", desc = "Claude: Add Git files" },
      -- { "<leader>ad", "<cmd>ClaudeFzfDirectory<cr>", desc = "Claude: Add directory files" },
      { "<leader>cf", false },
      { "<leader>cg", false },
      { "<leader>cb", false },
      { "<leader>cgf", false },
      { "<leader>cd", false },
    },
  },
}
