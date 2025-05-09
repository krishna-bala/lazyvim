return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = "copilot", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    ---@alias Mode "agentic" | "legacy"
    mode = "agentic",     -- The default mode for interaction.
    -- "agentic" uses tools to automatically generate code,
    -- "legacy" uses the old planning method to generate code.
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because:
    -- https://github.com/yetone/avante.nvim/issues/1048
    auto_suggestions_provider = "claude",
    -- The provider used in the applying phase of Cursor Planning Mode,
    -- defaults to nil, when nil uses Config.provider as the provider for the applying phase
    cursor_applying_provider = nil,
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      api_key_name = { "pass", "api-keys/ANTHROPIC_API_KEY" },
      temperature = 0,
      max_tokens = 4096,
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
    copilot = {
      model = "claude-3.7-sonnet",
    },
    vendors = {
      ["copilot-thought"] = {
        __inherited_from = "copilot",
        model = "claude-3.7-sonnet-thought",
        display_name = "claude-3.7-sonnet-thought",
      },
    },
    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.
    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = "openai",
      second_provider = "claude",
      prompt = [[
      Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective.
      Do not provide any explanation, just give the response directly.
      Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]
      ]],
      timeout = 60000, -- Timeout in milliseconds
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,         -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-c>", "<Esc>", "q" },
        insert = { "<C-c>" },
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
        close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
      },
    },
    hints = { enabled = true },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true,        -- similar to vim.o.wrap
      width = 30,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
    -- File selector configuration
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
    selector = {
      provider = "snacks", -- Avoid native provider issues
      provider_opts = {},
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescopejkj
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  -- keys = {
  --   -- Mimic CopilotChat keybindings
  --   {
  --     "<leader>ap",
  --     function()
  --       -- Select a prompt from our prompts list
  --       vim.ui.select(vim.tbl_keys(require("prompts.copilot-prompts")), {
  --         prompt = "Select Prompt",
  --       }, function(prompt_name)
  --         if prompt_name then
  --           local prompt = require("prompts.copilot-prompts")[prompt_name].prompt
  --           -- Use Avante with the selected prompt
  --           vim.cmd("AvanteAsk " .. vim.fn.escape(prompt, " "))
  --         end
  --       end)
  --     end,
  --     desc = "Avante - Select Prompt",
  --     mode = { "n", "v" },
  --   },
  --   -- {
  --   --   "<leader>aa",
  --   --   function()
  --   --     vim.cmd("AvanteAsk")
  --   --   end,
  --   --   desc = "Avante - Open Chat",
  --   --   mode = { "n", "v" },
  --   -- },
  --   {
  --     "<leader>as",
  --     function()
  --       local mode = vim.fn.mode()
  --       if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
  --         -- Not in visual mode, select the entire buffer
  --         vim.cmd("normal! ggVG")
  --       end
  --       vim.cmd("AvanteAsk")
  --     end,
  --     desc = "Avante - Chat with Selection",
  --     mode = { "n", "v" },
  --   },
  --   {
  --     "<leader>ax",
  --     function()
  --       vim.cmd("AvanteClear")
  --     end,
  --   }
  -- },
}

--   lazy = false,
--   version = false, -- set this if you want to always pull the latest change
--   opts = {
--     provider = "claude",
--     auto_suggestions_provider = "copilot",
--     behaviour = {
--       auto_suggestions = true,
--       auto_suggestions_delay = 500,
--     },
--     claude = {
--       api_key_name = "cmd:bw get notes anthropic-api-key", -- the shell command must prefixed with `^cmd:(.*)`
--       -- api_key_name = {"bw","get","notes","anthropic-api-key"}, -- if it is a table of string, then default to command.
--     },
--   },
--   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--   build = "make",
--   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     --- The below dependencies are optional,
--     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--     "zbirenbaum/copilot.lua", -- for providers='copilot'
--     {
--       -- support for image pasting
--       "HakonHarnes/img-clip.nvim",
--       event = "VeryLazy",
--       opts = {
--         -- recommended settings
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           -- required for Windows users
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       -- Make sure to set this up properly if you have lazy=true
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- }
