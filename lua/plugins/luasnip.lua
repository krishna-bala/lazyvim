return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        -- Specify filetypes to exclude when loading
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "tex", "latex" },
        })
        -- Hand-crafted snippets, see cpp example
        require("luasnip.loaders.from_lua").lazy_load({
          paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
        })
      end,
    },
    opts = {
      -- Visual select then <Tab> for special snippets, see cpp #ifndef
      store_selection_keys = "<Tab>",
    },
    lazy = false,
  },
}
