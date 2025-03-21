local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
  s({
    trig = "ns_fox",
    name = "namespace fox",
    dscr = "Create a Fox namespace block",
  }, {
    t({
      "namespace fox {",
      "",
      "",
    }),
    i(0),
    t({
      "",
      "",
      "}",
    }),
  }),
}
