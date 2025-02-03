return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
  },
}
