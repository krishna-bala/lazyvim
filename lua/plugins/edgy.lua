return {
  "folke/edgy.nvim",
  opts = function(_, opts)
    opts.right = opts.right or {}
    -- Find and update the existing copilot-chat element
    for i, item in ipairs(opts.right) do
      if item.ft == "copilot-chat" then
        opts.right[i] = {
          ft = "copilot-chat",
          title = "Copilot Chat",
          size = { width = 0.35 },
        }
        break
      end
    end
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
