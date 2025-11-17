---
name: ado-sync
description: Automatically syncs code changes with Azure DevOps work items. Links commits to stories, updates work item status based on PR state, and maintains traceability between code and requirements. Invoked when making commits, creating PRs, or discussing work items.
allowed-tools: Bash, mcp__azure-devops__*, mcp__github__*
---

# ADO Sync Skill

Keeps Azure DevOps work items perfectly synchronized with code changes for complete traceability.

## When I Activate

I activate automatically when you:
- Make a git commit
- Create a pull request
- Merge a PR
- Mention an ADO work item ID
- Discuss story status
- Ask about work item details

## What I Do

### 1. Link Commits to Work Items

**Auto-detect work item references:**
```bash
# I recognize these patterns in your commits:
- "AB#12345"
- "#12345" (if project context known)
- "Story 12345"
- "Fix bug 67890"
```

**Enhance commit messages:**
```bash
# Your commit:
git commit -m "Add date filter to orders"

# I enhance to:
git commit -m "Add date filter to orders

Implements user story AB#12345: Date range filtering for order history

Changes:
- Added DateRangePicker component
- Implemented filter logic
- Added unit tests

AB#12345"
```

### 2. Update Work Item Status

I automatically update ADO based on code state:

| Code Event | ADO Update |
|------------|-----------|
| Branch created | Status → "In Progress" |
| PR created | Status → "In Review" |
| PR approved | Add comment: "PR approved" |
| PR merged | Status → "Closed", Resolution → "Completed" |
| PR rejected | Status → "Active", Add comment with reason |

### 3. Sync PR Information

When you create a PR, I:
```
1. Add ADO work item link to PR description
2. Add PR link as comment in ADO work item
3. Update work item with PR number
4. Add relevant tags (e.g., "has-pr")
5. Notify assigned user (optional)
```

### 4. Maintain Traceability

I create complete audit trail:
```
ADO Work Item #12345
├─ Branch: feature/AB-12345-date-filter
├─ Commits: 8 commits
│  ├─ abc123: Add DatePicker component
│  ├─ def456: Implement filter logic
│  └─ ghi789: Add tests
├─ PR: #342 - "Add date range filtering"
│  ├─ Created: Jan 15, 2025
│  ├─ Reviewed by: Sarah, John
│  ├─ CI: ✅ All checks passed
│  └─ Merged: Jan 16, 2025
└─ Status: Closed ✅
```

## Branch Naming Convention

I enforce and recognize these patterns:

### Standard Format:
```bash
feature/AB-12345-short-description   # Feature work
bugfix/AB-67890-short-description    # Bug fixes
hotfix/AB-99999-short-description    # Production hotfixes
chore/AB-11111-short-description     # Maintenance
```

### Work Item Detection:
I extract work item ID from:
1. Branch name: `feature/AB-12345-*` → Work Item 12345
2. Commit message: `"Fix AB#67890"` → Work Item 67890
3. PR title: `"[AB-12345] Add feature"` → Work Item 12345

## Commit Message Enhancement

### Basic Commit:
```bash
git commit -m "Fix login timeout"
```

### I Transform To:
```bash
git commit -m "Fix login timeout issue in Auth service

Root cause: Session timeout set to 30s instead of 30m
Solution: Updated session config to 30 minutes

Fixes bug AB#67890

- Updated auth.config.ts timeout value
- Added session expiration tests
- Verified manually with 30min idle time

AB#67890"
```

## PR Creation Workflow

When you create a PR, I automatically:

### 1. Generate PR Description:
```markdown
## Summary
Implements date range filtering for order history (Story AB#12345)

## Changes
- Added DateRangePicker component with accessibility support
- Implemented client-side and server-side filtering
- Added comprehensive test suite (24 tests)
- Updated documentation

## Acceptance Criteria
- [x] AC1: User can select date range
- [x] AC2: Filter applies to order list
- [x] AC3: Clear filter functionality
- [x] AC4: Invalid date range handling
- [x] AC5: URL parameter persistence

## Testing
- Unit tests: 24 passed
- Integration tests: 8 passed
- Manual testing: Verified all ACs
- Performance: Filter completes in 150ms (< 200ms requirement)

## Screenshots
[If UI changes]

## Related Work Items
- Story: AB#12345
- Epic: AB#12000

## Checklist
- [x] Tests added and passing
- [x] Documentation updated
- [x] No breaking changes
- [x] Accessibility verified
- [x] Performance tested
```

