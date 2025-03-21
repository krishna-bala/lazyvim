local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

return {
  s("cc_library", {
    t({
      "cc_library(",
      '\tname = "',
    }),
    i(1, '"lib_name"'),
    t({
      '",',
      "\tsrcs = [",
      '\t\t"',
    }),
    i(2, "cc_files"),
    t({
      '"',
      "\t],",
      "\thdrs = [",
      '\t\t"',
    }),
    i(3, "h_files"),
    t({
      '"',
      "\t],",
      "\tdeps = [",
      '\t\t"',
    }),
    i(4, "deps"),
    t({
      '"',
      "\t],",
      ")",
    }),
  }),
}
