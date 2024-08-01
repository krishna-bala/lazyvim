return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change the goto definition mapping so it doesn't reuse an open window
    table.insert(keys, { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = false})<cr>" })
    -- keys[#keys + 1] = { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = false})<cr>" }
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
        -- stylua: ignore start
        cmd = {
          "docker", "run", "--rm", "-i",
          -- "-v", "foxbots-home:/home/krishna/",
          "-v", "/home/krishna/.cache/bazel:/home/krishna/.cache/bazel",
          "-v", "/home/krishna/foxbots:/home/krishna/foxbots",
          "--workdir", "/home/krishna/foxbots",
          "--entrypoint", "clangd-14",
          "gcr.io/studied-biplane-165901/foxbots/devel-tools:latest",
          -- clangd arguments
          "--compile-commands-dir", "/home/krishna/foxbots",
          "--background-index", "--clang-tidy",
          "--completion-style=detailed", "--function-arg-placeholders",
          "--fallback-style=llvm", "--header-insertion=never",
          "--query-driver=**",
        },
        -- stylua: ignore end
      },
      pylsp = {
        -- add specific configurations for pylsp here
        settings = {
          pylsp = {
            plugins = {
              rope = { enabled = false },
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              isort = { enabled = false },
              flake8 = { enabled = false },
              -- pylint doesn't play nice with bazel
              pylint = { enabled = false },
            },
          },
        },
        root_dir = function(fname)
          return require("lspconfig").util.root_pattern("requirements.txt")(fname) or vim.fn.getcwd()
        end,
      },
    })
  end,
}
