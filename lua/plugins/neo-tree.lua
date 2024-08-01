return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      -- following filters are only applied when you are using the default filter
      -- defined by this plugin. If you pass in a function to "filter_func"
      -- property, you are on your own
      filter_rules = {
        -- when there is only one window available to pick from, use that window
        -- without prompting the user to select
        autoselect_one = true,

        -- whether you want to include the window you are currently on to window
        -- selection or not
        include_current_win = false,

        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "NvimTree", "neo-tree", "notify", "edgy" },

          -- if the file type is one of following, the window will be ignored
          buftype = { "terminal", "nofile" },
        },

        -- filter using window options
        wo = {},

        -- if the file path contains one of following names, the window
        -- will be ignored
        file_path_contains = {},

        -- if the file name contains one of following names, the window will be
        -- ignored
        file_name_contains = {},
      },
    },
  },
  opts = {
    buffers = {
      bind_to_cwd = false,
      show_unloaded = true,
    },
    filesystem = {
      bind_to_cwd = false,
      window = {
        mappings = {
          -- disable fuzzy finder
          ["/"] = "noop",
        },
      },
    },
  },
  keys = {
    {
      "<leader>bE",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true, dir = "/home/krishna" })
      end,
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true, dir = "/" })
      end,
    },
    {
      "<leader>e",
      false,
    },
    {
      "<leader>E",
      false,
    },
  },
}
