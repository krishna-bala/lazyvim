return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    -- select a session to load
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
  },
}
