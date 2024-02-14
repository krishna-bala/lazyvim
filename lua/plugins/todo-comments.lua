return {
  "folke/todo-comments.nvim",
  -- Update highlighting to include the author name and to not include teh parentheses
  -- e.g. NOTE(krishna):
  opts = {
    highlight = {
      multiline = true,               -- enable multine todo comments
      multiline_pattern = "^.",       -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10,         -- extra lines that will be re-evaluated when changing a line
      before = "",                    -- "fg" or "bg" or empty
      keyword = "bg",                 -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
      after = "fg",                   -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS).*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      comments_only = true,           -- uses treesitter to match keywords in comments only
      max_line_len = 400,             -- ignore lines longer than this
      exclude = {},                   -- list of file types to exclude highlighting
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS).*:]], -- ripgrep regex
    }
  },
}
