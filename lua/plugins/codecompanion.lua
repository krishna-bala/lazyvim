return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ",                    -- Prompt used for interactive LLM calls
        provider = "default",                  -- default|telescope|mini_pick
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
        model = "claude-3-7-sonnet",
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using snacks.nvim",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["buffer"] = {
            callback = "strategies.chat.slash_commands.buffer",
            description = "Select a buffer using snacks.nvim",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["fetch"] = {
            callback = "strategies.chat.slash_commands.fetch",
            description = "Fetch content from a URL",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["help"] = {
            callback = "strategies.chat.slash_commands.help",
            description = "Select help content using snacks.nvim",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["now"] = {
            callback = "strategies.chat.slash_commands.now",
            description = "Insert current datetime",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["symbols"] = {
            callback = "strategies.chat.slash_commands.symbols",
            description = "Select symbols using snacks.nvim",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["terminal"] = {
            callback = "strategies.chat.slash_commands.terminal",
            description = "Share terminal output",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["workspace"] = {
            callback = "strategies.chat.slash_commands.workspace",
            description = "Share workspace context",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
        },
      },
      window = {
        width = 100,
      },
      log_level = "DEBUG",
    },
    prompt_library = require("prompts.copilot-prompts"),
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
  config = function(_, opts)
    -- require("plugins.codecompanion.snacks_notifier").setup()
    require("codecompanion").setup(opts)
  end,
}
