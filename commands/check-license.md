---
description: Check if a specific dependency's license is compliant with Zartis licensing requirements
argument-hint: [package-name] or [package-name@version]
allowed-tools: Read, Write, Bash, mcp__socket-security__*, mcp__github__*
model: claude-sonnet-4-5-20250929
---

# Check License - Single Dependency Validation

Verify that a specific package/dependency has an approved license before adding it to your project.

## What This Does

1. **Identifies package and version** from input
2. **Fetches license information** from package registries or Socket Security MCP
3. **Checks compliance** against Zartis licensing policy
4. **Scans transitive dependencies** for license issues
5. **Provides recommendation** (approve, reject, or needs review)
6. **Updates compliance doc** (`docs/DEPENDENCY_LICENSES.md`)
7. **Suggests alternatives** if license is non-compliant

## Usage

### Node.js / npm
```
/check-license axios
/check-license axios@1.6.7
```

### Java Maven
```
/check-license org.springframework.boot:spring-boot-starter-web:3.2.0
/check-license org.springframework.boot:spring-boot-starter-web
```

### .NET NuGet
```
/check-license Newtonsoft.Json
/check-license Newtonsoft.Json -Version 13.0.3
```

### Python PyPI
```
/check-license requests
/check-license requests==2.31.0
```

### Go
```
/check-license github.com/gorilla/mux
/check-license github.com/gorilla/mux@v1.8.0
```

## Output Examples

### ✅ Approved (Safe)
```
📦 Checking: axios@1.6.7

✅ APPROVED - Safe for commercial use

License: MIT
Type: Permissive
SPDX: MIT

Transitive Dependencies: 3
├── follow-redirects@1.15.3 (MIT) ✅
├── form-data@4.0.0 (MIT) ✅
└── proxy-from-env@1.1.0 (MIT) ✅

All dependencies compliant.

✅ This package can be added to your project.

Documentation updated: docs/DEPENDENCY_LICENSES.md
```

### ❌ Forbidden (Copyleft)
```
📦 Checking: gpl-package@3.0.0

❌ FORBIDDEN - Copyleft license

License: GPL-3.0
Type: Strong copyleft (viral)
Issue: Requires derived works to be open-sourced

⚠️ Using this package means:
- All code using it must be GPL-3.0
- Cannot deliver to clients as proprietary software
- Cannot sell as commercial product

❌ DO NOT ADD this package to your project.

Recommended Alternatives (MIT licensed):
1. alternative-lib@2.1.0 - Similar features, actively maintained
   npm install alternative-lib
   GitHub: https://github.com/example/alternative-lib

2. another-option@5.0.0 - More features, larger community
   npm install another-option
   GitHub: https://github.com/example/another-option

Need to proceed anyway? Document justification in:
docs/DEPENDENCY_LICENSES.md (Non-Compliant section)

Issue created: #1234 [License Compliance] GPL-3.0 in gpl-package
```

### ⚠️ Needs Review (Weak Copyleft / Commercial)
```
📦 Checking: mpl-library@2.1.0

⚠️ REQUIRES REVIEW - Weak copyleft license

License: MPL-2.0 (Mozilla Public License 2.0)
Type: Weak copyleft (file-level)

What this means:
- File-level copyleft (not whole-project)
- Can be used in commercial software
- If you MODIFY MPL-2.0 files, those modifications must be open-sourced
- If you only USE the library (don't modify), generally safe

Recommendation:
✅ Safe to use if: You don't modify the library's source code
❌ Risky if: You plan to fork or modify the library

Common use case: Using as-is via npm/Maven (safe)

Action Required:
1. Confirm you won't modify library source
2. Document approval in docs/DEPENDENCY_LICENSES.md
3. Get tech lead sign-off

Proceed? (Requires human approval and justification)
```

### 💰 Commercial License
```
📦 Checking: commercial-sdk@5.2.0

💰 COMMERCIAL LICENSE - Payment Required

License: Commercial / Proprietary
Cost: Unknown (check vendor website)
Vendor: Example Corp

⚠️ This package requires purchasing a license.

Questions to answer:
1. Has Zartis/Client purchased a license?
2. Does license cover development + production?
3. What are the terms (seats, servers, time-limited)?
4. Is there a renewal date?

Action Required:
- Verify license has been purchased
- Document purchase details in docs/DEPENDENCY_LICENSES.md
- Include: Invoice number, approved by, renewal date
- Link to license agreement

Cannot proceed without valid commercial license.
```

