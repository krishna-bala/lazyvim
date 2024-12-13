-- return {}
return {
  "ibhagwan/fzf-lua",
  -- lazy = false,
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    -- local winopts = opts.winopts or {}
    -- winopts.height = 0.90
    -- winopts.width = 0.95
    -- opts.winopts = winopts
    return opts
  end,
  keys = {
    { "<leader>/", LazyVim.pick("live_grep_glob"), desc = "Live Grep (Root Dir)" },
    { "<leader><C-/>", "<cmd>FzfLua live_grep_glob resume=true<CR>", desc = "Live Grep (Args)" },
    -- {
    --   "<leader>gs",
    --   "<cmd>FzfLua git_status<CR>",
    --   desc = "Git Status",
    -- },
  },
}
