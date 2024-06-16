return {
  "folke/edgy.nvim",
  opts = function(_, opts)
    opts.left = {
      {
        title = "Neo-Tree Buffers",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        pinned = true,
        open = "Neotree position=top buffers dir=/home/krishna",
      },
      { title = "Neotest Summary", ft = "neotest-summary" },
      {
        title = "Neo-Tree Git",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "git_status"
        end,
        pinned = true,
        open = "Neotree position=right git_status",
      },
      -- {
      --   title = "Neo-Tree",
      --   ft = "neo-tree",
      --   filter = function(buf)
      --     return vim.b[buf].neo_tree_source == "filesystem"
      --   end,
      --   pinned = true,
      --   open = function()
      --     require("neo-tree.command").execute({ dir = LazyVim.root() })
      --   end,
      --   size = { height = 0.5 },
      -- },
      "neo-tree",
    }
  end,
}
