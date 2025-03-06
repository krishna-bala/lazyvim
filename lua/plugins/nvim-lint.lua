return {
  "mfussenegger/nvim-lint",
  -- lazy = false,
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      -- cpp = { "cpplint" },
      sh = { "shellcheck" },
      dockerfile = { "hadolint" },
      -- rst = { "doc8" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
    },
    -- LazyVim extension to easily override linter options
    -- or add custom linters.
    ---@type table<string,table>
    linters = {
      shellcheck = {
        args = { "-x" },
      },
      -- -- Example of using selene only when a selene.toml file is present
      -- selene = {
      --   -- `condition` is another LazyVim extension that allows you to
      --   -- dynamically enable/disable linters based on the context.
      --   condition = function(ctx)
      --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      -- doc8 = {
      --   cmd = "/home/krishna/.local/bin/doc8",
      --   stdin = false,
      --   args = { "--quiet", "$FILENAME" },
      --   stream = "stderr", -- Change from stderr to stdout
      --   ignore_exitcode = true,
      --   parser = require("lint.parser").from_pattern(
      --     "(.+):(%d+): (.+)",
      --     { "file", "lnum", "message" },
      --     {
      --       [""] = vim.diagnostic.severity.INFO,
      --     }, -- default severity mapping
      --     { source = "doc8" }
      --   ),
      -- },
    },
  },
}
