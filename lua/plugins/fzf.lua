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
      },
      previewer = "builtin",
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
      mode = { "n", "v" },
      function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == "n" then
          -- In normal mode, visually select the word under cursor first
          vim.cmd("normal yiw")
        elseif mode == "v" or mode == "V" or mode == "\x16" then
          vim.cmd("normal y")
          -- TODO
        end
        local text = vim.fn.getreg('"')

        vim.cmd("FzfLua live_grep_glob")
        vim.fn.feedkeys(text, "t")
      end,

      -- "<cmd>FzfLua grep_cword<CR>",
      desc = "Grep Current Word",
    },
    {
      "<leader>gs",
      "<cmd>FzfLua git_status<CR>",
      desc = "Git Status",
    },
  },
}
