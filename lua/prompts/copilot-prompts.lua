local docs_prompt = require("prompts.docs")
local commit_prompt = require("prompts.commit")
local review_prompt = require("prompts.review")
local review_staged_prompt = require("prompts.review_staged")
local prompts = {
  Docs = {
    prompt = docs_prompt,
  },
  Commit = {
    prompt = commit_prompt,
  },
  Review = {
    prompt = review_prompt,
  },
  ReviewStaged = {
    prompt = review_staged_prompt,
  },
}

return prompts
