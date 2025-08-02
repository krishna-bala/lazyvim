return {
  "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
  -- Activate when a file is created/opened
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  -- Activate when a supported filetype is open
  ft = { "go", "javascript", "python", "ruby", "cpp", "lua" },
  init = function()
    if vim.env.GITLAB_TOKEN == nil or vim.env.GITLAB_TOKEN == "" then
      local handle = io.popen("pass show api-keys/gitlab/personal-access-token 2>/dev/null")
      if handle then
        local token = handle:read("*l")
        handle:close()
        if token and token ~= "" then
          vim.env.GITLAB_TOKEN = token
        end
      end
    end
  end,
  opts = {
    statusline = {
      -- Hook into the built-in statusline to indicate the status
      -- of the GitLab Duo Code Suggestions integration
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>ag",
      function()
        -- Toggle GitLab Code Suggestions
        if vim.g.gitlab_code_suggestions_active then
          vim.cmd("GitLabCodeSuggestionsStop")
          vim.g.gitlab_code_suggestions_active = false
          vim.notify("GitLab Code Suggestions stopped", vim.log.levels.INFO)
        else
          vim.cmd("GitLabCodeSuggestionsStart")
          vim.g.gitlab_code_suggestions_active = true
          vim.notify("GitLab Code Suggestions started", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle GitLab Code Suggestions",
    },
  },
}
