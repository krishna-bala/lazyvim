return [[> #git:staged
Write commit message for the change with conventional commit format. 
Make sure the title has maximum 72 characters and message is wrapped at 72 characters. 
Wrap the whole message in code block with language gitcommit. Here is a template:

<type>[(<optional scope>)]: <description>

[optional body]

[optional footer(s)]

# Types
# * fix: a commit of the type fix patches a bug in your codebase (semver: PATCH)
# * feat: a commit of the type feat introduces a new feature to the codebase (semver: MINOR).
#   BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (semver: MAJOR).

# Additional types:
# * build: Changes that affect the build system or external dependencies
# * ci: Changes to our CI configuration files and scripts
# * docs: Documentation only changes
# * perf: A code change that improves performance
# * refactor: A code change that neither fixes a bug nor adds a feature
# * style: Changes that do not affect the meaning of the code (white-space, formatting, etc)
# * test: Adding missing tests or correcting existing tests]]
