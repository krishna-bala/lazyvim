local data_dir = vim.fn.stdpath("data") .. "/codecompanion/"
local history_exports = require("plugins.ai.extensions.codecompanion.history").exports
local system_prompt = require("plugins.ai.prompts.system_prompt")
local compact_prompt = require("plugins.ai.prompts.compact")
local prompt_library = require("plugins.ai.prompts.codecompanion_prompts")

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
  end,
  opts = {
    system_prompt = function() return system_prompt end,
    display = {
      action_palette = {
        width = 95,
        height = 10,
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
      chat = {
        intro_message = "Welcome to CodeCompanion ✨ Press ? for options",
        show_header_separator = true,
        separator = "─",
        show_references = true,
        show_settings = false,
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
              history_exports.save(data_dir)
            end,
          },
          load = {
            description = "Load saved chat history",
            callback = function()
              history_exports.load(data_dir)
            end
          },
          compact = {
            description = "Compact the chat buffer",
            callback = function()
              local chat = require("codecompanion").last_chat()
              if not chat then
                return vim.notify("[CodeCompanion] no active chat buffer", vim.log.levels.WARN)
              end
              chat:add_buf_message({ role = "user", content = compact_prompt })
            end
          },
          clear = {
            description = "Clear the chat buffer except last message",
            callback = function()
              local chat = require("codecompanion").last_chat()
              if not chat then
                return vim.notify("[CodeCompanion] no active chat buffer", vim.log.levels.WARN)
              end
              local msgs = chat.messages or {}
              local last = msgs[#msgs]
              chat:clear()
              chat:add_message({ role = "system", content = system_prompt })
              if last then
                chat:add_message({ role = last.role, content = last.content })
              end
            end
          },
        },
      },
      window = { width = 100 },
      log_level = "DEBUG",
    },
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = { model = { default = "o4-mini" } },
        })
      end,
    },
    prompt_library = prompt_library,
    extensions = {
      history = {
        enabled = true,
        callback = require("plugins.ai.extensions.codecompanion.history"),
        opts = { data_dir = data_dir },
      },
    },
  },
  keys = {
    { "<leader>cc", false },
    { "<leader>ac", "<cmd>CodeCompanionActions<CR>",     desc = "CodeCompanionActions" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanionChat",                   mode = { "n" } },
    { "<leader>aa", "<cmd>CodeCompanionChat Add<CR>",    desc = "Send selection to CodeCompanionChat", mode = { "v" } },
    { "<leader>al", "<cmd>CodeCompanionLoad<CR>",        desc = "Load a CodeCompanionChat summary",    mode = { "n" } },
    { "<leader>as", "<cmd>CodeCompanionSave<CR>",        desc = "Save a CodeCompanionChat summary",    mode = { "n" } },
    { "<leader>an", ":file ",                            desc = "Change the name of a buffer",         mode = { "n" } },
  },
}
