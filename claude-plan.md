# Migration Plan: CopilotChat to Avante

## Current Analysis

1. **Current Setup**:
   - CopilotChat is currently disabled (`enabled = false`)
   - Avante is already set up to use Claude 3.7 Sonnet 
   - Avante is already configured to use the same prompts library

2. **Key Features to Migrate**:
   - Custom keybindings/commands (currently in `<leader>a` namespace)
   - Context providers (git, file, buffer, vectorspace)
   - Chat management (save/load functionality)

## Migration Strategy

### 1. Keybinding Migration

| CopilotChat | Description | Avante Equivalent |
|-------------|-------------|-------------------|
| `<leader>ap` | Select prompt | (Need to implement) |
| `<leader>aa` | Open chat | `<leader>av` (open Avante) |
| `<leader>as` | Chat with selection | `<leader>as` (select + open) |
| `<leader>aw` | Save chat | (Need to implement) |
| `<leader>al` | Load chat | (Need to implement) |

### 2. Context Integration

Avante needs custom configurations for:
- Git context provider (staged/unstaged files)
- File picker integration using snacks
- Buffer selection
- Vector search (if needed)

### 3. Implementation Plan

1. **Update Avante Configuration**:
   - Implement keybindings
   - Configure context providers
   - Adapt save/load functionality

2. **Prompt Management**:
   - Validate prompt formats
   - Ensure compatibility with Avante

3. **Testing**:
   - Verify each functionality
   - Compare output quality

## Implementation Tasks

1. Create keybindings for selecting prompts
2. Implement git files context provider
3. Implement file selection with snacks
4. Implement buffer selection with snacks
5. Add save/load chat functionality
6. Test and refine all functionalities

## Considerations

- Avante and CopilotChat have different APIs and UX flows
- Some features may need adaptation rather than direct mapping
- Prompts may need reformatting for optimal use with Avante
- Consider whether to maintain both plugins during transition