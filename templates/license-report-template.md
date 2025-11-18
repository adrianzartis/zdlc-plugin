# Dependency License Compliance Report

**Project:** [Project Name]
**Last Scanned:** [Date and Time]
**Compliance Status:** ✅ Compliant | ⚠️ Needs Review | ❌ Violations Found
**Total Dependencies:** [Count]
**Project Type:** [Node.js / Java Maven / .NET / Python / Go]
**Official Zartis OSS Guidelines:** https://docs.google.com/document/d/1Fzoh32EjHMyvXjOLDvQF_hdGrMn-AJ-RRLNgR_jT7vw/edit?tab=t.0

---

## ⚠️ IMPORTANT: Approval Requirements

**ALL dependencies require Engineering Director approval before use.**

**Zartisian Responsibility:**
- Request explicit written approval from client (for client projects) or Engineering Director (for Zartis-governed projects)
- Log all dependencies in client-specific tracking sheet (Google Drive)
- Track: Opensource Name, Version, Approval Date, Approver, Usage Start Date, Project Name, License Type, Compliance (Y/N), Last Review Date, Reason for Requiring the Software

**Tracking Sheet Columns:**
1. Opensource Name
2. Version
3. Approval Date
4. Approver
5. Usage Start Date
6. Project Name
7. License Type
8. Compliance (Y/N)
9. Last Review Date
10. Reason for Requiring the Software

---

## Summary

| Status | Count | Description |
|--------|-------|-------------|
| ✅ Low Risk (Permissive) | X | Requires ED approval before use |
| ⚠️ Specialized Review | X | Requires ED and legal review |
| ❌ Forbidden (Copyleft) | X | Contractual violation - DO NOT USE |
| 💰 Commercial | X | Requires purchase and ED approval |

---

## ✅ Low Risk Dependencies (Permissive - Require ED Approval)

**Status:** These dependencies are low risk but **REQUIRE Engineering Director approval before use** and must be logged in client tracking sheet.

| Opensource Name | Version | License Type | Reason for Requiring the Software | Usage Start Date | Compliance (Y/N) | Approval Status |
|-----------------|---------|--------------|-----------------------------------|------------------|------------------|-----------------|
| react | 18.2.0 | MIT | Core frontend framework for UI | [YYYY-MM-DD] | Pending | ⚠️ Awaiting ED approval |
| express | 4.18.2 | MIT | Backend web server framework | [YYYY-MM-DD] | Pending | ⚠️ Awaiting ED approval |
| lodash | 4.17.21 | MIT | Utility functions for data manipulation | [YYYY-MM-DD] | Pending | ⚠️ Awaiting ED approval |

---

## ⚠️ Dependencies Requiring Specialized Review

**Status:** These dependencies require case-by-case evaluation and **MUST be escalated to Engineering Director for legal review**.

| Opensource Name | Version | License Type | Reason for Requiring the Software | Usage Start Date | Compliance (Y/N) | Approval Status | Notes |
|-----------------|---------|--------------|-----------------------------------|------------------|------------------|-----------------|-------|
| example-lib | 2.1.0 | EPL-2.0 | [Purpose] | [YYYY-MM-DD] | Pending | ⚠️ Escalate to ED | Weak copyleft - legal review needed |

---

## ❌ FORBIDDEN Dependencies (Copyleft - CONTRACTUAL VIOLATION)

**CRITICAL:** These dependencies are **FORBIDDEN** and violate Zartis contractual obligations. **DO NOT USE** under any circumstances.

| Opensource Name | Version | License Type | Issue | Impact | Action Required |
|-----------------|---------|--------------|-------|--------|-----------------|
| gpl-package | 3.0.0 | GPL-3.0 | Strong copyleft | Forces proprietary code to be open-sourced | ❌ REMOVE IMMEDIATELY - Find alternative |
| lgpl-package | 2.1.5 | LGPL-2.1 | Copyleft | Violates Zartis policy | ❌ REMOVE IMMEDIATELY - Find alternative |

