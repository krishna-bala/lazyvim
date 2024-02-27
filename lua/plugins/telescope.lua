return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    "rcarriga/nvim-notify",
  },
  opts = function(_, opts)
    -- necessary to use :Telescope notify
    require("telescope").load_extension("notify")

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local lga_actions = require("telescope-live-grep-args.actions")

    -- live-grep-args extension options
    opts.extensions = {
      live_grep_args = {
        auto_quoting = false,
        mappings = {
          n = {
            ["<leader>p"] = lga_actions.quote_prompt(),
            ["<leader>i"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<leader>t"] = lga_actions.quote_prompt({ postfix = " -t" }),
            ["<leader>b"] = lga_actions.quote_prompt({ postfix = " -tcpp --iglob *" }),
          },
        },
      },
    }
    opts.defaults = vim.tbl_extend("force", opts.defaults, {
      layout_config = {
        horizontal = { width = 0.9 },
        scroll_speed = 3,
      },
    })
    -- delete buffers
    opts.pickers = {
      buffers = {
        mappings = {
          n = {
            ["<leader>bd"] = actions.delete_buffer + actions.move_to_bottom,
          },
        },
      },
    }

    local telescope_custom_actions = {}

    function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local selected_entry = action_state.get_selected_entry()
      local num_selections = #picker:get_multi_selection()
      if not num_selections or num_selections <= 1 then
        actions.select_default(prompt_bufnr)
        do
          return
        end
      end
      actions.send_selected_to_qflist(prompt_bufnr)
      vim.cmd("cfdo " .. open_cmd)
    end

    function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
      telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
    end

    function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
      telescope_custom_actions._multiopen(prompt_bufnr, "split")
    end

    function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
      telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
    end

    function telescope_custom_actions.multi_selection_open(prompt_bufnr)
      telescope_custom_actions._multiopen(prompt_bufnr, "edit")
    end

    opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, {
      ["<CR>"] = telescope_custom_actions.multi_selection_open,
      ["<C-v>"] = telescope_custom_actions.multi_selection_open_vsplit,
      ["<C-s>"] = telescope_custom_actions.multi_selection_open_split,
      ["<C-t>"] = telescope_custom_actions.multi_selection_open_tab,
      ["<C-d>"] = false,
      ["<C-u>"] = false,
      ["<C-j>"] = actions.preview_scrolling_down,
      ["<C-k>"] = actions.preview_scrolling_up,
    })

    opts.defaults.mappings.n = vim.tbl_extend("force", opts.defaults.mappings.n, {
      ["<CR>"] = telescope_custom_actions.multi_selection_open,
      ["<C-v>"] = telescope_custom_actions.multi_selection_open_vsplit,
      ["<C-s>"] = telescope_custom_actions.multi_selection_open_split,
      ["<C-t>"] = telescope_custom_actions.multi_selection_open_tab,
      ["<C-d>"] = false,
      ["<C-u>"] = false,
      ["<C-j>"] = actions.preview_scrolling_down,
      ["<C-k>"] = actions.preview_scrolling_up,
    })
  end,
  keys = {
    { "<leader>/", false },
    { "<leader>sw", mode = { "n", "v" }, false },
    { "<leader>gs", false },
    -- {
    --   "<leader>/",
    --   function()
    --     telescope.extensions.live_grep_args.live_grep_args()
    --   end,
    --   desc = "Live Grep (Args)",
    -- },
    {
      "<leader>snm",
      "<cmd>Telescope notify<cr>",
      desc = "Show notify messages",
    },
    {
      "q/",
      "<cmd>Telescope search_history<cr>",
      desc = "Show search history",
    },
    {
      "q:",
      "<cmd>Telescope command_history<cr>",
      desc = "Show command history",
    },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols({ symbol_width = 60 })
      end,
    },
  },
}
