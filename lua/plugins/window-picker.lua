return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  opts = {
    hint = "floating-big-letter",
    show_prompt = false,
    -- following filters are only applied when you are using the default filter
    -- defined by this plugin. If you pass in a function to "filter_func"
    -- property, you are on your own
    filter_rules = {
      -- when there is only one window available to pick from, use that window
      -- without prompting the user to select
      autoselect_one = true,

      -- whether you want to include the window you are currently on to window
      -- selection or not
      include_current_win = false,

      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "NvimTree", "neo-tree", "notify", "edgy" },

        -- if the file type is one of following, the window will be ignored
        buftype = { "terminal", "nofile" },
      },

      -- filter using window options
      wo = {},

      -- if the file path contains one of following names, the window
      -- will be ignored
      file_path_contains = {},

      -- if the file name contains one of following names, the window will be
      -- ignored
      file_name_contains = {},
    },
  },
  keys = {
    -- {
    --   "<leader>wp",
    --   function()
    --     -- Get filename under cursor
    --     local filename = vim.fn.expand("<cfile>")
    --     -- Store current window
    --     local current_win = vim.api.nvim_get_current_win()
    --     -- Use window-picker to select target window
    --     local picked_window = require("window-picker").pick_window()
    --     if picked_window then
    --       -- Focus picked window
    --       vim.api.nvim_set_current_win(picked_window)
    --       -- Open file in that window
    --       vim.cmd("edit " .. filename)
    --       -- Return to original window
    --       vim.api.nvim_set_current_win(current_win)
    --     end
    --   end,
    --   desc = "Open file under cursor in picked window",
    -- },
  },
}
