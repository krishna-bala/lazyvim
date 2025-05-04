Context summary for a new agent:

• Goal: Add a `/save` slash‑command in CodeCompanion (Neovim plugin) to persist the last assistant message.

• Key files/buffers:
  - buf 4: save_history.lua (`…/plugins/ai/extensions/codecompanion/save_history.lua`)  
    • Implements `M.setup(opts)` (registers `:CodeCompanionSave`)  
    • Exposes `M.exports.save()` to write the last assistant message to disk  
  - buf 5: codecompanion.lua (`…/plugins/codecompanion.lua`)  
    • Defines `strategies.chat.slash_commands.save` → calls `save_history.exports.save()`  
    • `extensions.save_history.callback` wrongly set to `require("…save_history")` (setup never runs)  
  - buf 3: context.md (`…/plugins/ai/extensions/codecompanion/context.md`)  
    • Recommends changing the callback to `.setup` so filename is stored and user command is created on startup  
  - buf 6: compact.lua (`…/plugins/ai/prompts/compact.lua`)  
    • “Compact Mode” prompt template (unrelated to save feature)

• Recommended one‑line change in `codecompanion.lua`:
```diff
 extensions = {
   save_history = {
     enabled  = true,
-    callback = require("plugins.ai.extensions.codecompanion.save_history"),
+    callback = require("plugins.ai.extensions.codecompanion.save_history").setup,
     opts     = { filename = … },
   },
 },
```

Next step: apply this change in `codecompanion.lua` and test via `:CodeCompanionSave` or typing `/save`.
