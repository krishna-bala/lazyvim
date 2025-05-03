-- lua/plugins/ai/extensions/codecompanion/noice-notification.lua

local Format = require("noice.text.format")
local Message = require("noice.message")
local Manager = require("noice.message.manager")
local Router = require("noice.message.router")

local ThrottleTime = 200
local M = {}

-- Use weak-valued table so handles auto‑clear if dropped elsewhere
M.handles = setmetatable({}, { __mode = "v" })

local function make_progress(request)
  local id, adapter = request.data.id, request.data.adapter
  local msg = Message("lsp", "progress")
  msg.opts.progress = {
    client_id = id, -- keep as a number
    client    = (adapter.formatted_name
      .. (adapter.model and adapter.model ~= "" and " (" .. adapter.model .. ")" or "")),
    id        = id,
    message   = "Awaiting Response: ",
  }
  return msg
end

local function schedule_update(msg)
  if M.handles[msg.opts.progress.id] then
    -- update the existing progress message
    Manager.add(Format.format(msg, "lsp_progress"))
    Router.update()
    vim.defer_fn(function() schedule_update(msg) end, ThrottleTime)
  end
end

local function finish(msg, status)
  msg.opts.progress.message = ({
    success   = "Completed",
    error     = " Error",
    cancelled = "󰜺 Cancelled",
  })[status] or "󰜺 Cancelled"
  Manager.add(Format.format(msg, "lsp_progress"))
  Router.update()
  Manager.remove(msg)
end

function M.init()
  local group = vim.api.nvim_create_augroup("NoiceCompanionRequests", {})

  vim.api.nvim_create_autocmd("User", {
    pattern  = "CodeCompanionRequestStarted",
    group    = group,
    callback = function(evt)
      local msg = make_progress(evt)
      M.handles[evt.data.id] = msg
      schedule_update(msg)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern  = "CodeCompanionRequestFinished",
    group    = group,
    callback = function(evt)
      local id = evt.data.id
      local msg = M.handles[id]
      M.handles[id] = nil
      if msg then
        finish(msg, evt.data.status)
      end
    end,
  })
end

return M
