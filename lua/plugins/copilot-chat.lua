return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    model = "claude-3.5-sonnet", -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
    -- default prompts
    prompts = require("prompts.copilot-prompts"),
  },
}
