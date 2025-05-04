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
    require("plugins.ai.extensions.codecompanion.noice_notification"):init()
    -- require("plugins.ai.extensions.codecompanion.save-history"):init()
  end,
  opts = {
    -- compact_export_dir = vim.fn.stdpath("data") .. "/codecompanion",
    system_prompt = function(opts)
      return require("plugins.ai.prompts.system_prompt")
    end,
    display = {
      action_palette = {
        width = 95,
        height = 10,
        opts = {
          show_default_actions = true,        -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      chat = {
        intro_message = "Welcome to CodeCompanion ✨ Press ? for options",
        show_header_separator = true,
        separator = "─",
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false,  -- Show LLM settings at the top of the chat buffer?
        show_token_count = true,
        start_in_insert_mode = false,
        auto_scroll = false,
      },
    },
    strategies = {
      chat = {
        adapter = "copilot",
        slash_commands = {
          save = {
            description = "Save last assistant message",
            callback = function()
              require("plugins.ai.extensions.codecompanion.history").exports.save()
            end,
            -- you can set opts.contains_code = false if you want
          },
          load = {
            description = "Load saved chat history",
            callback = function()
              require("plugins.ai.extensions.codecompanion.history").exports.load()
            end,
          },
        },
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
    prompt_library = require("plugins.ai.prompts.codecompanion_prompts"),
    -- extensions = {
    --   history = {
    --     enabled  = true,
    --     callback = require("plugins.ai.extensions.codecompanion.history"),
    --     opts     = {
    --       data_dir = vim.fn.stdpath("data")
    --           .. "/codecompanion/",
    --     },
    --   },
    -- },
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
    },
    {
      "<leader>al",
      function()
        vim.cmd("CodeCompanionLoad")
      end,
      desc = "Load a CodeCompanionChat summary",
      mode = { "n" },
    },
    {
      "<leader>as",
      function()
        vim.cmd("CodeCompanionSave")
      end,
      desc = "Save a CodeCompanionChat summary",
      mode = { "n" },

    },
  },
}
