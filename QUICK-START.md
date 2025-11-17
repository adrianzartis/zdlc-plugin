# ⚡ zDLC Plugin - Quick Start Guide

**Get started with zDLC in 5 minutes**

---

## ✅ Installation (3 Simple Steps)

### Step 1: Clone the Repository

```bash
git clone https://github.com/adrianzartis/zdlc-plugin.git
```

### Step 2: Install the Plugin

```bash
# Create plugins directory
mkdir -p ~/.claude/plugins

# Copy plugin
cp -r zdlc-plugin ~/.claude/plugins/zdlc

# Verify installation
ls -la ~/.claude/plugins/zdlc/.claude-plugin/plugin.json
```

**Expected output:** You should see `plugin.json` listed

### Step 3: Restart Claude Desktop

**IMPORTANT**: You MUST completely restart Claude Desktop for the plugin to load.

```bash
# On Mac:
# 1. Press Cmd+Q to quit Claude Desktop
# 2. Reopen Claude Desktop from Applications

# On Linux/Windows:
# Completely close and reopen Claude Desktop
```

---

## 🧪 Verify Installation

Check that the plugin loaded correctly:

```bash
# Start Claude Code
claude

# In Claude, type:
> What plugins are installed?

# Or check commands:
> /ship-story --help
```

**If you see the command help**, the plugin is working! 🎉

**If you get "command not found"**, restart Claude Desktop again.

---

## 🚀 Try Your First Command

Let's test the plugin with a simple example:

```bash
# Start Claude Code
claude

# Try any of these:
> /ship-story --help
> /bug-fix --help
> /generate-gherkin --help

# Or just talk naturally:
> Create user stories for a login feature
> Implement a React component using latest patterns
> Generate Gherkin test scenarios
```

---

## 🔧 Configure MCPs (Required for Full Functionality)

For the plugin to work with Azure DevOps and GitHub, you need to configure MCPs:

### 1. Open Claude Desktop Config

```bash
open ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

### 2. Add MCP Configuration

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "npx",
      "args": ["-y", "@azure-devops/mcp", "YOUR-ORG-NAME"],
      "env": {
        "AZURE_DEVOPS_PAT": "YOUR-TOKEN"
      }
    },
    "github": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR-TOKEN"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

### 3. Get Your Tokens

- **Azure DevOps**: https://dev.azure.com/YOUR-ORG/_usersSettings/tokens
  - Scopes: Work Items (Read, Write, & Manage), Code (Read), Project (Read)

- **GitHub**: https://github.com/settings/tokens
  - Scopes: repo (full control), workflow

### 4. Restart Claude Desktop

After adding MCPs, restart Claude Desktop (Cmd+Q, then reopen).

---

## 💡 Quick Usage Examples

### Example 1: Implement a Story from Azure DevOps

```bash
claude

> /ship-story 12345

# Claude will:
# ✅ Read story from Azure DevOps
# ✅ Fetch current library docs (React, Next.js, etc.)
# ✅ Implement production code with tests
# ✅ Create PR on GitHub
# ✅ Update story status in ADO
```

### Example 2: Create User Stories from Interview

```bash
> I have interview notes in docs/interview.md

# Claude will:
# ✅ Read the interview
# ✅ Analyze requirements
# ✅ Create PRD
# ✅ Generate INVEST-compliant user stories
# ✅ Ask if you want to push to Azure DevOps
```

### Example 3: Generate BDD Test Scenarios

```bash
> /generate-gherkin 12345 cucumber

# Claude will:
# ✅ Read story from Azure DevOps
# ✅ Generate .feature file with scenarios
# ✅ Create step definitions
# ✅ Save to features/ directory
```

---

## 📚 What's Included

**Commands** (Type `/` to see all):
- `/ship-story [id]` - Complete story implementation
- `/bug-fix [id]` - Fix bug with RCA
- `/sprint-summary [sprint]` - Generate sprint report
- `/interview-to-prd [@file]` - Interview to PRD
- `/prd-to-stories [@file]` - PRD to user stories
- `/generate-gherkin [id]` - BDD test scenarios

**Skills** (Auto-activate):
- story-generator - Creates INVEST-compliant stories
- context-aware-coding - Uses latest library docs
- ado-sync - Syncs with Azure DevOps
- gherkin-converter - Generates BDD scenarios

**Agents** (Work behind the scenes):
- senior-developer - Production code expert
- product-manager - Requirements expert
- qa-specialist - Test automation expert

---

## 🆘 Troubleshooting

### Plugin Not Loading

**Problem**: Commands not found after installation

**Solution**:
```bash
# Verify plugin is in correct location
ls -la ~/.claude/plugins/zdlc/.claude-plugin/plugin.json

# If missing, reinstall:
cp -r zdlc-plugin ~/.claude/plugins/zdlc

# Restart Claude Desktop (IMPORTANT!)
# Press Cmd+Q, then reopen
```

### MCPs Not Working

**Problem**: "Cannot connect to Azure DevOps" or similar

**Solution**:
1. Check config: `open ~/Library/Application\ Support/Claude/claude_desktop_config.json`
2. Verify tokens are correct
3. Restart Claude Desktop
4. Check Docker is running (for GitHub MCP)

### Commands Show But Don't Work

**Problem**: Command runs but fails

**Solution**:
1. Make sure MCPs are configured (see above)
2. Check you have correct permissions for Azure DevOps/GitHub
3. Verify work item/story IDs are correct

---

## 📖 Full Documentation

For complete documentation, see:

- **HOW-TO-INSTALL.md** - Detailed installation guide
- **README.md** - Full feature overview
- **docs/SETUP.md** - Configuration details
- **.env.example** - MCP credential template

---

## 🎯 Next Steps

1. ✅ **Install plugin** (follow steps above)
2. ✅ **Configure MCPs** (Azure DevOps, GitHub, context7)
3. ✅ **Try a command** (`/ship-story --help`)
4. ✅ **Implement a story** (`/ship-story 12345`)
5. ✅ **Explore features** (see README.md)

---

## 🔗 Links

- **Repository**: https://github.com/adrianzartis/zdlc-plugin
- **Issues**: https://github.com/adrianzartis/zdlc-plugin/issues
- **Full Docs**: https://github.com/adrianzartis/zdlc-plugin#readme

---

**That's it! You're ready to automate your SDLC with zDLC** 🚀

*Transform your workflow. Ship faster. Build better.*
