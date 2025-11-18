# ⚡ zDLC Plugin - Super Simple Installation

**Install the zDLC plugin in Claude Code with just 2 commands!**

---

## 🚀 Installation (2 Commands)

Open Claude Code and run these two commands:

```bash
# Step 1: Add the marketplace
/plugin marketplace add adrianzartis/zdlc-plugin

# Step 2: Install the plugin
/plugin install zdlc@adrianzartis
```

**That's it!** The plugin is now installed and ready to use! 🎉

---

## ✅ Verify Installation

After installing, try a command:

```bash
/ship-story --help
```

If you see the command help, it's working!

---

## 🎯 Quick Start

Try these commands immediately:

```bash
# Implement a story from Azure DevOps
/ship-story 12345

# Fix a bug with full RCA
/bug-fix 67890

# Generate sprint summary
/sprint-summary "Sprint 42"

# Convert interview to PRD
/interview-to-prd docs/interview.md

# Generate user stories
/prd-to-stories docs/prd.md

# Create BDD test scenarios
/generate-gherkin 12345 cucumber
```

Or just talk naturally:

```bash
# Skills auto-activate based on context
> Create user stories for a login feature
> Implement using latest React patterns
> Generate Gherkin test scenarios
```

---

## 🔧 Configure MCPs (Optional but Recommended)

For full functionality with Azure DevOps and GitHub, configure MCPs:

### 1. Open Claude Desktop Config

```bash
open ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

### 2. Add MCP Servers

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

- **Azure DevOps PAT**: https://dev.azure.com/YOUR-ORG/_usersSettings/tokens
  - Required scopes: Work Items (Read, Write, & Manage), Code (Read), Project (Read)

- **GitHub PAT**: https://github.com/settings/tokens
  - Required scopes: repo (full control), workflow

### 4. Restart Claude Desktop

After adding MCPs:
- Press **Cmd+Q** to quit Claude Desktop
- Reopen Claude Desktop from Applications

---

## 📚 What You Get

### Commands (6)
- `/ship-story [id]` - Complete story implementation from ADO → Code → Tests → PR
- `/bug-fix [id]` - Bug fix with RCA documentation
- `/sprint-summary [sprint]` - Sprint metrics and reporting
- `/interview-to-prd [@file]` - Transform interviews into structured PRDs
- `/prd-to-stories [@file]` - Generate INVEST-compliant user stories
- `/generate-gherkin [id]` - Create BDD test scenarios (Cucumber/SpecFlow/Behave)

### Agents (3)
- **senior-developer** - Production code with tests
- **product-manager** - PRD and story creation
- **qa-specialist** - Test automation and BDD scenarios

### Skills (4)
- **story-generator** - INVEST-compliant stories (auto-activates)
- **context-aware-coding** - Latest library patterns via context7 (auto-activates)
- **ado-sync** - Azure DevOps synchronization (auto-activates)
- **gherkin-converter** - BDD scenario generation (auto-activates)

### Hooks (Event-Driven)
- Pre-commit validation (enforces work item links)
- Post-merge notifications (Slack/Teams)
- Session context injection (sprint goals, PRs)
- Intelligent decisions (when to update ADO, notify team)

---

## 🆘 Troubleshooting

### Plugin Not Found

If you get "plugin not found":

```bash
# Check marketplaces
/plugin marketplace list

# Make sure you added the marketplace
/plugin marketplace add adrianzartis/zdlc-plugin

# Try installing again
/plugin install zdlc@adrianzartis
```

### Commands Not Working

If commands don't work after installation:

1. **Restart Claude Code** - Close and reopen your terminal/IDE
2. **Check plugin is enabled**:
   ```bash
   /plugin list
   ```
3. **Try running a command**:
   ```bash
   /ship-story --help
   ```

### MCP Issues

If Azure DevOps or GitHub features don't work:

1. Verify MCPs are configured (see above)
2. Check tokens are correct and have proper scopes
3. Restart Claude Desktop (Cmd+Q, then reopen)
4. For GitHub MCP: Make sure Docker is running

---

## 📊 Time Savings

| Task | Traditional | With zDLC | Savings |
|------|-------------|-----------|---------|
| Feature Development | 22 hours | 2 hours | 91% |
| Bug Fix + RCA | 8 hours | 20 min | 96% |
| Sprint Summary | 2 hours | 5 min | 96% |
| PRD Creation | 4 hours | 5 min | 98% |
| Story Writing | 3 hours | 3 min | 98% |

---

## 🔗 Links

- **Repository**: https://github.com/adrianzartis/zdlc-plugin
- **Issues**: https://github.com/adrianzartis/zdlc-plugin/issues
- **Full Documentation**: https://github.com/adrianzartis/zdlc-plugin#readme

---

## 💡 Example Workflow

```bash
# Start Claude Code
claude

# Let's implement a feature end-to-end
> I need to implement Azure DevOps story AB#12345

# Claude will:
# ✅ Read story from ADO (using azure-devops MCP)
# ✅ Fetch current React/Next.js docs (using context7 MCP)
# ✅ Implement production code with tests (senior-developer agent)
# ✅ Create PR on GitHub (using github MCP)
# ✅ Update story status in ADO (ado-sync skill)
# ✅ Notify team on Slack (if configured)

# Result: Feature complete in 30 minutes (vs 22 hours)
```

---

**That's it! You're ready to automate your SDLC** 🚀

*zDLC - Transform your workflow. Ship faster. Build better.*
