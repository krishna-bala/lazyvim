return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 2,
    pattern = { "*" },
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
      {
        name = "mini_indentscope",
        disable = function(buf)
          vim.b[buf].miniindentscope_disable = true
        end,
      },
      {
        name = "mini_animate",
        disable = function(buf)
          vim.b[buf].minianimate_disable = true
        end,
      },
      {
        name = "flash",
        disable = function(buf)
          require("flash").toggle()
        end,
      },
    },
  },
}
