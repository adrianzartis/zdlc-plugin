# 📦 HOW TO INSTALL zDLC PLUGIN

**Complete step-by-step guide to install and use the zDLC plugin in Claude Code**

---

## ✅ Plugin is LIVE on GitHub!

**Repository**: https://github.com/adrianzartis/zdlc-plugin

---

## 🚀 Installation Methods

### Method 1: Install from GitHub (Recommended - Easiest)

**This is the simplest method - one command to install:**

```bash
claude plugin install zdlc@github.com/adrianzartis/zdlc-plugin
```

That's it! The plugin will be downloaded and installed automatically.

### Method 2: Install Locally (For Development/Testing)

**From the plugin directory:**

```bash
cd /Users/adriandelasierra/Desktop/agents/ux-agent/zdlc-plugin
claude plugin install .
```

**From anywhere (using absolute path):**

```bash
claude plugin install /Users/adriandelasierra/Desktop/agents/ux-agent/zdlc-plugin
```

### Method 3: Manual Copy (If claude plugin install doesn't work)

```bash
# Create plugins directory if it doesn't exist
mkdir -p ~/.claude/plugins

# Copy plugin to Claude Code plugins directory
cp -r /Users/adriandelasierra/Desktop/agents/ux-agent/zdlc-plugin ~/.claude/plugins/zdlc

# Verify it's there
ls -la ~/.claude/plugins/zdlc
```

---

## 🔧 Step-by-Step Installation

### Step 1: Install Claude Code

If you don't have Claude Code installed:

```bash
# Check if installed
which claude

# If not installed, install it:
# Visit: https://claude.ai/download
# Or install via npm:
npm install -g @anthropic-ai/claude-cli
```

### Step 2: Configure Required MCPs

**IMPORTANT**: Before installing the plugin, you need to configure the required MCPs in Claude Desktop.

**Edit your Claude Desktop config file:**

```bash
# Open Claude Desktop config
open ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Add the required MCPs:**

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "npx",
      "args": ["-y", "@azure-devops/mcp", "your-organization-name"],
      "env": {
        "AZURE_DEVOPS_PAT": "your-personal-access-token"
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
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your-github-token"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

**Get Your Credentials:**

1. **Azure DevOps PAT**: https://dev.azure.com/your-org/_usersSettings/tokens
   - Scopes: Work Items (Read, Write, & Manage), Code (Read), Project and Team (Read)

2. **GitHub PAT**: https://github.com/settings/tokens
   - Scopes: repo (full control), workflow

3. **context7**: No credentials needed for basic use

**Restart Claude Desktop** after updating the config (Cmd+Q then reopen).

### Step 3: Install the zDLC Plugin

**Choose your preferred method:**

```bash
# Method 1: From GitHub (recommended)
claude plugin install zdlc@github.com/adrianzartis/zdlc-plugin

# Method 2: From local directory
claude plugin install /Users/adriandelasierra/Desktop/agents/ux-agent/zdlc-plugin

# Method 3: Manual copy
cp -r /Users/adriandelasierra/Desktop/agents/ux-agent/zdlc-plugin ~/.claude/plugins/zdlc
```

### Step 4: Restart Claude Desktop

**IMPORTANT**: After installing the plugin, you MUST restart Claude Desktop completely.

```bash
# On Mac:
# 1. Click on Claude Desktop in menu bar
# 2. Select "Quit Claude Desktop" (or press Cmd+Q)
# 3. Reopen Claude Desktop from Applications

# On Linux/Windows:
# Completely close and reopen Claude Desktop
```

### Step 5: Verify Installation

**Check that the plugin is installed:**

```bash
claude --list-plugins
```

**Expected output:**
```
zdlc (v1.0.0) - AI-Powered SDLC Automation
```

**If you see this, the plugin is successfully installed! 🎉**

---

## 🎯 How to USE the Plugin

### Using Commands

Commands are user-invoked workflows that start with `/`.

**Start Claude Code:**

```bash
claude
```

**Try the commands:**

```bash
# Get help for a command
/ship-story --help

# Implement a story from Azure DevOps
/ship-story 12345

# Fix a bug
/bug-fix 67890

# Generate sprint summary
/sprint-summary "Sprint 42"

# Convert interview to PRD
/interview-to-prd docs/interview.md

# Generate user stories from PRD
/prd-to-stories docs/prd.md

# Generate Gherkin test scenarios
/generate-gherkin 12345 cucumber
```

### Skills Auto-Activate

**Skills are automatically invoked by Claude when relevant.**

You don't need to do anything - just talk naturally:

```bash
claude

# This will auto-activate the story-generator skill:
> I need to create user stories for an order filtering feature

# This will auto-activate context-aware-coding skill:
> Implement a React component using the latest Next.js patterns

# This will auto-activate gherkin-converter skill:
> I need BDD test scenarios for this feature

# This will auto-activate ado-sync skill:
> Push these changes to Azure DevOps work item 12345
```

### Agents Are Invoked Automatically

**Agents are specialized sub-agents that Claude invokes when needed.**

```bash
# Claude will invoke the senior-developer agent:
> Implement production-ready code for story AB#12345

# Claude will invoke the product-manager agent:
> Create a PRD from this interview transcript

# Claude will invoke the qa-specialist agent:
> Generate comprehensive test scenarios for this feature
```

### Hooks Run Automatically

**Hooks are event-driven and run automatically:**

- **Pre-commit hook**: Validates work item links before commit
- **Post-merge hook**: Sends Slack notification after PR merge
- **Session start hook**: Shows sprint context when you start Claude
- **Stop hook**: AI decides if ADO should be updated when you end session

You don't need to trigger these - they just work!

---

## 💡 Real-World Usage Examples

### Example 1: Implement a Feature End-to-End

```bash
# Start Claude Code
claude

