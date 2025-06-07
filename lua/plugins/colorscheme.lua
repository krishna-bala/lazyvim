return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      --   transparent = true,
      on_highlights = function(hl, c)
        hl.WinSeparator = {
          fg = c.terminal_black,
          bold = true,
        }
      end,
    },
  },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
