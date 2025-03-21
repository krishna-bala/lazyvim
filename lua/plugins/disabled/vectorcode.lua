return {
  "Davidyz/VectorCode",
  version = "*",                        -- optional, depending on whether you're on nightly or release
  build = "uv tool upgrade vectorcode", -- optional but recommended if you set `version = "*"`
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
}
