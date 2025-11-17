---
description: Complete end-to-end implementation of an Azure DevOps story - from reading requirements to merged PR
argument-hint: [story-id]
allowed-tools: mcp__azure-devops__*, mcp__context7__*, Read, Write, Edit, Bash, mcp__github__*, mcp__slack__*, mcp__atlassian__*
model: claude-sonnet-4-5-20250929
---

# Ship Story - Complete Implementation Workflow

Implement a complete user story from Azure DevOps with full automation.

## What This Does

1. **Reads the story** from Azure DevOps (ID: $1)
2. **Analyzes requirements** - acceptance criteria, linked designs, dependencies
3. **Fetches current documentation** via context7 for required libraries
4. **Implements production code** with:
   - Full feature implementation (not templates)
   - Comprehensive test suite
   - Error handling and edge cases
   - Design system compliance (if Figma linked)
5. **Creates pull request** with proper linking to ADO story
6. **Monitors CI/CD** pipeline
7. **Notifies team** via Slack (if configured)
8. **Updates ADO story** status to "In Review"

## Usage

```
/ship-story 12345
```

Where `12345` is your Azure DevOps work item ID.

## Prerequisites

- Azure DevOps MCP configured
- Story must have clear acceptance criteria
- Your git working directory must be clean

## Process

You'll implement the story with modern, production-ready code. The workflow:

1. First, read the story details from ADO including:
   - Title and description
   - Acceptance criteria
   - Linked Figma designs (if any)
   - Parent features/epics for context

2. Determine required libraries/frameworks from:
   - Existing package.json/requirements.txt
   - Story technical notes
   - Team conventions

3. Use context7 to fetch current documentation for:
   - Primary framework (React, Angular, Vue, etc.)
   - UI libraries (Material-UI, Ant Design, etc.)
   - Utility libraries (lodash, date-fns, etc.)

4. Implement following best practices:
   - Write production code (no TODOs)
   - Include comprehensive tests (unit + integration)
   - Handle errors gracefully
   - Add proper logging
   - Follow team coding standards
   - Ensure accessibility (WCAG 2.1 AA)
   - Mobile-responsive if UI component

5. Run tests locally to ensure they pass

6. Create a git commit with:
   - Descriptive message
   - Reference to ADO story: "AB#12345"
   - Co-authored attribution

7. Create PR via GitHub MCP:
   - Link to ADO story
   - Include acceptance criteria checklist
   - Add relevant labels
   - Request reviewers (if configured)

8. Monitor CI/CD pipeline:
   - Wait for tests to complete
   - Report any failures

9. Update ADO story status to "In Review"

10. (Optional) Notify team on Slack:
    - Post to #engineering channel
    - Include PR link and story summary

## Example

```
/ship-story 45678
```

This will read story #45678, implement it with tests, create a PR, and update ADO.

## Tips

- Ensure your branch name follows convention: `feature/AB-12345-short-description`
- Review the generated code before pushing
- The PR will be created but NOT auto-merged (requires human approval)
- If tests fail, the workflow will pause for you to fix issues

## Advanced Options

Add instructions after the story ID for customization:

```
/ship-story 12345 Use React 18 with TypeScript. Add extra validation for email fields.
```

The additional context ($ARGUMENTS) helps tailor the implementation.
