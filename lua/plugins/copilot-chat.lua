return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  build = "make tiktoken",
  opts = function(_, opts)
    opts.model = "claude-3.5-sonnet"
    opts.prompts = opts.prompts or {}
    opts.prompts = require("prompts.copilot-prompts")
  end,
}
