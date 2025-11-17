#!/bin/bash
# Pre-Commit Validator Hook
# Validates commit messages and ensures ADO work item references

set -e

# Read hook input
INPUT=$(cat)
COMMIT_MSG=$(echo "$INPUT" | jq -r '.tool_input.command' 2>/dev/null || echo "")

# Extract work item reference pattern
WORK_ITEM_PATTERN="AB#[0-9]+"

# Check if commit message contains work item reference
if ! echo "$COMMIT_MSG" | grep -qE "$WORK_ITEM_PATTERN|#[0-9]+"; then
  # Check if we're on a feature branch with work item in name
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

  if echo "$BRANCH" | grep -qE "feature/AB-[0-9]+|bugfix/AB-[0-9]+"; then
    # Extract work item from branch name
    WORK_ITEM=$(echo "$BRANCH" | grep -oE "AB-[0-9]+" | sed 's/-/#/')

    # Auto-add work item reference
    echo "{
      \"decision\": \"approve\",
      \"reason\": \"Auto-linked work item $WORK_ITEM from branch name\",
      \"updatedInput\": {
        \"command\": \"$COMMIT_MSG\n\n$WORK_ITEM\"
      }
    }"
    exit 0
  fi

  # No work item found
  echo "{
    \"decision\": \"block\",
    \"reason\": \"Commit message must reference a work item (e.g., AB#12345). Current branch: $BRANCH\"
  }" >&2
  exit 2
fi

# Validate commit message format
if [ ${#COMMIT_MSG} -lt 10 ]; then
  echo "{
    \"decision\": \"block\",
    \"reason\": \"Commit message too short. Must be at least 10 characters.\"
  }" >&2
  exit 2
fi

# Check for common issues
if echo "$COMMIT_MSG" | grep -qi "WIP\|TODO\|FIXME\|XXX"; then
  echo "{
    \"decision\": \"ask\",
    \"reason\": \"Commit message contains WIP/TODO/FIXME. Are you sure you want to commit?\"
  }"
  exit 0
fi

# All validations passed
echo "{
  \"decision\": \"approve\",
  \"reason\": \"Commit message validated successfully\"
}"
exit 0
