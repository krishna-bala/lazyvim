return {
  "folke/edgy.nvim",
  enabled = false,
  opts = function(_, opts)
    opts.right = opts.right or {}

    -- Add claude-code integration
    table.insert(opts.right, {
      ft = "claude-code",
      title = "Claude Code",
      size = { width = 0.5 },
      filter = function(buf, win)
        -- Only include non-floating windows
        return vim.api.nvim_win_get_config(win).relative == ""
      end,
    })
    return opts
  end,
  keys = {
    { "<leader>ue", false },
    { "<leader>uE", false },
    {
      "<leader>ueE",
      function()
        require("edgy").select()
      end,
      desc = "Edgy Select Window",
    },
    {
      "<leader>uet",
      function()
        require("edgy").toggle()
      end,
      desc = "Toggle Edgy",
    },
    {
      "<leader>ued",
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_status = vim.b[current_buf].edgy_disable
        vim.b[current_buf].edgy_disable = not current_status
      end,
      desc = "Edgy Disable/Enable Current Buffer",
    },
  },
}
