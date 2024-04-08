return {
  {
    "catppuccin/nvim",
    lazy = false,
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = {
      -- toggle theme style ---
      toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
      style = "dark",
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
  },

  {
    "rose-pine/neovim",
    lazy = false,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
  },

  {
    "shaunsingh/nord.nvim",
    lazy = false,
  },

  {
    "rmehri01/onenord.nvim",
    lazy = false,
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
  },

  {
    "embark-theme/vim",
    lazy = false,
  },

  {
    "ribru17/bamboo.nvim",
    lazy = false,
  },

  {
    "LunarVim/lunar.nvim",
    lazy = false,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
