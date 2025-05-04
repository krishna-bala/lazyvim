local M = { opts = {} }

local function save(data_dir)
  local msgs = require("codecompanion").last_chat().messages
  if not msgs then
    return vim.notify("No message found.", vim.log.levels.WARN)
  end
  local last = msgs[#msgs]
  if last.role ~= "assistant" and last.role ~= "llm" then
    return vim.notify("Wrong role: " .. last.role, vim.log.levels.WARN)
  end

  -- Prepare output directory
  local dir = vim.fn.fnamemodify(data_dir, ":h")
  vim.fn.mkdir(dir, "p")

  -- Prompt for optional suffix
  vim.ui.input({ prompt = "Enter optional name: " }, function(input)
    -- build filename
    local timestamp = os.date("%Y%m%d_%H%M%S")
    local suffix = ""
    if input and input:match("%S") then
      suffix = "_" .. input:gsub("%W+", "_")
    end
    local fname = timestamp .. suffix .. ".md"
    local fpath = dir .. "/" .. fname

    -- write out
    vim.fn.writefile(vim.split(last.content, "\n"), fpath)
    vim.notify("Saved summary → " .. fpath)
  end)
end

local function load(data_dir)
  -- ensure history dir exists
  if not vim.uv.fs_stat(data_dir) then
    vim.notify("[CodeCompanion] no history directory found: " .. data_dir, vim.log.levels.WARN)
    return
  end

  local files = require("plenary.scandir").scan_dir(data_dir, { depth = 1, search_pattern = "%.md$" })
  if vim.tbl_isempty(files) then
    vim.notify("[CodeCompanion] no history files found", vim.log.levels.INFO)
    return
  end

  vim.ui.select(files, {
    prompt = "[CodeCompanion] Select history file:",
    format_item = function(path) return vim.fn.fnamemodify(path, ":t") end,
  }, function(choice)
    if not choice then return end
    local content = table.concat(vim.fn.readfile(choice), "\n")
    local chat = require("codecompanion").last_chat()
    if not chat then
      vim.notify("[CodeCompanion] no active chat buffer", vim.log.levels.WARN)
      return
    end
    -- add loaded file as a system message (or adjust role as needed)
    chat:add_message({ role = "system", content = content })
  end)
end

function M.setup(opts)
  M.opts = opts
  -- expose via user command
  vim.api.nvim_create_user_command(
    "CodeCompanionSave",
    function() save(opts.data_dir) end,
    { desc = "Save last assistant message to history" }
  )
  vim.api.nvim_create_user_command(
    "CodeCompanionLoad",
    function() load(opts.data_dir) end,
    { desc = "Load a history file into chat" }
  )
end

-- allow programmatic access: require("codecompanion.extensions.save_history").save(path?)
M.exports = {
  save = function(path)
    save(path or M.opts.data_dir)
  end,
  load = function(path)
    load(path or M.opts.data_dir)
  end,
}

return M
