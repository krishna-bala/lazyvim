local docs_prompt = require("plugins.ai.prompts.docs")
local commit_prompt = require("plugins.ai.prompts.commit")
local system_prompt = require("plugins.ai.prompts.system_prompt")
local review_prompt = require("plugins.ai.prompts.review")
local nemawashi_prompt = require("plugins.ai.prompts.nemawashi")
local compact_prompt = require("plugins.ai.prompts.compact")

local prompt_library = {
  Docs = {
    strategy = "chat",
    description = "Generate documentation for a function",
    prompts = {
      {
        role = "system",
        content = system_prompt,
      },
      {
        role = "user",
        content = docs_prompt,
      }
    },
  },
  Commit = {
    strategy = "chat",
    description = "Generate a commit message",
    prompts = {
      {
        role = "system",
        content = system_prompt,
      },
      {
        role = "user",
        content = function()
          local handle = io.popen("git diff --staged")
          local result
          if handle ~= nil then
            result = handle:read("*a")
            handle:close()
          else
            result = "ERROR: Unable to generate a git diff of staged files."
          end
          return commit_prompt ..
              "\nProvide a commit for the following staged changes:\n\n" ..
              "```diff\n" .. result .. "```"
        end,
      }
    },
  },
  Review = {
    strategy = "chat",
    description = "Review the provided code",
    prompts = {
      {
        role = "system",
        content = system_prompt,
      },
      {
        role = "user",
        content = review_prompt,
      }
    },
  },
  Nemawashi = {
    strategy = "chat",
    description = "Facilitate consensus-building (Nemawashi)",
    prompts = {
      {
        role = "system",
        content = system_prompt,
      },
      {
        role = "user",
        content = nemawashi_prompt,
      }
    },
  },
  Compact = {
    strategy = "chat",
    description = "Compact the provided code",
    prompts = {
      {
        role = "system",
        content = system_prompt,
      },
      {
        role = "user",
        content = function()
          local last_chat_messages = require("codecompanion").last_chat().messages
          local formatted_messages = ""
          if last_chat_messages then
            for _, message in ipairs(last_chat_messages) do
              local role = message.role or ""
              local content = message.content or ""
              formatted_messages = formatted_messages
                  .. string.format(
                    '<message role="%s">\n%s\n</message>\n',
                    role,
                    content
                  )
            end
          end
          -- Replace placeholder and return
          return compact_prompt:gsub("{{MESSAGE_HISTORY}}", formatted_messages)
        end,
      },
    },
    opts = {
      is_slash_cmd = true,
      short_name = "compact",
      -- is_default = true,
      -- index = 9,
    },
  },
}

return prompt_library
