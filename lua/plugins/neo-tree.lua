return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
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
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true, dir = "/home/krishna" })
      end,
    },
    {
      "<leader>bE",
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
