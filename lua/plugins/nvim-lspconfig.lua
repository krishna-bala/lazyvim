return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change the goto definition mapping so it doesn't reuse an open window
    keys[#keys + 1] = { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = false})<cr>" }
  end,
  opts = {
    servers = {
      -- Ensure mason installs the server
      clangd = {
        keys = {
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      pylsp = {
        pylsp = {
          -- add specific configurations for pylsp here
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                yapf = { enabled = true }
              }
            }
          }
        },
      }
    },
    setup = {
      clangd = function(_, opts)
        local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        return false
      end,
    },
  },
}
