-- lua/plugins/vimtex.lua
return {
  "lervag/vimtex",
  opts = function(_, opts)
    -- Original opts from LazyVim tex extra are preserved
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0
    vim.opt.conceallevel = 1
    vim.g.tex_conceal = "abdmg"

    -- Enable synctex
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-synctex=1",
        "-interaction=nonstopmode",
        "-xelatex",
      },
    }

    -- Properly configure forward sync (nvim -> zathura)
    vim.g.vimtex_view_general_viewer = "zathura"
    vim.g.vimtex_view_zathura_options = "-x \"nvim --headless -c 'VimtexInverseSearch %{line} %{input}'\""

    -- Settings for forward search
    vim.g.vimtex_view_forward_search_on_start = true

    return opts
  end,
}
