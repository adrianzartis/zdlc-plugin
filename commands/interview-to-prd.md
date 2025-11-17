---
description: Transform raw user interview notes into a structured Product Requirements Document
argument-hint: [notes-file or @notes-file]
allowed-tools: Read, Write, mcp__miro__*, mcp__mermaid__*, mcp__atlassian__*
model: claude-sonnet-4-5-20250929
---

# Interview to PRD - Requirements Processing

Convert user interview notes into a structured, actionable PRD.

## What This Does

1. **Reads interview notes** from file ($1)
2. **Extracts structured information**:
   - User pain points
   - Desired outcomes
   - Success metrics
   - Technical constraints
3. **Generates comprehensive PRD** with:
   - Executive summary
   - Problem statement
   - User personas
   - Requirements (functional & non-functional)
   - Success criteria
   - Out of scope
   - Timeline and milestones
4. **Creates user journey map** in Miro (optional)
5. **Generates architecture diagram** with Mermaid
6. **Saves PRD** to Confluence (if configured) and local file

## Usage

With file reference:
```
/interview-to-prd @docs/interview-notes.md
```

With file path:
```
/interview-to-prd docs/interview-sarah-order-history.txt
```

## Input Format

Your interview notes can be in any format - raw notes, transcripts, bullet points. Examples:

### Raw Notes
```
Interview with Sarah (Product Manager) - Jan 15, 2025

Problem: Users frustrated with current order history
- Can't filter by date
- No export functionality
- Takes too long to load
- Want to see order status updates

Wants: Fast, filterable order history with export to CSV
Success: Users can find any order in < 5 seconds
```

### Structured Interview
```
Interviewee: John (Enterprise Customer)
Date: Jan 15, 2025
Context: Struggling with bulk operations

Pain Points:
1. Can't process multiple orders at once
2. Have to click through 20+ screens
3. Takes 2 hours daily

Desired Solution:
- Bulk selection
- Batch operations (refund, cancel, etc.)
- Progress indicator
```

## Output

### PRD Structure

```markdown
# Product Requirements Document: [Feature Name]

## Executive Summary
Brief overview of what we're building and why

## Problem Statement
Clear description of the user problem

## User Personas
### Primary: [Name]
- Role
- Goals
- Pain points
- Technical proficiency

### Secondary: [Name]
...

## Requirements

### Functional Requirements
FR1: [Requirement description]
- Rationale
- Acceptance criteria

FR2: ...

### Non-Functional Requirements
NFR1: Performance - Page load < 2 seconds
NFR2: Accessibility - WCAG 2.1 AA compliance
...

## Success Metrics
- Metric 1: [How we measure success]
- Metric 2: ...

## User Stories (High-Level)
- As a [persona], I want to [action] so that [benefit]
- ...

## Technical Considerations
- Architecture approach
- Technology stack
- Integration points
- Security requirements

## Out of Scope
Explicitly what we're NOT building in this iteration

## Timeline
- Phase 1: [dates] - [scope]
- Phase 2: ...

## Open Questions
- Question 1
- Question 2

## Appendix
- User journey map link (Miro)
- Architecture diagram
- Interview transcript
```

## Process

1. Read and parse interview notes:
   - Extract key information
   - Identify patterns across multiple interviews (if batch)
   - Categorize findings

2. Identify user personas:
   - Create distinct personas from interview subjects
   - Define goals, pain points, behaviors
   - Prioritize primary vs secondary personas

3. Synthesize requirements:
   - Convert pain points into functional requirements
   - Derive non-functional requirements (performance, security, etc.)
   - Group related requirements

4. Define success metrics:
   - Quantifiable measures
   - Aligned with business goals
   - Measurable post-launch

5. Create high-level user stories:
   - One story per major requirement
   - Focus on user value
   - Include acceptance criteria

6. Generate visual artifacts:
   - **Miro Board**: User journey map showing current vs future state
   - **Mermaid Diagram**: System architecture or user flow

7. Save outputs:
   - Local: `prds/[feature-name]-prd.md`
   - Confluence: "PRDs" space (if configured)
   - Miro: Board link embedded in PRD

8. Next steps suggestion:
   - Command to break down into user stories: `/prd-to-stories`
   - Stakeholder review checklist
   - Design handoff requirements

## Example

```
/interview-to-prd @interviews/order-history-interviews.md
```

Output:
```
✅ PRD created: prds/order-history-enhancement-prd.md
✅ User journey map: [Miro board link]
✅ Architecture diagram saved: diagrams/order-history-arch.svg
✅ Confluence page: [link]

Next: Review PRD with stakeholders, then run:
/prd-to-stories prds/order-history-enhancement-prd.md
```

## Tips

- Interview multiple users for better coverage
- Include specific quotes in your notes (preserved in PRD)
- Note any technical constraints mentioned
- Capture success metrics explicitly
- If multiple interviews, combine into one file before processing

## Advanced Options

Add specific guidance:

```
/interview-to-prd @interviews/notes.md Focus on MVP features only. Target: 2-week sprint.
```

This helps scope the PRD appropriately.

## Batch Processing

Process multiple interview files at once:

```
/interview-to-prd @interviews/sarah.md @interviews/john.md @interviews/mary.md
```

The command will synthesize findings across all interviews into a comprehensive PRD.
