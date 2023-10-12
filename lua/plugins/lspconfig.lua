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
  buf_set_keymap("n", "gsh", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local lspconfig = require("lspconfig")

return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change the goto definition mapping so it doesn't reuse an open window
    keys[#keys + 1] = { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = false})<cr>" }
  end,
  opts = function(_, opts)
    opts.servers = vim.tbl_extend("force", opts.servers, {
      clangd = {
        cmd = {
          "clangd",
          "--log=error",
          "--background-index",
          -- "--cross-file-rename",
          "--compile-commands-dir=/home/krishna/foxbots/",
          -- "--offset-encoding=utf-16",
        },
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        root_dir = lspconfig.util.root_pattern("compile_commands.json"),
        on_attach = _on_attach,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      },
    })
  end,
}
