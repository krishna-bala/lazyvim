return {
  "sindrets/diffview.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- Ensure gitsigns loads when diffview opens
  },
  config = function(_, opts)
    require("diffview").setup(opts)

    -- :DiffviewMergeBase <branch> — diff from merge-base to working tree
    -- Defaults to origin/master if no branch is given.
    vim.api.nvim_create_user_command("DiffviewMergeBase", function(cmd)
      local ref = cmd.args ~= "" and cmd.args or "origin/master"
      local base = vim.trim(vim.fn.system({ "git", "merge-base", ref, "HEAD" }))
      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to compute merge-base for " .. ref, vim.log.levels.ERROR)
        return
      end
      vim.cmd("DiffviewOpen " .. base)
    end, {
      nargs = "?",
      complete = function()
        -- Complete with local and remote branch names
        local branches = vim.fn.systemlist("git branch -a --format='%(refname:short)'")
        return branches
      end,
    })
  end,
  opts = {
    keymaps = {
      view = {
        -- Override treesitter-textobjects ]c/[c class navigation with native diff navigation
        { "n", "]c", function() vim.cmd("normal! ]c") end, { desc = "Next change" } },
        { "n", "[c", function() vim.cmd("normal! [c") end, { desc = "Previous change" } },
      },
    },
    view = {
      merge_tool = {
        -- Config for conflicted files in diff views during a merge or rebase.
        layout = "diff3_mixed",
        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
      },
    },
  },
}
