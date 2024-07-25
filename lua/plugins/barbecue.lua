return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- configurations go here
    create_autocmd = true, -- prevent barbecue from updating itself automatically
    attach_navic = false,  -- prevent barbecue from automatically attaching nvim-navic
  },
}
