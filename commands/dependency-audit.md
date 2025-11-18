---
description: Perform comprehensive license compliance audit of all project dependencies
argument-hint: [optional: --deep for transitive deps]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, mcp__socket-security__*, mcp__azure-devops__*, mcp__github__*
model: claude-sonnet-4-5-20250929
---

# Dependency Audit - Full Project License Compliance Scan

Scan ALL dependencies in your project for license compliance, generate comprehensive report, and flag violations.

## What This Does

1. **Auto-detects project type** (Node.js, Java, .NET, Python, Go)
2. **Scans all dependencies** (direct + transitive)
3. **Checks every license** against Zartis compliance policy
4. **Generates compliance report** (`docs/DEPENDENCY_LICENSES.md`)
5. **Creates issues** for violations in ADO/GitHub
6. **Posts PR comment** if in PR context
7. **Provides summary** with action items

## Usage

### Basic Audit (Direct dependencies)
```
/dependency-audit
```

### Deep Audit (Include all transitive dependencies)
```
/dependency-audit --deep
```

### With custom instructions
```
/dependency-audit Generate report and create ADO issues for violations
```

## When to Run

**Run this command:**
- First time setting up license compliance on a project
- Before major releases or client deliveries
- Monthly/quarterly as part of compliance review
- After adding many new dependencies
- When joining a new project to understand license landscape

**Automatic triggers (via hooks):**
- When dependency files change (`package.json`, `pom.xml`, etc.)
- Before PR merge (as pre-merge check)
- In CI/CD pipeline (compliance gate)

## Output Example

```
🔍 Starting Dependency Audit...

📂 Detected Project Type: Node.js (package.json found)
📦 Scanning dependencies...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 AUDIT SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Dependencies: 247
├─ Direct: 23
└─ Transitive: 224

License Status:
✅ Approved (Safe):          243 (98.4%)
⚠️  Requires Review:           3 (1.2%)
❌ Non-Compliant (Forbidden):  1 (0.4%)
💰 Commercial:                 0 (0.0%)

Compliance Status: ❌ VIOLATIONS FOUND

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ CRITICAL: Non-Compliant Dependencies

1. gpl-package@3.0.0
   License: GPL-3.0 (Strong copyleft)
   Type: Direct dependency
   Used by: [root project]
   Issue: Requires all code to be open-sourced

   Action: Remove or replace immediately
   Alternatives:
   - alternative-package@2.1.0 (MIT)
   - other-lib@4.0.0 (Apache-2.0)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  Dependencies Requiring Review

1. mpl-library@2.1.0
   License: MPL-2.0 (Weak copyleft - file-level)
   Type: Direct dependency
   Used by: [root project]
   Note: Safe if used as library (not modified)

   Action: Verify usage and document approval

2. lgpl-component@1.5.0
   License: LGPL-2.1 (Weak copyleft - dynamic linking)
   Type: Transitive (via some-package@3.0.0)
   Note: Typically safe if dynamically linked

   Action: Review and document

3. custom-license-lib@1.0.0
   License: SEE LICENSE IN license.txt
   Type: Direct dependency
   Note: Custom license requires manual review

   Action: Review license.txt and document approval

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 Reports Generated:

✅ docs/DEPENDENCY_LICENSES.md (comprehensive report)
✅ docs/license-audit-2025-01-18.json (machine-readable)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎫 Issues Created:

#1234 [License Compliance] GPL-3.0 in gpl-package
#1235 [License Review] MPL-2.0 in mpl-library (needs approval)
#1236 [License Review] LGPL-2.1 in lgpl-component (needs approval)
#1237 [License Review] Custom license in custom-license-lib

View in Azure DevOps: [links]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚡ Action Items:

1. CRITICAL: Remove gpl-package@3.0.0 or find alternative
2. Review and approve mpl-library@2.1.0 usage
3. Review and approve lgpl-component@1.5.0 (transitive)
4. Review custom-license-lib license.txt and document

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Next Steps:

1. Address critical violations immediately
2. Review flagged dependencies with team/legal
3. Update docs/DEPENDENCY_LICENSES.md with approvals
4. Re-run audit after changes: /dependency-audit
5. Consider adding pre-commit hook for automatic checks

⚠️  WARNING: Do not deploy to production with non-compliant dependencies.
```

