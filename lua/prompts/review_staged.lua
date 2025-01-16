return [[
> /COPILOT_GENERATE
> #git_files:staged
> #git:staged

Your task is to review the provided code, focusing specifically on the diff.
The full files are provided as context.
Focus on providing feedback on readability and maintainability.
Identify any issues related to:

- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:

- A clear description of the problem. Include the original code if possible.
- A concrete suggestion for how to improve or correct the issue.

Format your feedback as follows:

```md
<file_name.filetype>
```

<issue_description>

```filetype
<fix (if applicable)>
```

If you find multiple issues on the same line, list each issue separately within the same feedback statement, using a semicolon to separate them.

Example feedback:

The variable name 'x' is unclear. Comment next to variable declaration is unnecessary.

```ft
<fix>
```

[fileA.ft](fileA.ft)

Expression is overly complex. Break down the expression into simpler components.

[fileA.ft](fileA.ft)
```

Using camel case here is unconventional for lua. Use snake case instead.

[fileA.ft](fileA.ft)

Excessive nesting makes the code hard to follow. Consider refactoring to reduce nesting levels.

```ft
<fix>
```

[fileB.ft](fileB.ft)

The variable name 'y' is unclear.
]]
