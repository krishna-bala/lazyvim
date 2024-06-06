return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
                                                                             
                                                                           
             ████ ██████           █████      ██                     
            ███████████             █████                             
            █████████ ███████████████████ ███   ███████████   
           █████████  ███    █████████████ █████ ██████████████   
          █████████ ██████████ █████████ █████ █████ ████ █████   
        ███████████ ███    ███ █████████ █████ █████ ████ █████  
       ██████  █████████████████████ ████ █████ █████ ████ ██████ 
                                                                             
    ]]
      opts.config.header = vim.split(logo, "\n")
      -- stylua: ignore start
      opts.config.center = {
        { action = LazyVim.telescope("files"),                    desc = " Find File",       icon = " ", key = "f" },
        { action = "Telescope oldfiles",                          desc = " Recent Files",    icon = " ", key = "r" },
        { action = "FzfLua live_grep_glob",                       desc = " Find Text",       icon = " ", key = "/" },
        { action = "ene",                                         desc = " New File",        icon = " ", key = "n" },
        { action = [[lua LazyVim.telescope.config_files()()]],    desc = " Config",          icon = " ", key = "c" },
        { action = 'lua require("persistence").load()',           desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                  desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                        desc = " Lazy",            icon = "󰒲 ", key = "l" },
      }
      -- stylua: ignore end
    end,
  },
}