### 2. Link to ADO:
- Add PR link in ADO work item comments
- Update work item status
- Add "in-review" tag

### 3. Request Reviewers:
- Based on file ownership (CODEOWNERS)
- Based on expertise area
- Based on team configuration

## Status Synchronization

### Automatic Status Updates:

```
Work Item Status Pipeline:
New → Active → In Progress → In Review → Closed

Code Triggers:
1. Branch created → "In Progress"
2. PR created → "In Review"
3. PR merged → "Closed"
4. PR closed (not merged) → "Active"
```

### Handling Edge Cases:

**Scenario: PR created but not ready**
```
- PR title starts with "WIP:" or "Draft:"
- Action: Don't change status to "In Review" yet
- Wait for "WIP:" removal or draft → ready conversion
```

**Scenario: Multiple PRs for one story**
```
- First PR → "In Review"
- Subsequent PRs → Add comment, keep "In Review"
- All PRs merged → "Closed"
```

**Scenario: PR reverted**
```
- Revert commit detected
- Action: Reopen work item, status → "Active"
- Add comment: "PR #342 was reverted, work item reopened"
```

## Work Item Information Injection

When you mention a work item, I inject context:

```bash
You: "I'm working on story 12345"

Me: "Fetching details for Story AB#12345..."

📋 Story AB#12345: Date Range Filtering for Order History
Status: In Progress
Assigned: You
Sprint: Sprint 42
Priority: High
Story Points: 5

Acceptance Criteria:
- AC1: User can select date range ❌
- AC2: Filter applies to order list ❌
- AC3: Clear filter functionality ❌
- AC4: Invalid date range handling ❌
- AC5: URL parameter persistence ❌

Linked Items:
- Epic: AB#12000 - Order History Enhancement
- Design: [Figma link]

Current Branch: feature/AB-12345-date-filter
No PR yet

Ready to implement?
```

## Integration Checks

Before allowing actions, I verify:

### For Commits:
- [ ] Work item exists
- [ ] Work item is in valid state (not Closed)
- [ ] User has permission to update

### For PRs:
- [ ] All commits reference work items
- [ ] Work item is assigned
- [ ] Acceptance criteria are present
- [ ] Branch follows naming convention

### For Merges:
- [ ] All acceptance criteria checked off
- [ ] Tests passing
- [ ] Code reviewed
- [ ] No blocking comments

## Configuration

Customize behavior via settings:

```json
{
  "ado-sync": {
    "auto-update-status": true,
    "require-work-item-link": true,
    "pr-template": "default",
    "notify-on-merge": true,
    "status-mapping": {
      "pr-created": "In Review",
      "pr-merged": "Closed",
      "branch-created": "In Progress"
    }
  }
}
```

## Conflict Resolution

**Multiple developers on same story:**
- I track individual branches
- PRs reference same work item
- Last PR to merge updates status to "Closed"

**Work item status conflicts:**
- Human changes take precedence
- I add comments explaining auto-updates
- Option to disable auto-updates per item

## Reporting

I can generate reports:

```bash
/ado-sync report

📊 ADO Sync Report - Last Sprint

Stories Completed: 12
├─ With PRs: 12 (100%)
├─ Average cycle time: 2.3 days
└─ All linked to code: Yes

Commits: 89
├─ Linked to work items: 87 (98%)
└─ Orphan commits: 2

PRs Created: 15
├─ Linked to stories: 15 (100%)
├─ Average review time: 4.2 hours
└─ Merge rate: 93%

Traceability: ✅ Excellent
```

## Tips

For best results:
- Use standard branch naming: `feature/AB-12345-description`
- Reference work items in commits: `AB#12345`
- Keep work items up to date in ADO
- Review auto-generated PR descriptions
- Trust the automation but verify

I keep your code and work items perfectly synchronized, giving you complete traceability from requirement to production!
