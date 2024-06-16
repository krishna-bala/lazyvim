return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
  },
  opts = {
    buffers = {
      bind_to_cwd = false,
    },
    filesystem = {
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
  },
}
