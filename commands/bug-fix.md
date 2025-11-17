---
description: Complete bug fix workflow - read bug from ADO, fix, test, PR, notify team, document RCA
argument-hint: [bug-id]
allowed-tools: mcp__azure-devops__*, mcp__context7__*, Read, Write, Edit, Bash, mcp__github__*, mcp__slack__*, mcp__atlassian__*
model: claude-sonnet-4-5-20250929
---

# Bug Fix - Complete Resolution Workflow

Fix a bug with full documentation and team notification.

## What This Does

1. **Reads the bug** from Azure DevOps (ID: $1)
2. **Analyzes the issue** - reproduction steps, impact, related code
3. **Debugs and identifies root cause**
4. **Implements the fix** with:
   - Minimal, focused changes
   - Regression tests
   - Validation against reproduction steps
5. **Creates pull request** with bug reference
6. **Notifies team** via Slack with severity indicator
7. **Documents RCA** (Root Cause Analysis) in Confluence
8. **Updates bug status** to "Resolved"

## Usage

```
/bug-fix 67890
```

Where `67890` is your Azure DevOps bug work item ID.

## Process

1. Read bug details from ADO:
   - Title, description, and reproduction steps
   - Severity and priority
   - Affected version/environment
   - Reporter and stakeholders
   - Related work items

2. Locate the problematic code:
   - Use error stack traces if available
   - Search for relevant files/functions
   - Check recent changes (git log)
   - Review related issues

3. Identify root cause:
   - Trace execution flow
   - Check assumptions and edge cases
   - Validate against reproduction steps
   - Consider side effects

4. Implement minimal fix:
   - Make focused changes
   - Avoid scope creep
   - Preserve existing behavior (except the bug)
   - Use context7 for library-specific fixes

5. Add regression tests:
   - Test the specific bug scenario
   - Test edge cases that could cause similar issues
   - Ensure tests fail without the fix
   - Verify tests pass with the fix

6. Validate the fix:
   - Run all tests
   - Manually verify reproduction steps
   - Check for unintended side effects

7. Create commit and PR:
   - Message: "Fix: [brief description] (AB#67890)"
   - PR description includes:
     - Bug summary
     - Root cause explanation
     - Fix description
     - Testing performed

8. Notify team on Slack:
   - Channel based on severity:
     - Critical/High: #incidents
     - Medium/Low: #engineering
   - Include: bug ID, title, fix summary, PR link
   - Use emoji indicators: 🔥 (critical), ⚠️ (high), 🐛 (medium/low)

9. Document RCA in Confluence:
   - Create page in "Bug RCAs" space
   - Sections: Summary, Timeline, Root Cause, Resolution, Prevention
   - Link to ADO bug and GitHub PR

10. Update ADO bug:
    - Status: "Resolved"
    - Add comment with RCA link
    - Update resolution details

## Example

```
/bug-fix 98765
```

This will fix bug #98765, create PR, notify team, document RCA, and update ADO.

## Severity Handling

The workflow adapts based on bug severity:

**Critical (P0):**
- Immediate Slack notification to #incidents
- Detailed RCA required
- Hotfix branch if in production
- Stakeholder notification

**High (P1):**
- Slack notification to #incidents
- Standard RCA required
- Fast-track PR review

**Medium (P2):**
- Slack notification to #engineering
- Brief RCA optional

**Low (P3):**
- No Slack notification (unless requested)
- RCA not required

## Tips

- Branch name: `bugfix/AB-67890-short-description`
- Keep fixes minimal and focused
- Don't refactor during bug fixes (unless it's the root cause)
- Add comments explaining non-obvious fixes
- Consider if similar bugs exist elsewhere

## Advanced Options

Add context for complex bugs:

```
/bug-fix 98765 The issue only happens in Safari. Check CSS grid compatibility.
```
