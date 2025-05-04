return [[
You are now in Compact Mode.

Compact Mode Instructions:
You will receive a message history from a conversation with an AI agent. Your task is to extract the context from this conversation and provide a technical summary that will enable a new LLM agent with no context to continue assisting the user.

Follow these steps for Compact Mode:
1. Carefully review the provided message history.
2. Identify key information, requirements, and objectives from the conversation.
3. Organize the extracted information into relevant categories.
4. Create a concise yet comprehensive summary of the conversation context.

Format your summary as a markdown file with the following sections (if relevant):
- Summary
- References (files, URLs, buffers, codecompanion tools used, etc.)
- Objective
- Requirements
- Acceptance Criteria

Include additional sections as needed to detail various aspects of the conversation, such as tools used and their outputs, or files referenced and their contents.

If the context is too long, condense it based on what was most relevant to the conversation.

Example Compact Mode output structure:

```markdown
### Summary
[Brief overview of the conversation and its main points]

### References
- [List of relevant files, URLs, buffers, or tools mentioned]

### Objective
[Clear statement of the user's main goal or problem]

### Requirements
- [List of specific requirements identified in the conversation]

### Acceptance Criteria
- [List of criteria that must be met for the task to be considered complete]

### [Additional Section Name]
[Relevant details about tools, files, or other important aspects of the conversation]
```

<message_history>
{{MESSAGE_HISTORY}}
</message_history>
]]
-- return compact_prompt
--
-- return {
--   strategy = "chat",
--   description = "COMPACT",
--   prompts = {
--     {
--       role = "system",
--       content = system_prompt
--     },
--     {
--       role = "user",
--       content = function()
--         local last_chat_messages = require("codecompanion").last_chat().messages
--         -- Format each message from the last chat
--         local formatted_messages = ""
--         if last_chat_messages then
--           for _, message in ipairs(last_chat_messages) do
--             local role = message.role
--             local content = message.content or ""
--             -- Convert system messages to a more readable format
--             if role == "system" then
--               role = "System"
--             elseif role == "user" then
--               role = "User"
--             elseif role == "llm" or role == "assistant" then
--               role = "Assistant"
--             end
--             formatted_messages = formatted_messages .. "### " .. role .. "\n\n" .. content .. "\n\n"
--           end
--         end
--         compact_prompt:gsub("{{MESSAGE_HISTORY}}", formatted_messages)
--         return compact_prompt
--       end,
--     },
--   },
--   opts = {
--     is_slash_cmd = true,
--     short_name = "compact",
--     -- is_default = true,
--     index = 9,
--   }
-- }
