return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  build = "make tiktoken",
  opts = function(_, opts)
    opts.model = "claude-3.5-sonnet"
    opts.prompts = opts.prompts or {}
    opts.prompts = require("prompts.copilot-prompts")

    opts.contexts = opts.contexts or {}
    opts.contexts.git_files = {
      input = function(callback)
        vim.ui.select({ "unstaged", "staged" }, {
          prompt = "> Select setting",
        }, callback)
      end,
      resolve = function(input)
        input = input or "unstaged"
        local out = ""

        if input == "staged" then
          -- Get staged files
          local handle = io.popen("git diff --staged --name-only")
          local files = ""
          if handle then
            files = handle:read("*a") or ""
            handle:close()
          end

          -- Read contents of each staged file
          for filename in files:gmatch("[^\n]+") do
            local content_handle = io.popen(string.format("git show :%s", filename))
            local diff_handle = io.popen(string.format("git diff --staged -- :%s", filename))
            if content_handle and diff_handle then
              local content = content_handle:read("*a")
              local diff = diff_handle:read("*a")
              out = out .. diff .. string.format("\n--- %s ---\n%s\n", filename, content)
              content_handle:close()
            end
          end
        else
          -- Get unstaged files
          local handle = io.popen("git ls-files --others --modified --exclude-standard")
          local files = ""
          if handle then
            files = handle:read("*a") or ""
            handle:close()
          end

          -- Read current contents of each unstaged file
          for filename in files:gmatch("[^\n]+") do
            local file = io.open(filename, "r")
            local diff_handle = io.popen(string.format("git diff -- :%s", filename))
            if file and diff_handle then
              local content = file:read("*a")
              local diff = diff_handle:read("*a")
              out = out .. diff .. string.format("\n--- %s ---\n%s\n", filename, content)
              file:close()
            end
          end
        end

        return {
          {
            content = out,
            filename = input .. "_git_files",
            filetype = "diff",
          },
        }
      end,
      prompt = "Choose a git file context",
    }
    opts.contexts.file = {
      input = function(callback)
        local fzf = require("fzf-lua")
        local fzf_path = require("fzf-lua.path")
        fzf.files({
          complete = function(selected, _opts)
            local file = fzf_path.entry_to_file(selected[1], _opts, _opts._uri)
            if file.path == "none" then
              return
            end
            vim.defer_fn(function()
              callback(file.path)
            end, 100)
          end,
        })
      end,
    }
    opts.mappings = opts.mappings or {}
    opts.mappings.reset = opts.mappings.reset or {}
    opts.mappings.reset.normal = "<C-x>"
    opts.mappings.reset.insert = "<C-x>"
  end,
}
