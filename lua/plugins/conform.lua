return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  opts = {
    formatters_by_ft = {
      sh = { "shfmt", "shellharden" },
      markdown = { "prettier" },
      python = { "docformatter", "black" },
      bzl = { "buildifier" },
      proto = { "buf" },
    },
  },
}
