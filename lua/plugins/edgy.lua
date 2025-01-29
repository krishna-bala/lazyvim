return {
  "folke/edgy.nvim",
  opts = function(_, opts)
    opts.left = {
      -- {
      --   title = "Oil",
      --   ft = "oil",
      --   pinned = true,
      --   wo = { winbar = true },
      --   filter = function(buf, win)
      --     return vim.api.nvim_win_get_config(win).relative == ""
      --   end,
      --   open = function()
      --     vim.cmd("vnew")
      --     local current_win = vim.api.nvim_get_current_win()
      --     local current_buf = vim.api.nvim_win_get_buf(current_win)
      --     -- If current window is edgy, use cwd, otherwise use current window's directory
      --     local path = vim.b[current_buf].edgy and vim.fn.getcwd() or vim.fn.getcwd(current_win)
      --     vim.cmd(("Oil %s"):format(path))
      --   end,
      -- },
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
    {
      "<leader>ued",
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_status = vim.b[current_buf].edgy_disable
        vim.b[current_buf].edgy_disable = not current_status
      end,
      desc = "Edgy Disable/Enable Current Buffer",
    },
    {
      "<leader>ueb",
      function()
        require("neo-tree.command").execute({ source = "buffers", dir = "/" })
      end,
      desc = "Edgy Buffers",
    },
    {
      "<leader>ueB",
      function()
        require("neo-tree.command").execute({ source = "buffers", dir = LazyVim.root() })
      end,
      desc = "Edgy Buffers",
    },
    {
      "<leader>ueg",
      function()
        require("neo-tree.command").execute({ source = "git_status" })
      end,
      desc = "Edgy Git",
    },
    {
      "<leader>uef",
      function()
        require("neo-tree.command").execute({ source = "filesystem" })
      end,
      desc = "Edgy Files",
    },
    -- {
    --   "<leader>ueo",
    --   function()
    --     vim.cmd("vnew")
    --     local current_win = vim.api.nvim_get_current_win()
    --     local current_buf = vim.api.nvim_win_get_buf(current_win)
    --     -- If current window is edgy, use cwd, otherwise use current window's directory
    --     local path = vim.b[current_buf].edgy and vim.fn.getcwd() or vim.fn.getcwd(current_win)
    --     vim.cmd(("Oil %s"):format(path))
    --   end,
    --   desc = "Edgy Files",
    -- },
  },
}
