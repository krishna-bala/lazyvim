local system_prompt = require("plugins.ai.prompts.system_prompt")
local compact_prompt = require("plugins.ai.prompts.compact")

return {
  strategy = "chat",
  description = "COMPACT",
  prompts = {
    {
      role = "system",
      content = system_prompt
    },
    {
      role = "user",
      content = function()
        local last_chat_messages = require("codecompanion").last_chat().messages
        -- Format each message from the last chat
        local formatted_messages = ""
        if last_chat_messages then
          for _, message in ipairs(last_chat_messages) do
            local role = message.role
            local content = message.content or ""
            -- Convert system messages to a more readable format
            if role == "system" then
              role = "System"
            elseif role == "user" then
              role = "User"
            elseif role == "llm" or role == "assistant" then
              role = "Assistant"
            end
            formatted_messages = formatted_messages .. "### " .. role .. "\n\n" .. content .. "\n\n"
          end
        end
        compact_prompt:gsub("{{MESSAGE_HISTORY}}", formatted_messages)
        return compact_prompt
      end,
    },
  },
  opts = {
    is_slash_cmd = true,
    short_name = "compact",
    -- is_default = true,
    index = 9,
  }
}
