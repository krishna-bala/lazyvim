return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
    "folke/noice.nvim",
  },
  init = function()
    require("plugins.ai.extensions.codecompanion.noice-notification"):init()
  end,
  opts = {
    system_prompt = require("prompts.sys_base_prompt"),
    display = {
      action_palette = {
        width = 95,
        height = 10,
        opts = {
          show_default_actions = true,         -- Show the default actions in the action palette?
          show_default_prompt_library = false, -- Show the default prompt library in the action palette?
        },
      },
      chat = {
        intro_message = "Welcome to CodeCompanion ✨ Press ? for options",
        show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        separator = "─", -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
      },
    },
    strategies = {
      chat = {
        adapter = "copilot",
      },
      window = {
        width = 100,
      },
      log_level = "DEBUG",
    },
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "o4-mini",
            },
          },
        })
      end,
    },
    prompt_library = require("prompts.codecompanion-prompts"),
  },
  keys = {
    {
      "<leader>cc", false,
    },
    {
      "<leader>aa",
      function()
        vim.cmd("CodeCompanionActions")
      end,
      desc = "CodeCompanionActions",
    },
    {
      "<leader>ac",
      function()
        vim.cmd("CodeCompanionChat Toggle")
      end,
      desc = "CodeCompanionChat",
      mode = { "n" },
    },
    {
      "<leader>ac",
      function()
        vim.cmd("CodeCompanionChat Add")
      end,
      desc = "Send selection to CodeCompanionChat",
      mode = { "v" },
    }
  },
}
