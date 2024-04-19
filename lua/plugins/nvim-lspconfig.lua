return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change the goto definition mapping so it doesn't reuse an open window
    keys[#keys + 1] = { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = false})<cr>" }
  end,
  opts = function(_, opts)
    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      clangd = {
        keys = {
          { "<leader>cR", false },
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        filetypes = {
          "c",
          "cpp",
          "cuda",
        },
      },
      pylsp = {
        -- add specific configurations for pylsp here
        settings = {
          pylsp = {
            plugins = {
              rope = { enabled = false },
              pyflakes = { enabled = true },
              mccabe = { enabled = true },
              pycodestyle = { enabled = true },
              pydocstyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = true },
              isort = { enabled = true },
              flake8 = { enabled = false },
              -- pylint doesn't play nice with bazel
              pylint = { enabled = false },
            },
          },
        },
      },
    })
  end,
}
