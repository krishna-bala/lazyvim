local docs_prompt = require("plugins.ai.prompts.docs")
local commit_prompt = require("plugins.ai.prompts.commit")
local system_prompt = require("plugins.ai.prompts.system_prompt")
local review_prompt = require("plugins.ai.prompts.review")
local nemawashi_prompt = require("plugins.ai.prompts.nemawashi")

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
            result = "```diff\n"
            result = result .. handle:read("*a")
            result = result .. "\n```"
            handle:close()
          else
            result = "ERROR: Unable to generate a git diff of staged files."
          end
          return commit_prompt:gsub("{{DIFF}}", result)
        end,
      }
    },
    opts = {
      is_slash_cmd = true,
      short_name = "commit",
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
    opts = {
      is_slash_cmd = true,
      short_name = "review",
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
}

return prompt_library