## Report Structure

### Main Report: docs/DEPENDENCY_LICENSES.md

Full markdown report with:
- Executive summary
- Compliance status
- Approved dependencies table
- Dependencies requiring review table
- Non-compliant dependencies table
- Commercial dependencies table
- Project-specific policy overrides
- Transitive dependency info
- Audit log

### Machine-Readable: docs/license-audit-[date].json

JSON format for CI/CD integration:
```json
{
  "timestamp": "2025-01-18T10:30:00Z",
  "projectType": "nodejs",
  "totalDependencies": 247,
  "directDependencies": 23,
  "transitiveDependencies": 224,
  "summary": {
    "approved": 243,
    "requiresReview": 3,
    "nonCompliant": 1,
    "commercial": 0
  },
  "violations": [
    {
      "package": "gpl-package",
      "version": "3.0.0",
      "license": "GPL-3.0",
      "type": "direct",
      "severity": "critical",
      "alternatives": ["alternative-package", "other-lib"]
    }
  ],
  "requiresReview": [...],
  "complianceStatus": "FAIL"
}
```

## Process

1. **Detect project type(s):**
   - Node.js: `package.json` + `package-lock.json`
   - Java Maven: `pom.xml`
   - Java Gradle: `build.gradle` / `build.gradle.kts`
   - .NET: `*.csproj` / `packages.config`
   - Python: `requirements.txt` / `Pipfile` / `pyproject.toml`
   - Go: `go.mod`
   - Multi-language: Detect all and scan each

2. **Check for existing compliance doc:**
   - Read `docs/DEPENDENCY_LICENSES.md` if exists
   - Compare with previous scan to detect changes
   - Identify new dependencies since last audit

3. **Extract dependencies:**
   - **Node.js:** Parse `package-lock.json` for full tree
   - **Maven:** Run `mvn dependency:tree` or parse resolved POMs
   - **Gradle:** Run `gradle dependencies`
   - **. NET:** Run `dotnet list package --include-transitive`
   - **Python:** Use `pip-licenses` or parse requirements
   - **Go:** Parse `go.mod` and use `go list -m all`

4. **Fetch license for each dependency:**
   - Use Socket Security MCP (preferred - comprehensive data)
   - Fall back to package registry APIs
   - Last resort: GitHub API / manual inspection

5. **Categorize licenses:**
   - ✅ Auto-approved: MIT, Apache-2.0, BSD, ISC, etc.
   - ❌ Forbidden: GPL, AGPL, SSPL
   - ⚠️ Review: LGPL, MPL, EPL, Commercial
   - ❓ Unknown: Can't detect

6. **Identify dependency chains:**
   - For transitive deps, show which direct dep pulled them in
   - Example: `lgpl-lib@1.0.0 (via package-a@2.0.0 → package-b@3.0.0)`

7. **Check for license changes:**
   - Compare with previous audit (if exists)
   - Flag packages where license changed between versions
   - Highlight risky changes (MIT → GPL)

8. **Generate reports:**
   - Create/update `docs/DEPENDENCY_LICENSES.md`
   - Create `docs/license-audit-[date].json` for automation
   - Include all tables, summaries, and audit trail

9. **Create issues for violations:**
   - One issue per non-compliant dependency
   - Priority: Critical (copyleft), High (needs review)
   - Assign to appropriate team/person
   - Include alternatives and action items

10. **Post PR comment (if in PR):**
    - Summarize findings
    - Link to full report
    - Block merge if violations found (if configured)

11. **Output summary to CLI:**
    - Counts and percentages
    - Critical issues highlighted
    - Action items listed
    - Links to reports and issues

## Project Type Handling

### Node.js
```bash
# Scan package.json and package-lock.json
npm list --all --json > npm-tree.json

# Or use Socket Security MCP
# Analyzes package.json for security + licenses
```

### Java (Maven)
```bash
# Get dependency tree with licenses
mvn dependency:tree
mvn license:aggregate-third-party-report

# Parse pom.xml for direct deps
```

### Java (Gradle)
```bash
# List all dependencies
./gradlew dependencies --configuration runtimeClasspath

# Use license plugin if available
./gradlew downloadLicenses
```

### .NET
```bash
# List all packages including transitive
dotnet list package --include-transitive --format json

# Parse .csproj for package references
```

