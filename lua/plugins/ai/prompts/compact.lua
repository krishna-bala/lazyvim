local sys_base_prompt = require("plugins.ai.prompts.sys_base_prompt")
local vim = vim

local compact_base_prompt = [[
@full_stack_dev
You are now in Compact Mode.
A complete history of System messages, User messages, and Assistant (LLM) messages will be provided.
Your job is to extract the context from this conversation and provide a compact summary that will enable a new LLM agent with no context to continue helping the user.
Make sure to include the names of relevant buffers, files, etc. that were used during the conversation.
If the context is too long, you may condense the context based on what was relevant to the conversation.
Provide concise responses.
This will be an iterative process and we will refine this prompt over time.

Here are the messages:

]]

return {
  strategy = "chat",
  description = "COMPACT",
  prompts = {
    {
      role = "system",
      content = sys_base_prompt
    },
    {
      role = "user",
      content = function()
        local last_chat_messages = require("codecompanion").last_chat().messages
        -- Format each message from the last chat
        local formatted_messages = ""
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
          formatted_messages = formatted_messages .. "**" .. role .. "**: " .. content .. "\n\n"
        end
        return compact_base_prompt .. formatted_messages -- last chat messages go here
      end,
    },
  },
  is_slash_cmd = true,
}
