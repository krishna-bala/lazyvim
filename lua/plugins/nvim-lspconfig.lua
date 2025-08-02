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
          "-v", "/home/krishna/.cache/bazel:/home/krishna/.cache/bazel",
          "-v", vim.fn.getcwd() .. ":/home/krishna/foxbots",
          "--workdir", "/home/krishna/foxbots",
          "--entrypoint", "clangd-19",
          "gcr.io/studied-biplane-165901/foxbots/devel-tools:2025-04-14",
          -- clangd arguments
          "--compile-commands-dir", "/home/krishna/foxbots",
          "--background-index", "--clang-tidy",
          "--completion-style=detailed", "--function-arg-placeholders",
          "--fallback-style=llvm", "--header-insertion=iwyu",
          "--query-driver=**",
          "--path-mappings=" .. vim.fn.getcwd() .. "=/home/krishna/foxbots",
        },
        -- stylua: ignore end
      },
      pylsp = { enabled = false },
      pyright = {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Use strict type checking
              typeCheckingMode = "standard",
              -- Auto import completions
              autoImportCompletions = true,
              -- Use library code for go to definition
              useLibraryCodeForTypes = true,
              -- Disable diagnostics since Ruff handles linting
              diagnosticMode = "openFilesOnly",
              -- Optionally, you can completely disable Pyright diagnostics
              -- ignore = { '*' },
            },
          },
        },
        -- Detect virtual environment
        on_attach = function(client, bufnr)
          -- Check if we're in a virtual environment
          local venv = vim.fn.finddir(".venv", vim.fn.getcwd() .. ";")
          if venv ~= "" then
            local venv_python = venv .. "/bin/python"
            if vim.fn.filereadable(venv_python) == 1 then
              client.config.settings.python.pythonPath = venv_python
            end
          end
        end,
      },
      ruff = {
        settings = { ruff = {} },
        -- Set up ruff with modified capabilities
        on_attach = function(client, bufnr)
          -- Disable hover capability since Pyright handles it
          client.server_capabilities.hoverProvider = false
        end,
      },
      eslint = {
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "yaml",
          "yml",
        },
        settings = {
          workingDirectories = {
            mode = "auto",
          },
          format = true,
        },
      },
      marksman = { enabled = false },
    })
  end,
}
