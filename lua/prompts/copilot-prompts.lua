local docs_prompt = require("prompts.docs")
local commit_prompt = require("prompts.commit")
local sys_review_prompt = require("prompts.sys_review_prompt")
local review_prompt = require("prompts.review")
local deep_understanding_prompt = require("prompts.deep_understanding")
local nemawashi_prompt = require("prompts.nemawashi")
local nemawashi_refined_prompt = require("prompts.nemawashi")

local prompts = {
  Docs = {
    prompt = docs_prompt,
  },
  Commit = {
    prompt = commit_prompt,
  },
  Review = {
    prompt = review_prompt,
    system_prompt = sys_review_prompt,
  },
  DeepUnderstanding = {
    prompt = deep_understanding_prompt,
  },
  Nemawashi = {
    prompt = nemawashi_prompt,
  },
  NemawashiRefined = {
    prompt = nemawashi_refined_prompt,
  },
}

return prompts
