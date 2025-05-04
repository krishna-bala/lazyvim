-- lua/plugins/ai/extensions/codecompanion/noice-notification.lua
local Format  = require("noice.text.format")
local Message = require("noice.message")
local Manager = require("noice.message.manager")
local Router  = require("noice.message.router")

local M       = { handles = {} }
M.config      = { throttle = 200 }

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function make_progress(id, adapter)
  adapter           = adapter or {}
  local client      = adapter.formatted_name or "unknown"
  local model       = adapter.model or ""
  local msg         = Message("lsp", "progress")
  msg.opts.progress = {
    client_id = id,
    client    = client .. (model ~= "" and " (" .. model .. ")" or ""),
    id        = id,
    message   = "Awaiting Response…",
  }
  return msg
end

local function start_timer(id, msg)
  local t = vim.uv.new_timer()
  t:start(0, M.config.throttle, vim.schedule_wrap(function()
    if not M.handles[id] then
      t:stop(); t:close()
      return
    end
    Manager.add(Format.format(msg, "lsp_progress"))
    Router.update()
  end))
  M.handles[id].timer = t
end

local function finish(id, status)
  local entry = M.handles[id]
  if not entry then return end
  entry.timer:stop(); entry.timer:close()
  local msg = entry.msg
  msg.opts.progress.message = ({
    success   = "Completed",
    error     = " Error",
    cancelled = "󰜺 Cancelled",
  })[status] or "󰜺 Cancelled"
  Manager.add(Format.format(msg, "lsp_progress"))
  Router.update()
  Manager.remove(msg)
  M.handles[id] = nil
end

function M.init()
  local group = vim.api.nvim_create_augroup("NoiceCompanionRequests", {})
  vim.api.nvim_create_autocmd("User", {
    pattern  = "CodeCompanionRequestStarted",
    group    = group,
    callback = function(evt)
      local id, adapter = evt.data.id, evt.data.adapter
      if not id or not adapter then return end
      local msg = make_progress(id, adapter)
      M.handles[id] = { msg = msg }
      start_timer(id, msg)
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern  = "CodeCompanionRequestFinished",
    group    = group,
    callback = function(evt)
      finish(evt.data.id, evt.data.status)
    end,
  })
end

return M

-- SOME ERRORS I GET WHEN USING THIS PLUGIN
--    Error  12:31:35 PM msg_show.lua_error Error executing vim.schedule lua callback: ...ugins/ai/extensions/codecompanion/noice-notification.lua:32: handle 0x608ba50714e0 is already closing
-- stack traceback:
-- 	[C]: in function 'close'
-- 	...ugins/ai/extensions/codecompanion/noice-notification.lua:32: in function ''
-- 	vim/_editor.lua: in function <vim/_editor.lua:0>
--    Error  12:32:02 PM msg_show.lua_error Error executing vim.schedule lua callback: ...ugins/ai/extensions/codecompanion/noice-notification.lua:32: handle 0x608ba508ab70 is already closing
-- stack traceback:
-- 	[C]: in function 'close'
-- 	...ugins/ai/extensions/codecompanion/noice-notification.lua:32: in function ''
-- 	vim/_editor.lua: in function <vim/_editor.lua:0>
--    Error  12:33:21 PM msg_show.emsg E21: Cannot make changes, 'modifiable' is off
--    Error  12:34:18 PM msg_show.lua_error Error executing vim.schedule lua callback: ...ugins/ai/extensions/codecompanion/noice-notification.lua:32: handle 0x608ba545dc20 is already closing
-- stack traceback:
-- 	[C]: in function 'close'
-- 	...ugins/ai/extensions/codecompanion/noice-notification.lua:32: in function ''
-- 	vim/_editor.lua: in function <vim/_editor.lua:0>
