return {
  "folke/todo-comments.nvim",
  -- Update highlighting to include the author name and to not include teh parentheses
  -- e.g. NOTE(krishna):
  opts = {
    highlight = {
      before = "",
      keyword = "bg",
      after = "fg",
      pattern = [[.*<(KEYWORDS).*:]],
    },
  },
}
