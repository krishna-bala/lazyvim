-- lua/plugins/vimtex.lua
return {
  {
    "lervag/vimtex",
    opts = function(_, opts)
      -- Original opts from LazyVim tex extra are preserved
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_quickfix_mode = 0
      vim.opt.conceallevel = 1
      vim.g.tex_conceal = 'abdmg'
      return opts
    end,
  }
}
