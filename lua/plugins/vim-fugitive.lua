return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      {
        "<leader>gdom",
        "<cmd>Git difftool -y --merge-base origin/master<CR>",
        desc = ":Git difftool -y --merge-base origin/master",
      },
      {
        "<leader>gd<space>",
        ":Git difftool -y --merge-base ",
        desc = ":Git difftool --merge-base -y <arg>",
      },
      {
        "<leader>gb",
        "<cmd>Git blame<CR>",
        desc = ":Git blame",
      }
    }
  },

  {
    "tommcdo/vim-fubitive",
  },
}
