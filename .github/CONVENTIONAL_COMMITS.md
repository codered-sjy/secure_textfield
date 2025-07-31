# Conventional Commits Guide

This project uses [Conventional Commits](https://www.conventionalcommits.org/) for automated changelog generation and version bumping.

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

- **feat**: A new feature (triggers minor version bump)
- **fix**: A bug fix (triggers patch version bump)
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files

## Breaking Changes

Add `BREAKING CHANGE:` in the footer or `!` after the type to indicate a breaking change (triggers major version bump):

```
feat!: remove deprecated API
```

or

```
feat: add new authentication method

BREAKING CHANGE: old auth method is no longer supported
```

## Examples

```
feat: add password strength validation
fix: resolve memory leak in text controller
docs: update README with installation instructions
test: add unit tests for secure input validation
chore: update dependencies
```

## Release Process

1. Commit changes using conventional commit format
2. Push to main branch
3. Release Please will automatically:
   - Create a release PR with updated version and changelog
   - When PR is merged, create a GitHub release
   - Tag the release appropriately

## Version Bumping

- **patch** (0.1.0 → 0.1.1): bug fixes
- **minor** (0.1.0 → 0.2.0): new features
- **major** (0.1.0 → 1.0.0): breaking changes
