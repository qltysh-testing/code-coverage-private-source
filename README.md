# Code Coverage Testing Repository

A repository intended to help test coverage features on Qlty quickly.

## Quick Start

```bash
# Create a single PR with test coverage
ruby scripts/create_pull_requests.rb 1

# Create a PR without test coverage
ruby scripts/create_pull_requests.rb --no-coverage 1

# Create multiple PRs at once (useful for merge queue testing)
ruby scripts/create_pull_requests.rb 5
```

## Script Usage

The `scripts/create_pull_requests.rb` script automates PR creation for testing purposes.

### Options

| Option | Description |
|--------|-------------|
| `--no-coverage` | Create PR without spec files (no test coverage) |
| `-h, --help` | Show help message |

### Examples

```bash
# Create 3 PRs with coverage
ruby scripts/create_pull_requests.rb 3

# Create 3 PRs without coverage
ruby scripts/create_pull_requests.rb --no-coverage 3
```

### What the script does

1. Creates a new branch from the current branch
2. Generates a new module in `lib/testN/` with calculator functionality
3. Optionally generates a corresponding spec file in `spec/testN/` (unless `--no-coverage` is passed)
4. Commits the changes and pushes to origin
5. Creates a pull request via GitHub CLI (`gh`)

### Prerequisites

- Ruby installed
- GitHub CLI (`gh`) installed and authenticated
- Git configured with push access to the repository
