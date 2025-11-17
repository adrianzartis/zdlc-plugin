---
description: Generate comprehensive sprint summary with metrics, share on Slack, and document in Confluence
argument-hint: [sprint-id or sprint-name]
allowed-tools: mcp__azure-devops__*, Bash, mcp__github__*, mcp__slack__*, mcp__atlassian__*, mcp__mermaid__*
model: claude-sonnet-4-5-20250929
---

# Sprint Summary - Automated Reporting

Generate a comprehensive sprint summary with metrics, achievements, and insights.

## What This Does

1. **Queries Azure DevOps** for sprint data (ID/name: $1)
2. **Analyzes completed work** - stories, bugs, tasks
3. **Calculates metrics** - velocity, burn rate, completion rate
4. **Checks GitHub activity** - PRs merged, code changes
5. **Generates summary report** with visualizations
6. **Posts to Slack** (#engineering or #product)
7. **Creates Confluence page** in "Sprint Reports" space
8. **Identifies insights** - bottlenecks, successes, areas for improvement

## Usage

```
/sprint-summary "Sprint 42"
```

or

```
/sprint-summary 12345
```

Where "Sprint 42" is the sprint name or `12345` is the sprint ID.

## What's Included

### Sprint Overview
- Sprint name and dates
- Team members
- Sprint goal achievement

### Metrics
- **Velocity**: Story points completed vs committed
- **Completion Rate**: % of committed work completed
- **Cycle Time**: Average time from "In Progress" to "Done"
- **Bug Rate**: Bugs found/fixed ratio
- **PR Stats**: PRs created, merged, average review time

### Work Breakdown
- **Completed Stories**: List with story points
- **Incomplete Stories**: With reasons (blocked, deprioritized, etc.)
- **Bugs Fixed**: By severity
- **Technical Debt**: Addressed this sprint

### Achievements
- Major features shipped
- Performance improvements
- Technical accomplishments
- Team milestones

### Challenges
- Blockers encountered
- Stories that took longer than estimated
- Unexpected work (urgent bugs, production issues)

### Visualizations
- Burndown chart (using mermaid)
- Story points flow diagram
- Bug trend graph

### Retrospective Inputs
- What went well
- What could be improved
- Action items for next sprint

## Process

1. Query ADO for sprint details:
   ```
   - Sprint dates and current state
   - All work items in the sprint
   - Work item history and transitions
   - Team capacity and assignments
   ```

2. Calculate core metrics:
   ```
   - Total committed story points
   - Completed story points
   - Velocity (completed / team capacity)
   - Average cycle time per work item
   - Bug escape rate
   ```

3. Analyze GitHub activity:
   ```
   - PRs created during sprint
   - PRs merged
   - Code review metrics
   - Lines changed (net)
   ```

4. Generate insights using AI:
   ```
   - Identify patterns (e.g., "Stories in area X took 50% longer")
   - Highlight successes (e.g., "Zero production bugs this sprint")
   - Flag concerns (e.g., "3 stories remain blocked")
   ```

5. Create visualizations:
   ```
   - Burndown chart showing daily progress
   - Story distribution by type and status
   - Team contribution breakdown
   ```

6. Post to Slack:
   ```
   Channel: #engineering or #product (configurable)
   Format: Summary headline + key metrics + link to full report
   Example: "📊 Sprint 42 Complete! 34/38 points (89%) | 12 stories shipped | Avg cycle time: 2.3 days. Full report: [link]"
   ```

7. Create Confluence page:
   ```
   Space: "Sprint Reports"
   Title: "Sprint 42 Summary - [Dates]"
   Sections: All metrics, charts, achievements, retrospective inputs
   Tags: sprint-42, q1-2025, team-alpha
   ```

8. Optional notifications:
   ```
   - @mention stakeholders in Confluence
   - DM product owner with highlights
   - Post retrospective prompts to #retrospectives
   ```

## Example Output

### Slack Message:
```
📊 Sprint 42 Complete! (Jan 15 - Jan 26)

✅ 34/38 story points (89% completion)
🚀 12 user stories shipped
🐛 8 bugs fixed (2 critical)
⚡ Avg cycle time: 2.3 days (↓ 0.5 days)
📈 Velocity: 17 points/week

Top Achievements:
• Google SSO integration launched
• Dashboard performance improved 40%
• Zero production incidents

Full Report: [Confluence Link]
```

### Confluence Page Structure:
```
# Sprint 42 Summary

## Overview
- Sprint: Jan 15 - Jan 26, 2025
- Team: Alpha Squad (6 engineers)
- Sprint Goal: ✅ Launch SSO and improve dashboard performance

## Metrics Dashboard
[Burndown Chart]
[Velocity Trend]
[Bug Metrics]

## Completed Work
### User Stories (12)
- [AB-12345] Google SSO Integration (8 pts)
- [AB-12346] Dashboard Performance Optimization (5 pts)
...

## Retrospective Insights
### What Went Well 👍
- SSO implementation went smoothly
- Great collaboration on performance work
...
```

## Tips

- Run this at sprint end (last day or first day of next sprint)
- Review the generated summary before posting
- Add your own insights to the "What could be improved" section
- Use insights for retrospective discussion
- Compare trends across sprints

## Advanced Options

Customize the report:

```
/sprint-summary "Sprint 42" Include detailed code metrics and highlight security improvements
```

The additional instructions ($ARGUMENTS) help focus the summary.

## Automation Note

This command can be scheduled to run automatically at sprint end using a cron job or CI/CD pipeline that invokes Claude Code in headless mode.
