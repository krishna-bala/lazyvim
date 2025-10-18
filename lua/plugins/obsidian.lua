return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "foxbots",
        path = "~/Documents/foxbots",
      },
    },

    -- Disable wiki link warnings
    disable_frontmatter = false,
  },
}
