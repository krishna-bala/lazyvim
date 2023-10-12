if false then
  return {}
end


return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    return {
      "telescope",
      winopts = {
        height = 0.90,
        width = 0.95,

      }
    }
  end,
  keys = {
    {
      "<leader>/",
      "<cmd>FzfLua live_grep_glob<CR>",
      desc = "Live Grep (Args)",
    },
    {
      "<leader>?",
      "<cmd>FzfLua live_grep_resume<CR>",
      desc = "Live Grep (Args)",
    },
    {
      "<leader>sw",
      "<cmd>FzfLua grep_cword<CR>",
      desc = "Grep Current Word",
    },
  }
}