### Python
```bash
# Install license checker
pip install pip-licenses

# Generate license report
pip-licenses --format=json --with-urls > licenses.json
```

### Go
```bash
# List all modules
go list -m -json all > modules.json

# Use go-licenses tool
go install github.com/google/go-licenses@latest
go-licenses csv ./... > licenses.csv
```

## Handling Multi-Language Projects

If project uses multiple package managers:
```
🔍 Multi-Language Project Detected

Found:
- Node.js (package.json)
- Python (requirements.txt)
- .NET (MyApp.csproj)

Running separate scans...

[Node.js Scan Results]
[Python Scan Results]
[.NET Scan Results]

Combined Summary:
Total Dependencies: 523
✅ Approved: 520
⚠️  Review: 2
❌ Non-Compliant: 1
```

## CI/CD Integration

Add to CI pipeline to block non-compliant dependencies:

### GitHub Actions
```yaml
- name: License Audit
  run: |
    # Run audit and check exit code
    claude-code /dependency-audit

    # Check compliance status
    if grep -q "FAIL" docs/license-audit-*.json; then
      echo "License compliance check failed"
      exit 1
    fi
```

### Azure Pipelines
```yaml
- task: Bash@3
  displayName: 'License Compliance Check'
  inputs:
    script: |
      claude-code /dependency-audit

      # Fail if non-compliant
      if [ -f docs/license-audit-*.json ]; then
        status=$(jq -r '.complianceStatus' docs/license-audit-*.json)
        if [ "$status" = "FAIL" ]; then
          echo "##vso[task.complete result=Failed;]License compliance failed"
        fi
      fi
```

## Advanced Options

### Deep Scan (All Transitive Dependencies)
```
/dependency-audit --deep
```
This scans the entire dependency tree, not just direct dependencies. Can be slower but more thorough.

### Generate Report Only (No Issues)
```
/dependency-audit Generate report but don't create ADO issues
```

### Custom Policy
If project has customer-specific overrides:
```
/dependency-audit Use customer policy from docs/LICENSE_POLICY.md
```

### Export to Different Format
```
/dependency-audit Export to CSV for spreadsheet analysis
```

## Incremental Audits

If `docs/DEPENDENCY_LICENSES.md` exists from previous audit:
```
📋 Previous audit found: 2025-01-10

Detecting changes since last audit...

New dependencies added (5):
✅ axios@1.6.7 (MIT)
✅ date-fns@2.30.0 (MIT)
⚠️  mpl-library@2.1.0 (MPL-2.0) - NEEDS REVIEW
❌ gpl-package@3.0.0 (GPL-3.0) - FORBIDDEN
✅ lodash@4.17.21 (MIT)

Updated dependencies (2):
- react: 18.2.0 → 18.3.0 (MIT → MIT) ✅
- some-lib: 1.0.0 → 2.0.0 (MIT → Apache-2.0) ⚠️  License changed

Removed dependencies (3):
- old-package@1.0.0 (MIT)
- deprecated-lib@2.0.0 (Apache-2.0)
- unused-tool@3.0.0 (BSD-3-Clause)

Focus on new/updated packages for review.
```

## Best Practices

1. **Run audit before major releases** - Catch issues early
2. **Add to CI/CD pipeline** - Prevent non-compliant deps from merging
3. **Review quarterly** - Licenses can change between versions
4. **Document approvals** - Maintain audit trail for weak-copyleft cases
5. **Keep report up-to-date** - Update after adding dependencies
6. **Train team** - Ensure everyone understands license implications

## Troubleshooting

### "Cannot detect license"
- Check package registry manually
- Look for LICENSE file in repo
- Contact maintainer
- If no license, don't use the package

### "Too many dependencies to scan"
- Use `--direct-only` flag for quick scan
- Run deep scan in CI/CD, not locally
- Consider reducing dependency count

### "Transitive dependency violation"
- Check if direct dependency has alternatives
- Contact maintainer about the transitive dep
- Fork and remove problematic transitive dep (if license allows)

## Related Commands

- `/check-license <package>` - Check single dependency before adding
- `/ship-story` - Automatically checks licenses during implementation

---

**Remember:** Regular audits protect Zartis and clients from legal risk. Make license compliance part of your development workflow.
