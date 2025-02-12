return {
  "CopilotC-Nvim/CopilotChat.nvim",
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
        require("snacks.picker").pick({
          finder = "files",
          format = "file",
          confirm = function(picker, item)
            picker:close()
            if item then
              callback(vim.fn.fnamemodify(item.file, ":p:."))
            end
          end,
          main = { current = true },
        })
      end,
    }
    opts.contexts.buffer = {
      input = function(callback)
        require("snacks.picker").pick({
          finder = "buffers",
          format = "buffer",
          confirm = function(picker, item)
            picker:close()
            if item then
              callback(item.text)
            end
          end,
          main = { current = true },
        })
      end,
    }
    opts.mappings = opts.mappings or {}
    opts.mappings.reset = opts.mappings.reset or {}
    opts.mappings.reset.normal = "<C-x>"
    opts.mappings.reset.insert = "<C-x>"
  end,
  keys = {
    {
      "<leader>ap",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.snacks").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat Prompt Actions",
    },
    {
      "<leader>aa",
      function()
        require("CopilotChat").toggle({ selection = false })
      end,
      desc = "CopilotChat",
      mode = { "n", "v" },
    },
    {
      "<leader>as",
      function()
        require("CopilotChat").toggle()
      end,
      desc = "CopilotChat Selection",
      mode = { "n", "v" },
    },
  },
}
