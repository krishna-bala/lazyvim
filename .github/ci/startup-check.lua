-- CI startup check. Loaded with `nvim --headless --cmd "luafile <this file>"`,
-- so it runs before init.lua. It records every error raised while the config
-- starts, makes lazy.nvim load its VeryLazy plugins, and exits non-zero if
-- anything went wrong.

local errors = {}

-- Headless Neovim stops printing messages once startup is over, so errors are
-- caught at the source instead. LazyVim, snacks and noice each replace
-- vim.notify during startup, so keep re-wrapping whatever is current.
local function wrap_notify()
  local current = vim.notify
  if rawequal(current, _G.__ci_notify) then
    return
  end
  local function wrapped(msg, level, opts)
    if level == vim.log.levels.ERROR or level == "error" then
      table.insert(errors, tostring(msg))
    end
    return current(msg, level, opts)
  end
  _G.__ci_notify = wrapped
  vim.notify = wrapped
end
wrap_notify()
local timer = assert(vim.uv.new_timer())
timer:start(0, 10, vim.schedule_wrap(wrap_notify))

local function finish()
  timer:stop()

  if vim.v.errmsg ~= "" then
    table.insert(errors, "v:errmsg: " .. vim.v.errmsg)
  end
  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  for line in messages:gmatch("[^\n]+") do
    if line:match("^E%d+:") or line:match("^Error") then
      table.insert(errors, line)
    end
  end
  if not vim.g.did_very_lazy then
    table.insert(errors, "lazy.nvim never fired VeryLazy, so most plugins were not loaded")
  end

  local stats = require("lazy").stats()
  io.stdout:write(("Loaded %d of %d plugins\n"):format(stats.loaded, stats.count))

  if #errors == 0 then
    io.stdout:write("No startup errors\n")
    vim.cmd("qall!")
  else
    io.stderr:write(("%d startup error(s):\n"):format(#errors))
    for _, err in ipairs(errors) do
      io.stderr:write("  " .. err:gsub("\n", "\n  ") .. "\n")
    end
    vim.cmd("cquit 1")
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    -- lazy.nvim fires VeryLazy on UIEnter, which never happens without a UI.
    vim.api.nvim_exec_autocmds("UIEnter", { modeline = false })
    -- Give VeryLazy plugins and their deferred setup time to run.
    vim.defer_fn(finish, 5000)
  end,
})