**Suggested Alternatives:**
| Forbidden Package | Alternative Package | License | Notes |
|-------------------|---------------------|---------|-------|
| gpl-package | alternative-lib | MIT | Similar features, requires ED approval |
| lgpl-package | another-option | Apache-2.0 | Better maintained, requires ED approval |

---

## 💰 Commercial Dependencies (Require Purchase)

**Status:** These dependencies require **purchased license AND Engineering Director approval**.

| Opensource Name | Version | License Type | Cost | Purchase Details | Approved By | Approval Date | Renewal Date | Reason for Requiring the Software |
|-----------------|---------|--------------|------|------------------|-------------|---------------|--------------|-----------------------------------|
| commercial-lib | 5.2.0 | Commercial | $999/year | Invoice #12345 | [Name] | [YYYY-MM-DD] | 2026-01-15 | [Purpose] |

---

## 🔒 Project-Specific Policy Overrides

[If customer has different license requirements, document here]

**Customer:** [Client Name]
**Policy Notes:** [Any special allowances or restrictions]
**Approved By:** [Name and Date]

Example:
```
Customer XYZ Corp has approved the use of LGPL-3.0 libraries as long as they are dynamically linked and not modified.
Approved by: Jane Doe (CTO, XYZ Corp) - 2025-01-10
```

---

## 🔍 Transitive Dependencies Checked

- [✅] Direct dependencies only
- [✅] Full dependency tree (all transitive)
- Depth scanned: [Number or "All levels"]

---

## ⚙️ Scan Configuration

- **Scan Tool:** Socket Security MCP / npm / mvn / dotnet / pip
- **License Detection:** Automated
- **False Positives:** [Any known detection issues]

---

## 📝 Audit Log

| Date | Action | User | Details |
|------|--------|------|---------|
| 2025-01-15 | Initial scan | license-guardian | Scanned 247 dependencies |
| 2025-01-16 | Added dependency | John Doe | Added `axios@1.6.0` (MIT) - Awaiting ED approval |
| 2025-01-17 | ED Approval received | Jane Smith (ED) | Approved `axios@1.6.0` - Logged in client tracking sheet |
| 2025-01-18 | Copyleft violation | license-guardian | Detected `gpl-package@3.0.0` (GPL-3.0) - BLOCKED |

---

## 📊 License Distribution

| License Type | Count | Percentage |
|--------------|-------|------------|
| MIT | 150 | 60.7% |
| Apache-2.0 | 70 | 28.3% |
| BSD-3-Clause | 20 | 8.1% |
| ISC | 5 | 2.0% |
| MPL-2.0 | 1 | 0.4% |
| GPL-3.0 | 1 | 0.4% |

---

## 🔗 Related Documentation

- **Official Zartis OSS Guidelines:** https://docs.google.com/document/d/1Fzoh32EjHMyvXjOLDvQF_hdGrMn-AJ-RRLNgR_jT7vw/edit?tab=t.0
- **License Policy:** [docs/policies/license-policy.md](../docs/policies/license-policy.md)
- **ADRs for license exceptions:** [docs/architecture/decisions/](../docs/architecture/decisions/)
- **Previous audit:** [docs/license-audit-YYYY-MM-DD.json](./license-audit-YYYY-MM-DD.json)
- **Client Tracking Sheet:** [Google Drive - Client Specific]

---

## 📋 Next Steps for Zartisian

1. **Request Approval:**
   - For client projects: Request written approval from client for all dependencies
   - For Zartis-governed projects: Request written approval from Engineering Director

2. **Log in Tracking Sheet:**
   - Open client-specific tracking sheet in Google Drive
   - Add all dependencies with required columns: Opensource Name, Version, Approval Date, Approver, Usage Start Date, Project Name, License Type, Compliance (Y/N), Last Review Date, Reason for Requiring the Software

3. **Remove Forbidden Dependencies:**
   - Immediately remove any copyleft/forbidden dependencies
   - Replace with approved alternatives

4. **Monitor for Updates:**
   - Set reminders for commercial license renewals
   - Re-scan dependencies when upgrading versions