# Just tell Claude what you want to do:
> I need to implement Azure DevOps story AB#12345

# Claude will:
# 1. Read the story from ADO (using azure-devops MCP)
# 2. Fetch current React/Next.js docs (using context7 MCP)
# 3. Implement the feature with tests (using senior-developer agent)
# 4. Create a PR (using github MCP)
# 5. Update ADO status (using ado-sync skill)
# 6. Notify team on Slack (using slack MCP, if configured)

# Or use the command directly:
> /ship-story 12345
```

### Example 2: Process User Interview

```bash
# You have interview notes in a file:
> I have interview notes in docs/sarah-interview.md

# Claude will:
# 1. Read the file (using Read tool)
# 2. Analyze the interview (using product-manager agent)
# 3. Create a structured PRD (using story-generator skill)
# 4. Generate user stories (INVEST-compliant)
# 5. Ask if you want to push to ADO

> Yes, push to ADO project "ECommerce"

# Claude pushes all stories to Azure DevOps
```

### Example 3: Fix a Bug

```bash
> /bug-fix 67890

# Claude will:
# 1. Read bug from ADO
# 2. Analyze code and find root cause
# 3. Implement fix with tests
# 4. Create PR
# 5. Create RCA documentation
# 6. Notify team
# 7. Update bug status
```

### Example 4: Generate Gherkin Tests

```bash
> /generate-gherkin 12345 cucumber

# Claude will:
# 1. Read story from ADO
# 2. Generate .feature file with scenarios
# 3. Create step definitions (if requested)
# 4. Save to features/ directory
```

---

## 🔍 Verifying It's Working

### Check 1: Commands Available

```bash
claude

# Try tab completion:
> /ship<TAB>

# Should show:
# /ship-story
```

### Check 2: Skills Loaded

```bash
# Check if skills are loaded
ls -la ~/.claude/plugins/zdlc/skills/

# Should show:
# story-generator/
# context-aware-coding/
# ado-sync/
# gherkin-converter/
```

### Check 3: Test a Command

```bash
> /ship-story --help

# Should show usage information
```

### Check 4: MCPs Connected

```bash
# Start Claude Code and try:
> List my Azure DevOps work items

# If this works, your MCPs are connected!
```

---

## 🐛 Troubleshooting

### Problem: "Command /ship-story not found"

**Solution**: Plugin not loaded. Check installation:

```bash
# Verify plugin is installed
claude --list-plugins

# If not shown, reinstall:
claude plugin install zdlc@github.com/adrianzartis/zdlc-plugin

# Restart Claude Desktop completely (Cmd+Q)
```

### Problem: "MCP azure-devops not available"

**Solution**: MCPs not configured. Edit Claude Desktop config:

```bash
open ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Add MCP configuration (see Step 2 above)
# Restart Claude Desktop
```

### Problem: "Permission denied" when running hooks

**Solution**: Make hook scripts executable:

```bash
chmod +x ~/.claude/plugins/zdlc/hooks/scripts/*.sh
```

### Problem: Skills not activating

**Solution**: Skills activate automatically based on keywords. Try:

```bash
> I need to create user stories (triggers story-generator)
> Implement using latest React patterns (triggers context-aware-coding)
> Generate Gherkin scenarios (triggers gherkin-converter)
```

### Problem: Plugin installed but not showing in list

**Solution**: Check plugin directory and structure:

```bash
# Check if plugin directory exists
ls -la ~/.claude/plugins/zdlc/

# Should contain:
# .claude-plugin/plugin.json
# commands/
# skills/
# agents/
# hooks/

# If missing, reinstall
```

---

## 📋 Complete Installation Checklist

- [ ] Claude Code installed (`which claude` shows path)
- [ ] Claude Desktop running
- [ ] MCPs configured in `claude_desktop_config.json`
  - [ ] azure-devops MCP with PAT
  - [ ] github MCP with PAT
  - [ ] context7 MCP (no token needed)
- [ ] Claude Desktop restarted after MCP config
- [ ] Plugin installed (`claude plugin install zdlc@github.com/adrianzartis/zdlc-plugin`)
- [ ] Claude Desktop restarted after plugin install
- [ ] Verified with `claude --list-plugins` (shows zdlc v1.0.0)
- [ ] Tested with `/ship-story --help` (shows usage)
- [ ] Azure DevOps connection works (can list work items)
- [ ] GitHub connection works (can list repos)

**If all checked, you're ready to use zDLC! 🚀**

---

## 🎓 Learning the Plugin

### Start Simple

1. **Try a command:**
   ```bash
   /ship-story --help
   ```

2. **Let skills activate automatically:**
   ```bash
   > Create user stories for a login feature
   ```

3. **Explore workflows:**
   ```bash
   > Show me how to implement a story from Azure DevOps
   ```

### Read the Docs

- **README.md**: Feature overview
- **INSTALL-AND-SHARE.md**: Distribution guide
- **docs/SETUP.md**: Detailed configuration

### Join the Community

- **GitHub Issues**: Report bugs or request features
- **GitHub Discussions**: Ask questions and share workflows

---

## 🚀 You're Ready!

The plugin is now installed and ready to use. Just start Claude Code and try:

```bash
claude

> /ship-story 12345
```

Or simply:

```bash
> I need to implement Azure DevOps story 12345
```

**Claude will handle the rest automatically!**

---

## 📞 Need Help?

- **Documentation**: See README.md and docs/
- **Issues**: https://github.com/adrianzartis/zdlc-plugin/issues
- **Email**: adrian@zartis.com

---

**Happy shipping! 🚀**

*zDLC - Transform your SDLC. Ship faster. Build better.*
