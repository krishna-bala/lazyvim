return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  opts = function(_, opts)
    local default_on_attach = opts.on_attach
    opts.on_attach = function(buffer)
      default_on_attach(buffer)
      vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Gitsigns blame file", buffer = buffer })
    end
    return opts
  end,
}
