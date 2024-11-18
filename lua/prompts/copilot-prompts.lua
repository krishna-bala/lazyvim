local select = require("CopilotChat.select")
local docs_prompt = require("prompts.docs")
local commit_prompt = require("prompts.commit")
local commit_staged_prompt = require("prompts.commit-staged")
local prompts = {
  Docs = {
    prompt = docs_prompt,
  },
  Commit = {
    prompt = commit_prompt,
    -- selection = select.gitdiff,
  },
  CommitStaged = {
    prompt = commit_staged_prompt,
    -- selection = function(source)
    --   return select.gitdiff(source, true)
    -- end,
  },
}

return prompts
