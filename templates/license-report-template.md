# Dependency License Compliance Report

**Project:** [Project Name]
**Last Scanned:** [Date and Time]
**Compliance Status:** ✅ Compliant | ⚠️ Needs Review | ❌ Violations Found
**Total Dependencies:** [Count]
**Project Type:** [Node.js / Java Maven / .NET / Python / Go]

---

## Summary

| Status | Count | Description |
|--------|-------|-------------|
| ✅ Approved | X | Safe for commercial use |
| ⚠️ Review Needed | X | Requires human approval |
| ❌ Non-Compliant | X | Copyleft or forbidden |
| 💰 Commercial | X | Requires payment |

---

## ✅ Approved Dependencies

| Dependency | Version | License | Approved Date | Notes |
|------------|---------|---------|---------------|-------|
| react | 18.2.0 | MIT | 2025-01-15 | Core framework |
| express | 4.18.2 | MIT | 2025-01-15 | Web server |
| lodash | 4.17.21 | MIT | 2025-01-15 | Utility library |

---

## ⚠️ Dependencies Requiring Review

| Dependency | Version | License | Issue | Justification | Approved By | Date |
|------------|---------|---------|-------|---------------|-------------|------|
| example-lib | 2.1.0 | MPL-2.0 | Weak copyleft | Used as library only, not modified | [Name] | [Date] |

---

## ❌ Non-Compliant Dependencies (Copyleft / Forbidden)

| Dependency | Version | License | Issue | Justification | Approved By | Date |
|------------|---------|---------|-------|---------------|-------------|------|
| gpl-package | 3.0.0 | GPL-3.0 | Strong copyleft | [WHY IS THIS NEEDED?] | [Name] | [Date] |

---

## 💰 Dependencies Requiring Payment

| Dependency | Version | License | Cost | Purchase Details | Approved By | Renewal Date |
|------------|---------|---------|------|------------------|-------------|--------------|
| commercial-lib | 5.2.0 | Commercial | $999/year | Invoice #12345 | [Name] | 2026-01-15 |

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
| 2025-01-16 | Added dependency | John Doe | Added `axios@1.6.0` (MIT) - auto-approved |
| 2025-01-17 | Review completed | Jane Smith | Approved `mpl-lib@2.0` (MPL-2.0) - See ADR-023 |

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

- License Policy: [docs/policies/license-policy.md](../docs/policies/license-policy.md)
- ADRs for license exceptions: [docs/architecture/decisions/](../docs/architecture/decisions/)
- Previous audit: [docs/license-audit-YYYY-MM-DD.json](./license-audit-YYYY-MM-DD.json)
