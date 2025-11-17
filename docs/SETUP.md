# zDLC Plugin - Setup Guide

Complete setup instructions for the zDLC plugin.

---

## Prerequisites

### 1. Claude Code Installation

Ensure Claude Code is installed:
```bash
which claude
# Should output: /path/to/claude

claude --version
# Should show version info
```

If not installed, visit: https://code.claude.com

### 2. Required MCPs

Configure these MCPs in Claude Desktop before using zDLC:

**Required:**
- azure-devops
- github

**Recommended:**
- context7 (for current library docs)

**Optional:**
- slack (team notifications)
- atlassian (documentation)
- figma (design implementation)
- miro (visual planning)
- mermaid (diagrams)

---

## Installation Steps

### Step 1: Install the Plugin

#### Option A: From Marketplace (Coming Soon)
```bash
claude plugin install zdlc
```

#### Option B: From GitHub
```bash
claude plugin install zdlc@github.com/adrianzartis/zdlc-plugin
```

#### Option C: Local Development
```bash
# Clone the repository
git clone https://github.com/adrianzartis/zdlc-plugin.git
cd zdlc-plugin

# Install locally
claude plugin install .
```

### Step 2: Verify Installation

```bash
# List installed plugins
claude --list-plugins

# Should see:
# zdlc (v1.0.0) - AI-Powered SDLC Automation

# Test a command
claude
> /ship-story --help
```

### Step 3: Configure Azure DevOps

Ensure Azure DevOps MCP is configured in Claude Desktop:

`~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "npx",
      "args": ["-y", "@azure-devops/mcp", "your-org-name"],
      "env": {
        "AZURE_DEVOPS_PAT": "your-personal-access-token"
      }
    }
  }
}
```

Get PAT from: https://dev.azure.com/your-org/_usersSettings/tokens

Required scopes:
- Work Items: Read, Write, & Manage
- Code: Read
- Project and Team: Read

### Step 4: Configure GitHub

`~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
      }
    }
  }
}
```

Get token from: https://github.com/settings/tokens

Required scopes:
- repo (full control)
- workflow

### Step 5: Configure context7 (Recommended)

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

No auth required for basic use.

### Step 6: Configure Slack (Optional)

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-bot-token",
        "SLACK_TEAM_ID": "T01234567"
      }
    }
  }
}
```

Setup Slack bot:
1. Go to https://api.slack.com/apps
2. Create New App
3. Add Bot Token Scopes:
   - channels:history, channels:read, channels:write
   - chat:write
   - users:read
4. Install to Workspace
5. Copy Bot User OAuth Token

### Step 7: Restart Claude Desktop

```bash
# Quit Claude Desktop (Cmd+Q on Mac)
# Reopen Claude Desktop

# Verify MCPs loaded
# Check logs for any errors
```

---

## Configuration

### Project-Level Configuration

Create `.claude/settings.json` in your project:

```json
{
  "plugins": {
    "zdlc": {
      "enabled": true,
      "hooks": {
        "auto-link-work-items": true,
        "commit-validation": true,
        "post-merge-notifications": true,
        "sprint-context": true
      },
      "ado-sync": {
        "auto-update-status": true,
        "require-work-item-link": true,
        "project": "YourProjectName",
        "default-area": "YourTeam"
      },
      "slack": {
        "enabled": true,
        "default-channel": "#engineering",
        "bug-channel": "#incidents",
        "notify-on-merge": true
      }
    }
  }
}
```

### User-Level Configuration

Create `~/.claude/settings.json` for personal preferences:

```json
{
  "plugins": {
    "zdlc": {
      "commands": {
        "auto-run-tests": true,
        "verbose-output": false
      },
      "skills": {
        "story-generator": {
          "default-story-points": "3-5",
          "include-technical-notes": true
        },
        "context-aware-coding": {
          "always-fetch-docs": true,
          "preferred-frameworks": ["React", "Next.js"]
        }
      }
    }
  }
}
```

---

## Verification

### Test Commands

```bash
# Start Claude Code
claude

