local docs_prompt = require("plugins.ai.prompts.docs")
local commit_prompt = require("plugins.ai.prompts.commit")
local sys_review_prompt = require("plugins.ai.prompts.sys_review_prompt")
local sys_base_prompt = require("plugins.ai.prompts.sys_base_prompt")
local review_prompt = require("plugins.ai.prompts.review")
local nemawashi_prompt = require("plugins.ai.prompts.nemawashi")

local prompt_library = {
  Docs = {
    strategy = "chat",
    description = "Generate documentation for a function",
    prompts = {
      {
        role = "system",
        content = sys_base_prompt,
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
        content = sys_base_prompt,
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
        content = sys_review_prompt,
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
        content = sys_base_prompt,
      },
      {
        role = "user",
        content = nemawashi_prompt,
      }
    },
  },
}

return prompt_library
