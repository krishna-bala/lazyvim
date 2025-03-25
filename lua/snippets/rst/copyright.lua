local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node

return {
  s({
    trig = "copyright",
    name = "Copyright Header",
    dscr = "Insert copyright header with current year",
  }, {
    t({
      ".. Copyright (c) Fox Robotics " .. os.date("%Y") .. ", All Rights Reserved",
      "",
    }),
  }),
}
