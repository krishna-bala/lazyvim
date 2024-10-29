return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local copilot_enabled = true

    -- Function to toggle Copilot source
    local function toggle_copilot()
      local sources = opts.sources or {}
      if #sources == 0 then
        return sources
      end

      if copilot_enabled then
        sources = vim.tbl_filter(function(source)
          return source.name ~= "copilot"
        end, sources)
        vim.notify("Copilot disabled")
      else
        table.insert(sources, { name = "copilot" })
        vim.notify("Copilot enabled")
      end
      copilot_enabled = not copilot_enabled
      -- cmp.setup(opts) -- Apply the new configuration
      return sources
    end

    opts.mapping = vim.tbl_extend(
      "force",
      opts.mapping,
      cmp.mapping.preset.insert({
        ["<C-l>"] = cmp.mapping(function(fallback)
          local sources = toggle_copilot()
          if #sources == 0 then
            fallback() -- Fallback to default behavior if no sources available
            return
          end
          cmp.complete({
            config = { sources = sources },
          })
        end, { "i", "c" }),
      })
    )
    return opts
  end,
}
