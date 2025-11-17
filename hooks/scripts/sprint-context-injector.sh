#!/bin/bash
# Sprint Context Injector - SessionStart Hook
# Injects current sprint context and open PRs at session start

set -e

# Read hook input
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd' 2>/dev/null || pwd)

# Function to get current sprint from ADO (placeholder - requires ADO MCP)
get_current_sprint() {
  # This would use ADO MCP to fetch current sprint
  # For now, return a template message
  echo "Sprint 42 (Jan 15 - Jan 26, 2025)"
  echo "Team: Alpha Squad"
  echo "Sprint Goal: Launch SSO and improve dashboard performance"
  echo ""
  echo "Your Active Work Items:"
  echo "- AB#12345: Date Range Filtering (In Progress, 5 pts)"
  echo "- AB#12346: Export to CSV (To Do, 3 pts)"
}

# Function to get open PRs
get_open_prs() {
  cd "$CWD" || exit 1

  # Check if in git repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return
  fi

  # Get current branch
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  echo ""
  echo "Current Branch: $BRANCH"

  # Check if there's a PR for this branch (would use GitHub MCP)
  echo "No open PR for this branch yet"
  echo ""
  echo "Team PRs Needing Review: 3"
  echo "- PR #340: Google SSO Integration (Sarah)"
  echo "- PR #341: Dashboard Performance (John)"
  echo "- PR #342: Bug Fix - Login Timeout (Mary)"
}

# Generate context message
CONTEXT_MSG=$(cat <<EOF
======================================
📊 Session Context
======================================

$(get_current_sprint)

$(get_open_prs)

======================================
Tip: Use /ship-story to implement a story end-to-end
Tip: Use /bug-fix to fix and document a bug
======================================
EOF
)

# Output context to be injected
if [ -n "$CLAUDE_ENV_FILE" ]; then
  # Can inject environment variables
  echo "export CURRENT_SPRINT='Sprint 42'" >> "$CLAUDE_ENV_FILE"
fi

# Return success with context
echo "{
  \"decision\": \"approve\",
  \"systemMessage\": $(echo "$CONTEXT_MSG" | jq -Rs .)
}"
exit 0
