if false then
  return {}
end

local _on_attach = function()
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(0, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(0, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.lsp.set_log_level("trace")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- buf_set_keymap("n", "<leader><C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "gsh", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
  -- buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  -- buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

local lspconfig = require("lspconfig")

-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     setup = {
--       clangd = function(_, opts)
--         opts.cmd = {
--           "clangd",
--           unpack(_clangd_flags),
--         }
--         opts.capabilities.offsetEncoding = { "utf-16" }
--         opts.root_dir = lspconfig.util.root_pattern("compile_commands.json")
--         opts.on_attach = _on_attach
--         opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
--       end,
--     },
--   },
-- }
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = vim.tbl_extend("force", opts.servers, {
      clangd = {},
      bufls = {},
    })
    opts.setup = {
      clangd = function(_, _opts)
        _opts.cmd = {
          "clangd",
          "--log=error",
          "--background-index",
          -- "--cross-file-rename",
          "--compile-commands-dir=/home/krishna/foxbots/",
          -- "--offset-encoding=utf-16",
        }
        _opts.capabilities.offsetEncoding = { "utf-16" }
        _opts.root_dir = lspconfig.util.root_pattern("compile_commands.json")
        _opts.on_attach = _on_attach
        _opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
      end,
      bufls = function(_, _opts)
        _opts.cmd = {
          "bufls",
          "serve",
        }
        _opts.whitelist = { "proto" }
      end,
    }
  end,
}
