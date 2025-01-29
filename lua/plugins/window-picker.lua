return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  keys = {
    {
      "<leader>wp",
      function()
        -- Get filename under cursor
        local filename = vim.fn.expand("<cfile>")
        -- Store current window
        local current_win = vim.api.nvim_get_current_win()
        -- Use window-picker to select target window
        local picked_window = require("window-picker").pick_window()
        if picked_window then
          -- Focus picked window
          vim.api.nvim_set_current_win(picked_window)
          -- Open file in that window
          vim.cmd("edit " .. filename)
          -- Return to original window
          vim.api.nvim_set_current_win(current_win)
        end
      end,
      desc = "Open file under cursor in picked window",
    },
  },
}
