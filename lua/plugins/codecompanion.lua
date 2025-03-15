return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
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
  keys = {
    {
      "<leader>ap",
      function()
        -- Use CodeCompanionActions instead of the non-existent prompt.pick
        vim.cmd("CodeCompanionActions")
      end,
      desc = "CodeCompanion Prompt Actions",
    },
    {
      "<leader>aa",
      function()
        local temp_buf = vim.api.nvim_create_buf(false, true)
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_win_set_buf(current_win, temp_buf)

        require("codecompanion").toggle()
        vim.api.nvim_win_set_buf(current_win, current_buf)
        vim.api.nvim_buf_delete(temp_buf, { force = true })
      end,
      desc = "CodeCompanion - No Selection",
      mode = { "n", "v" },
    },
    {
      "<leader>as",
      function()
        local mode = vim.fn.mode()
        if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
          vim.cmd("normal! ggVG")
        end
        require("codecompanion").toggle()
      end,
      desc = "CodeCompanion Selection",
      mode = { "n", "v" },
    },
    {
      "<leader>aw",
      function()
        vim.ui.input({ prompt = "Save chat to file (empty for default): " }, function(filename)
          if filename == "" then
            require("codecompanion.chat").save()
          elseif filename then
            require("codecompanion.chat").save(filename)
          end
        end)
      end,
      desc = "CodeCompanion Save (with prompt)",
      mode = { "n", "v" },
    },
    {
      "<leader>al",
      function()
        vim.ui.input({ prompt = "Load chat from file (empty for default): " }, function(filename)
          if filename == "" then
            require("codecompanion.chat").load()
          elseif filename then
            require("codecompanion.chat").load(filename)
          end
        end)
      end,
      desc = "CodeCompanion Load (with prompt)",
      mode = { "n", "v" },
    },
  },
}
