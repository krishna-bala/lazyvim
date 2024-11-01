-- LuaSnip core functionality
local ls = require("luasnip")

-- Snippet, SnippetNode creation
local s = ls.snippet
local sn = ls.snippet_node

-- Basic text and insert nodes
local t = ls.text_node
local i = ls.insert_node

-- Dynamic nodes for advanced behavior
local f = ls.function_node
local d = ls.dynamic_node

-- Formatting utilities
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- Node repetition
local rep = require("luasnip.extras").rep

return {
  -- Basic LaTeX template
  s({
    trig = "template",
    name = "Basic template",
    dscr = "Basic article template"
  }, {
    t({
      "\\documentclass[a4paper]{article}",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage[T1]{fontenc}",
      "\\usepackage{textcomp}",
      "\\usepackage[dutch]{babel}",
      "\\usepackage{amsmath, amssymb}",
      "",
      "% figure support",
      "\\usepackage{import}",
      "\\usepackage{xifthen}",
      "\\usepackage{pdfpages}",
      "\\usepackage{transparent}",
      "",
      "\\pdfminorversion=7",
      "\\pdfsuppresswarningpagegroup=1",
      "",
      "\\newcommand{\\incfig}[1]{%",
      "\\def\\svgwidth{\\columnwidth}",
      "\\import{./figures/}{#1.pdf_tex}",
      "}",
      "",
      "\\begin{document}",
      "",
    }),
    i(0),
    t({ "", "\\end{document}" })
  })
}
