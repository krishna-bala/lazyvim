return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
    copilot_model = "gpt-4o-copilot", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
  },
  keys = {
    {
      "<leader>at",
      function()
        local copilot_status = require("copilot.client").is_disabled()
        if copilot_status then
          vim.cmd("Copilot enable")
        else
          vim.cmd("Copilot disable")
        end
        vim.notify("Copilot " .. (copilot_status and "enabled" or "disabled"), vim.log.levels.INFO)
      end,
      desc = "Toggle Copilot",
    },
  },
}
