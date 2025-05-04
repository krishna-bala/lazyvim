# Strategy Plan

## Objective

- Draft and implement a strategy for AI-assisted chat summarization and history saving within CodeCompanion.

## Requirements

- Define clear objectives and scope for chat summary feature.
- Specify where and how summaries are saved.
- Ensure file I/O is handled by Neovim, not the LLM prompt.
- Provide user commands and/or autocmd integration for saving summaries.
- Maintain an updatable plan document alongside implementation.

## Acceptance Criteria

- [ ] A strategy document exists in the repo with defined sections.
- [ ] The document can be updated as features evolve.
- [ ] Saving of summaries only writes LLM output message, not full history.
- [ ] User command `:CCSaveSummary` writes summary to configured path.
- [ ] Autocmd triggers save after Compact prompt completes.

## Milestones

| Milestone                                    | Description                                                    | Status      |
|----------------------------------------------|----------------------------------------------------------------|-------------|
| 1. Create strategy plan template             | Add initial `strategy_plan.md` file with template sections.    | Complete    |
| 2. Implement save_last_summary function      | Write Lua function to extract last assistant message.          | In Progress |
| 3. Register `:CCSaveSummary` command         | Expose command for manual invocation.                          | Pending     |
| 4. Add autocmd for auto-save                 | Trigger auto-save on `CodeCompanionRequestFinished` event.     | Pending     |
| 5. Remove file-writing from LLM prompt       | Clean Compact prompt to no longer include I/O instructions.    | Pending     |

## Step-by-Step Plan

| Step | Action                                                               | Owner     | Status      |
|------|----------------------------------------------------------------------|-----------|-------------|
| 1    | Create or update `strategy_plan.md` with template and initial data. | Developer | Complete    |
| 2    | Write `save_last_summary()` in `save-history.lua`.                  | Developer | In Progress |
| 3    | Add `vim.api.nvim_create_user_command("CCSaveSummary", ...)`.      | Developer | Pending     |
| 4    | Configure autocmd group `CCAutoSummary` in `save-history.lua`.       | Developer | Pending     |
| 5    | Update `compact.lua` to remove file save instructions.               | Developer | Pending     |
| 6    | Test manual and auto-saving workflows end-to-end.                    | QA/Dev    | Pending     |
| 7    | Review and iterate based on user feedback and edge cases.            | Team      | Pending     |

*Last updated: YYYY-MM-DD*
