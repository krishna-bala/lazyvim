return {
  "olimorris/codecompanion.nvim",
  enabled = false,
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
        prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
        provider = "default",                 -- default|telescope|mini_pick
        opts = {
          show_default_actions = true,        -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
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
        tools = {
          ["mcp"] = {
            -- calling it in a function would prevent mcphub from being loaded before it's needed
            callback = function() return require("mcphub.extensions.codecompanion") end,
            description = "Call tools and resources from the MCP Servers",
          },
          vectorcode = {
            description = "Run VectorCode to retrieve the project context.",
            callback = function()
              return require("vectorcode.integrations.codecompanion").chat.make_tool()
            end,
          },
        },
      },
      window = {
        width = 100,
      },
      prompts = require("prompts.copilot-prompts"),
      log_level = "DEBUG",
      mappings = {
        clear = "<C-x>",
      },
    },
  },
  keys = {
    {
      "<leader>cc", false,
    },
    {
      "<leader>cca",
      function()
        vim.cmd("CodeCompanionActions")
      end,
      desc = "CodeCompanionActions",
    },
    {
      "<leader>ccc",
      function()
        require("codecompanion").chat()
      end,
      desc = "CodeCompanionChat",
      mode = { "n", "v" },
    },
  },
  config = function(_, opts)
    require("plugins.codecompanion.snacks_notifier").setup()
    require("codecompanion").setup(opts)
  end,
}
