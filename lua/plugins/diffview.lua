return {
  "sindrets/diffview.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- Ensure gitsigns loads when diffview opens
  },
  opts = {
    keymaps = {
      view = {
        -- Override treesitter-textobjects ]c/[c class navigation with native diff navigation
        { "n", "]c", function() vim.cmd("normal! ]c") end, { desc = "Next change" } },
        { "n", "[c", function() vim.cmd("normal! [c") end, { desc = "Previous change" } },
      },
    },
    view = {
      merge_tool = {
        -- Config for conflicted files in diff views during a merge or rebase.
        layout = "diff3_mixed",
        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
      },
    },
  },
}
