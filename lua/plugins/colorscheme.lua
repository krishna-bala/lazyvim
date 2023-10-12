if false then
  return {}
end

return {
  {
    "catppuccin/nvim",
    lazy = false,
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = {
      style = "cool",
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
