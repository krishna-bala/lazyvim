return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    vim.g.copilot_cmp_enabled = true

    -- Function to toggle Copilot source
    local function toggle_copilot()
      local sources = opts.sources or {}
      if #sources == 0 then
        return sources
      end

      if vim.g.copilot_cmp_enabled then
        sources = vim.tbl_filter(function(source)
          return source.name ~= "copilot"
        end, sources)
      else
        table.insert(sources, { name = "copilot" })
      end
      vim.g.copilot_cmp_enabled = not vim.g.copilot_cmp_enabled
      vim.notify("copilot nvim-cmp: " .. (vim.g.copilot_cmp_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
      return sources
    end

    opts.mapping = vim.tbl_extend(
      "force",
      opts.mapping,
      cmp.mapping.preset.insert({

        ----------------------
        -- Copilot mappings --
        ----------------------
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

        ----------------------
        -- LuaSnip mappings --
        ----------------------
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    )
    return opts
  end,
}
