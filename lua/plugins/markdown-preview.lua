return {
  "iamcco/markdown-preview.nvim",
  init = function()
    local css = vim.fn.stdpath("config") .. "/css/"
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_markdown_css = css .. "markdown-tokyonight.css"
    vim.g.mkdp_highlight_css = css .. "highlight-tokyonight.css"
  end,
}
