if false then
  return {}
end

return {
  "nvim-treesitter/nvim-treesitter-context",
  keys = {
    {
      "<leader>cc",
      function()
        require("treesitter-context").toggle()
      end,
    },
  },
}
