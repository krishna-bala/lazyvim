return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- dont show the winbar for some filetypes
    opts.options.disabled_filetypes = {
      winbar = { "dashboard", "lazy", "alpha", "edgy", "neo-tree", "toggleterm", "harpoon" },
      statusline = { "dashboard", "alpha", "ministarter", "harpoon" },
    }

    local icons = LazyVim.config.icons
    local b_filename = {
      LazyVim.lualine.root_dir(),
      {
        LazyVim.lualine.pretty_path(),
        separator = "",
      },
      {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 0, right = 0 },
      },
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
    }
    opts.winbar = {
      lualine_b = b_filename,
    }
    opts.inactive_winbar = {
      lualine_b = b_filename,
    }
    -- opts.options.globalstatus = true
    opts.sections.lualine_c = {}

    return opts
  end,
}
