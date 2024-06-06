return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  -- init = function()
  --   LazyVim.lsp.on_attach(function(client, buffer)
  --     if client.server_capabilities["documentSymbolProvider"] then
  --       require("nvim-navic").attach(client, buffer)
  --     end
  --   end)
  -- end,
  opts = {
    -- configurations go here
    create_autocmd = false, -- prevent barbecue from updating itself automatically
    attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
  },
}
