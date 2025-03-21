return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = true,
  ---@param opts CopilotChat.config
  opts = function(_, opts)
    opts.model = "claude-3.7-sonnet"

    opts.prompts = require("prompts.copilot-prompts")

    opts.contexts = opts.contexts or {}
    opts.contexts.git_files = {
      input = function(callback)
        vim.ui.select({ "unstaged", "staged" }, {
          prompt = "> Select setting",
        }, callback)
      end,
      resolve = function(input)
        -- Parse input to determine mode
        local mode = "both" -- default mode
        if input == "staged" then
          mode = "staged"
        elseif input == "unstaged" then
          mode = "unstaged"
        end

        ---@type {content: string, filename: string, filetype: string}[]
        local files_data = {}

        -- Get file content from git index or working tree
        local function get_file_content(path, from_index)
          -- For staged files, get from git index
          if from_index then
            local handle = io.popen("git show :" .. path)
            if not handle then
              return nil
            end
            local content = handle:read("*a") or ""
            handle:close()
            return content
          else
            -- For unstaged files, read directly from disk
            local file = io.open(path, "r")
            if not file then
              return nil
            end
            local content = file:read("*a") or ""
            file:close()
            return content
          end
        end

        -- Get file content from HEAD
        local function get_original_file_content(path)
          local handle = io.popen("git show HEAD:" .. path)
          if not handle then
            return nil
          end
          local content = handle:read("*a") or ""
          handle:close()
          return content
        end

        -- Get diff for a file
        local function get_diff(path, staged)
          local diff_cmd = staged and "git diff --staged -- " .. path or "git diff -- " .. path
          local handle = io.popen(diff_cmd)
          local diff = (handle and handle:read("*a")) or ""
          if handle then
            handle:close()
          end
          return diff
        end

        -- Add file content to output
        local function add_file_content(path, content)
          if not content then
            return
          end
          local filetype = require("CopilotChat.utils").filetype(path)
          table.insert(files_data, {
            content = content,
            filename = path,
            filetype = filetype,
          })
        end

        -- Add file status to output
        local function add_file_status(path, content, is_staged)
          local status_type = is_staged and "(STAGED)" or "(UNSTAGED)"
          local status_filename = path .. " " .. status_type .. " CONTEXT"
          table.insert(files_data, {
            content = content,
            filename = status_filename,
            filetype = "diff",
          })
        end

        -- Process git status output
        local status_handle = io.popen("git status -s -uall")
        if not status_handle then
          return { { content = "Failed to run git status", filename = "error", filetype = "text" } }
        end

        for line in status_handle:read("*a"):gmatch("[^\n]+") do
          local index_status = line:sub(1, 1)
          local worktree_status = line:sub(2, 2)

          -- Skip untracked files
          if index_status == "?" and worktree_status == "?" then
            goto continue
          end

          -- Handle renamed files
          if index_status == "R" then
            local old_path, new_path = line:match("R%s+(.+)%s+%->%s+(.+)")
            if old_path and new_path then
              if mode == "staged" or mode == "both" then
                -- For staged rename, show both what was renamed and the diff
                local content = get_file_content(new_path, true) -- Get from index
                add_file_content(new_path, content)
                local status = "RENAMED: " .. old_path .. " → " .. new_path
                local diff = get_diff(new_path, true)
                if diff ~= "" then
                  status = status .. "\n\n" .. diff
                end
                add_file_status(new_path, status, true)
              end
            end
            goto continue
          end

          -- Handle other changes
          local path = line:match("[^ ]+$")
          if not path then
            goto continue
          end

          -- Handle staged changes
          if (mode == "staged" or mode == "both") and index_status ~= " " then
            if index_status == "A" then
              -- Added file
              local content = get_file_content(path, true)
              add_file_content(path, content)
              add_file_status(path, "NEW FILE", true)
            elseif index_status == "M" then
              -- Modified file
              local content = get_file_content(path, true)
              add_file_content(path, content)
              add_file_status(path, get_diff(path, true), true)
            elseif index_status == "D" then
              -- Deleted file
              local content = get_original_file_content(path)
              add_file_content(path, content)
              add_file_status(path, "DELETED FILE", true)
            end
          end

          -- Handle unstaged changes
          if (mode == "unstaged" or mode == "both") and worktree_status ~= " " then
            if worktree_status == "M" then
              -- Modified file (unstaged)
              local content = get_file_content(path, false)
              add_file_content(path, content)
              add_file_status(path, get_diff(path, false), false)
            elseif worktree_status == "D" then
              -- Deleted file (unstaged)
              local content = index_status == " " and get_original_file_content(path) or get_file_content(path, true)
              add_file_content(path, content)
              add_file_status(path, "DELETED FILE (unstaged)", false)
            end
          end

          ::continue::
        end

        status_handle:close()

        if #files_data == 0 then
          return { { content = "No " .. mode .. " changes found", filename = "message", filetype = "text" } }
        end

        return files_data
      end,
      prompt = "Choose a git file context",
    }

    opts.contexts.file = opts.contexts.file or {}
    opts.contexts.file.input = function(callback)
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
    end

    opts.contexts.buffer = opts.contexts.buffer or {}
    opts.contexts.buffer.input = function(callback)
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
    end

    opts.mappings = opts.mappings or {}
    opts.mappings.reset = opts.mappings.reset or {}
    opts.mappings.reset.normal = "<C-x>"
    opts.mappings.reset.insert = "<C-x>"

    opts.window = opts.window or {}
    opts.window.width = 100
  end,
  keys = {
    {
      "<leader>ap",
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "CopilotChat Prompt Actions",
    },
    {
      "<leader>aa",
      function()
        local temp_buf = vim.api.nvim_create_buf(false, true)
        -- Switch to the temporary buffer
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_win_set_buf(current_win, temp_buf)

        require("CopilotChat").toggle()
        -- Return to original buffer and delete temporary buffer
        vim.api.nvim_win_set_buf(current_win, current_buf)
        vim.api.nvim_buf_delete(temp_buf, { force = true })
      end,
      desc = "CopilotChat - No Selection",
      mode = { "n", "v" },
    },
    {
      "<leader>as",
      function()
        local mode = vim.fn.mode()
        if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
          -- Not in visual mode, select the entire buffer
          vim.cmd("normal! ggVG")
        end
        require("CopilotChat").toggle()
      end,
      desc = "CopilotChat Selection",
      mode = { "n", "v" },
    },
    {
      "<leader>aw",
      function()
        vim.ui.input({ prompt = "Save chat to file (empty for default): " }, function(filename)
          if filename == "" then
            vim.cmd("CopilotChatSave")
          elseif filename then
            vim.cmd("CopilotChatSave " .. filename)
          end
        end)
      end,
      desc = "CopilotChatSave (with prompt)",
      mode = { "n", "v" },
    },
    {
      "<leader>al",
      function()
        -- Use the picker to select a chat file
        require("snacks.picker").pick({
          finder = "files",
          format = "file",
          cwd = vim.fn.expand(require("CopilotChat.config").history_path),
          confirm = function(picker, item)
            picker:close()
            if item then
              -- Extract just the filename without path
              local filename = vim.fn.fnamemodify(item.file, ":t:r")
              print(filename)
              vim.cmd("CopilotChatLoad " .. filename)
            end
          end,
          main = { current = true },
        })
      end,
      desc = "CopilotChatLoad (with picker)",
      mode = { "n", "v" },
    },
  },
}
