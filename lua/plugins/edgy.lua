return {
  "folke/edgy.nvim",
  opts = function(_, opts)
    opts.left = {
      {
        title = "Explorer",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        pinned = true,
        open = "Neotree",
      },
      {
        title = "Buffers",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        pinned = true,
        open = "Neotree buffers dir=/",
      },
      {
        title = "Git",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "git_status"
        end,
        pinned = true,
        open = "Neotree git_status",
      },
      "neo-tree",
    }
    opts.right = opts.right or {}
    -- Find and update the existing copilot-chat element
    for i, item in ipairs(opts.right) do
      if item.ft == "copilot-chat" then
        opts.right[i] = {
          ft = "copilot-chat",
          title = "Copilot Chat",
          size = { width = 80 },
        }
        break
      end
    end
  end,
  keys = {
    -- require("edgy").toggle()
    { "<leader>ue", false },
    {
      "<leader>ee",
      function()
        require("edgy").toggle()
      end,
      desc = "Edgy Toggle",
    },
    -- require("edgy").select()
    { "<leader>uE", false },
    {
      "<leader>es",
      function()
        require("edgy").select()
      end,
      desc = "Edgy Select Window",
    },
    {
      "<leader>ed",
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_status = vim.b[current_buf].edgy_disable
        vim.b[current_buf].edgy_disable = not current_status
      end,
      desc = "Edgy Disable/Enable Current Buffer",
    },
    {
      "<leader>eb",
      function()
        require("neo-tree.command").execute({ source = "buffers", dir = "/" })
      end,
      desc = "Edgy Buffers",
    },
    {
      "<leader>eB",
      function()
        require("neo-tree.command").execute({ source = "buffers", dir = LazyVim.root() })
      end,
      desc = "Edgy Buffers",
    },
    {
      "<leader>eg",
      function()
        require("neo-tree.command").execute({ source = "git_status" })
      end,
      desc = "Edgy Git",
    },
    {
      "<leader>ef",
      function()
        require("neo-tree.command").execute({ source = "filesystem" })
      end,
      desc = "Edgy Files",
    },
  },
}
