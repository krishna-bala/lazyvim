local docs_prompt = require("prompts.docs")
local commit_prompt = require("prompts.commit")
local prompts = {
  Docs = {
    prompt = docs_prompt,
  },
  Commit = {
    prompt = commit_prompt,
  },
}

return prompts
