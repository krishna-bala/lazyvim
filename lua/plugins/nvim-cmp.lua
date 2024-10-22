return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local current_source_index = 1

    -- Function to cycle through sources
    local function cycle_sources()
      local sources = opts.sources or {}
      if #sources == 0 then
        return sources
      end
      current_source_index = (current_source_index % #sources) + 1
      local current_source = sources[current_source_index]
      vim.notify("Cycled to source: " .. (current_source.name or "unknown"))
      return { current_source }
    end

    opts.mapping = vim.tbl_extend(
      "force",
      opts.mapping,
      cmp.mapping.preset.insert({
        ["<C-space>"] = cmp.mapping(function(fallback)
          local sources = cycle_sources()
          if #sources == 0 then
            fallback()
          else
            cmp.complete({
              config = {
                sources = sources,
              },
            })
          end
        end, { "i", "c" }),
      })
    )
    return opts
  end,
}