# Test interview processing
> /interview-to-prd @docs/test-interview.md

# Test story generation
> /prd-to-stories @prds/test-prd.md

# Test ADO integration
> Read work item AB#12345
# (replace with actual work item ID)
```

### Test Skills

```bash
# Test story-generator skill
> Create user stories for a date picker feature

# Test context-aware-coding skill
> Implement a React component using the latest hooks patterns

# Test ado-sync skill
> What's the status of story AB#12345?
```

### Test Hooks

```bash
# Test commit validation
> Make a commit without work item reference
# Should prompt for work item

# Test sprint context
# Should see sprint info on session start
```

---

## Troubleshooting

### Plugin Not Found

```bash
# Check plugin directory
ls -la ~/.claude/plugins/

# Reinstall
claude plugin uninstall zdlc
claude plugin install zdlc
```

### MCP Connection Issues

```bash
# Verify MCPs in Claude Desktop
# Check ~/Library/Application Support/Claude/claude_desktop_config.json

# Test MCP directly
npx @azure-devops/mcp test
```

### Hook Scripts Not Executing

```bash
# Make scripts executable
chmod +x ~/.claude/plugins/zdlc/hooks/scripts/*.sh

# Test script directly
bash ~/.claude/plugins/zdlc/hooks/scripts/pre-commit-validator.sh <<< '{}'
```

### Permission Errors

```bash
# Check file ownership
ls -la ~/.claude/plugins/zdlc/

# Fix if needed
chmod -R u+rw ~/.claude/plugins/zdlc/
```

---

## Team Setup

### For Team Installation

1. **Add to repository** (recommended):
   ```bash
   # In your project root
   mkdir -p .claude/plugins
   git submodule add https://github.com/adrianzartis/zdlc-plugin .claude/plugins/zdlc
   ```

2. **Configure in project settings**:
   `.claude/settings.json`:
   ```json
   {
     "plugins": {
       "zdlc": {
         "enabled": true,
         "trust-plugins": ["zdlc"]
       }
     }
   }
   ```

3. **Team members install**:
   ```bash
   git submodule update --init
   claude plugin install .claude/plugins/zdlc
   ```

### Team Configuration

Share team settings in `.claude/settings.json`:
```json
{
  "plugins": {
    "zdlc": {
      "ado-sync": {
        "project": "TeamProject",
        "area": "TeamName"
      },
      "slack": {
        "default-channel": "#team-engineering",
        "bug-channel": "#team-incidents"
      },
      "conventions": {
        "branch-prefix": "feature/",
        "commit-format": "conventional"
      }
    }
  }
}
```

---

## Updating

### Update Plugin

```bash
# From marketplace
claude plugin update zdlc

# From GitHub
claude plugin update zdlc@github.com/adrianzartis/zdlc-plugin

# Local development
cd zdlc-plugin
git pull
claude plugin install .
```

### Check Version

```bash
claude --list-plugins
# Shows: zdlc (v1.0.0)
```

---

## Uninstallation

```bash
# Uninstall plugin
claude plugin uninstall zdlc

# Remove configuration (optional)
rm ~/.claude/plugins/zdlc -rf
```

---

## Next Steps

1. **Read the README**: `README.md` for features overview
2. **Try Quick Start**: Follow examples in README
3. **Configure for your team**: Set up project-level settings
4. **Explore commands**: Try `/ship-story`, `/bug-fix`, etc.
5. **Join community**: GitHub Discussions for tips and support

---

## Support

- Documentation: [README.md](../README.md)
- Issues: [GitHub Issues](https://github.com/adrianzartis/zdlc-plugin/issues)
- Discussions: [GitHub Discussions](https://github.com/adrianzartis/zdlc-plugin/discussions)

---

**Happy shipping!** 🚀
