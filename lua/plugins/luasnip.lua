return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        -- Method 1: Specify filetypes to exclude when loading
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "tex", "latex" }, -- Add filetypes you want to exclude
        })
        require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
      end,
    },
    lazy = false,
  },
}
