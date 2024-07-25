return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.globalstatus = true
    opts.sections.lualine_z = {}
    opts.inactive_sections = {
      lualine_b = {},
      lualine_c = opts.sections.lualine_c,
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    }
    return opts
  end,
}