### ❓ Unknown License
```
📦 Checking: unknown-package@1.0.0

❓ UNKNOWN LICENSE - Cannot verify

License: Not detected
Repository: https://github.com/example/unknown-package

⚠️ Unable to determine license automatically.

Manual verification required:
1. Check package repository: [link]
2. Look for LICENSE, LICENSE.txt, or COPYING file
3. Check package.json or README for license field
4. Contact package maintainer if unclear

⚠️ WARNING: If no license is specified, the code is legally "all rights reserved"
This means: NO permission to use, modify, or distribute

❌ DO NOT USE packages without a clear license.

Recommendation: Find an alternative with a clear, approved license.
```

## Process

1. **Parse package identifier:**
   - Extract package name and version (if specified)
   - Detect package ecosystem from format
   - If version not specified, check latest version

2. **Fetch license data:**
   - Try Socket Security MCP first (comprehensive data)
   - Fall back to package registry API (npm, Maven Central, NuGet, PyPI)
   - Last resort: GitHub API to inspect LICENSE file

3. **Identify license type:**
   - Normalize to SPDX identifier (e.g., "MIT", "Apache-2.0")
   - Handle multiple licenses (dual-licensed packages)
   - Detect custom licenses

4. **Check compliance:**
   - Compare against Zartis approved license list
   - Flag copyleft (GPL, AGPL, SSPL)
   - Flag weak copyleft (LGPL, MPL, EPL) as "needs review"
   - Flag commercial/proprietary licenses
   - Flag unknown licenses

5. **Scan transitive dependencies:**
   - Get full dependency tree (if possible)
   - Check license of each transitive dependency
   - Flag if safe package has unsafe transitive deps

6. **Generate recommendation:**
   - ✅ Auto-approve: MIT, Apache-2.0, BSD, ISC, etc.
   - ❌ Reject: GPL, AGPL, SSPL
   - ⚠️ Review: LGPL, MPL, EPL, Commercial
   - ❓ Unknown: Can't detect license

7. **Suggest alternatives (if rejected):**
   - Search for similar packages with approved licenses
   - Use Socket Security or npm search
   - Provide installation commands

8. **Update documentation:**
   - Add to `docs/DEPENDENCY_LICENSES.md`
   - Create GitHub/ADO issue if non-compliant
   - Log in audit trail

## License Compliance Policy

See `license-guardian` agent for full policy details.

**Quick Reference:**

✅ **Approved:** MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC, CC0-1.0, Unlicense

❌ **Forbidden:** GPL-2.0, GPL-3.0, AGPL-3.0, SSPL, OSL-3.0, EUPL-1.2

⚠️ **Review Required:** LGPL-2.1, LGPL-3.0, MPL-2.0, EPL-1.0/2.0, Commercial, Proprietary

## Integration with Senior Developer

This command is automatically invoked by the `senior-developer` agent before adding dependencies.

**Manual usage** when:
- Evaluating package before adding
- Checking license of existing dependency
- Verifying compliance before upgrade

## Tips

- Always check license BEFORE adding dependency
- If latest version is non-compliant, try an older version
- For dual-licensed packages (GPL + Commercial), commercial option may be available
- When in doubt, choose packages with MIT or Apache-2.0 licenses
- Avoid packages with no license specified

## Advanced Options

Check multiple packages at once:
```
/check-license axios lodash react express
```

Specify version explicitly:
```
/check-license axios@1.6.7
```

Check against custom policy (if project has overrides):
```
/check-license some-package Use customer-specific policy from docs/LICENSE_POLICY.md
```

## Related Commands

- `/dependency-audit` - Scan entire project for license compliance
- `/ship-story` - Automatically checks licenses when dependency files change

---

**Remember:** License compliance protects Zartis and clients from legal risk. When in doubt, consult the license-guardian agent or legal team.
