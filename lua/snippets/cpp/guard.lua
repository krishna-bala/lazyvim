-- LuaSnip core functionality
local ls = require("luasnip")

-- Snippet creation
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local sn = ls.snippet_node

return {
  -- Header guard snippet without "INCLUDE" prefix
  s({
    trig = "#ifndef",
    name = "Header Guard",
    dscr = "Creates a header guard in the format PATH_TO_FILENAME_H_ wrapping selected text or empty",
  }, {
    f(function(_, snip)
      local file_stem = vim.fn.expand("%:t:r")
      local file_path = vim.fn.expand("%:p")
      local root = LazyVim.root()
      -- Extract relative path from project root
      local rel_path = ""
      if root ~= "" then
        rel_path = file_path:gsub(root .. "/", "")
        -- Extract directory without filename
        rel_path = rel_path:gsub("/[^/]+$", "")
      end

      -- Split directory into components and uppercase
      local dir_parts = {}
      for part in string.gmatch(rel_path, "[^/\\]+") do
        table.insert(dir_parts, string.upper(part))
      end

      local guard = table.concat(dir_parts, "_") .. "_" .. string.upper(file_stem) .. "_H_"

      return {
        "#ifndef " .. guard,
        "#define " .. guard,
        "",
        "",
      }
    end),
    d(1, function(_, snip)
      if snip.env.SELECT_RAW and #snip.env.SELECT_RAW > 0 then
        return sn(nil, { t(snip.env.SELECT_RAW) })
      else
        return sn(nil, { i(1) })
      end
    end),
    t({ "", "" }),
    f(function()
      local file_stem = vim.fn.expand("%:t:r")
      local file_path = vim.fn.expand("%:p")
      local root = LazyVim.root()
      -- Extract relative path from project root
      local rel_path = ""
      if root ~= "" then
        rel_path = file_path:gsub(root .. "/", "")
        -- Extract directory without filename
        rel_path = rel_path:gsub("/[^/]+$", "")
      end

      --Split directory into components and uppercase
      local dir_parts = {}
      for part in string.gmatch(rel_path, "[^/\\]+") do
        table.insert(dir_parts, string.upper(part))
      end

      local guard = table.concat(dir_parts, "_") .. "_" .. string.upper(file_stem) .. "_H_"

      return {
        "",
        "#endif  // " .. guard,
      }
    end),
  }),
}
