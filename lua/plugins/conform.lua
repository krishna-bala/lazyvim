return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  opts = {
    formatters_by_ft = {
      sh = { "shfmt", "shellharden" },
      markdown = { "prettier" },
      python = { "docformatter", "black" },
    },
    -- LazyVim will merge the options you set here with builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string,table>
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- -- Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  keys = { { "<leader>cc", "<cmd>ConformInfo<cr>", desc = "Conform Info" } },
}
