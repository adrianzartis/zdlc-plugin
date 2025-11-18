# Zartis License Compliance Policy

**Last Updated:** 2025-01-18
**Maintained By:** Zartis Engineering
**Applies To:** All client projects and internal products
**Official Zartis OSS Guidelines:** https://docs.google.com/document/d/1Fzoh32EjHMyvXjOLDvQF_hdGrMn-AJ-RRLNgR_jT7vw/edit?tab=t.0

---

## Policy Summary

**CRITICAL:** Following these open-source guidelines is a **contractual obligation** towards clients. Any unauthorized or improper license usage is in **direct violation of contractual obligations** from the Zartisian towards Zartis.

Zartis projects must only use dependencies with licenses that allow us to:
- Deliver code to clients as proprietary software
- Sell code as commercial products
- Maintain client's ability to use their codebase without restrictions
- Prevent exposing clients to unforeseen licensing costs or obligation to open-source proprietary code

**Approval Required:** ALL open-source software requires explicit written approval from:
1. **The client first and foremost** (for client projects)
2. **Engineering Director** (for Zartis-governed projects: fixed-scope, internal, isolated team projects)

**Zartisian Responsibility:** It is solely the Zartisian's responsibility to request and obtain approval, and to log all open-source software in the designated client-specific tracking sheet (Google Drive).

**Default stance:** If uncertain, ask Engineering Director or license-guardian agent.

---

## License Categories

### ✅ Low Risk - Permissive Licenses (Require ED Approval)

These licenses are **permissive** and place minimal restrictions on how the code is used. However, **Engineering Director approval is still mandatory** before use.

| License | SPDX ID | Risk Level | Notes |
|---------|---------|------------|-------|
| MIT License | MIT | Low | Most permissive, widely used |
| Apache License 2.0 | Apache-2.0 | Low | Includes explicit patent grant |
| BSD 2-Clause License | BSD-2-Clause | Low | Simple permissive license |
| BSD 3-Clause License | BSD-3-Clause | Low | Adds non-endorsement clause |
| ISC License | ISC | Low | Similar to MIT, slightly simpler |
| CC0 1.0 Universal | CC0-1.0 | Low | Public domain dedication |
| The Unlicense | Unlicense | Low | Public domain |
| Zero-Clause BSD | 0BSD | Low | Most permissive BSD variant |
| Mozilla Public License 2.0 | MPL-2.0 | Low | Permissive (per Zartis guidelines) |
| BlueOak License 1.0.0 | BlueOak-1.0.0 | Low | Modern permissive license |
| Python Software Foundation | Python-2.0 | Low | Python-specific permissive |

**Action:**
1. Document in `docs/DEPENDENCY_LICENSES.md` with required tracking fields
2. Notify user that Engineering Director approval is required
3. User must log in client-specific tracking sheet (Google Drive)

---

### ❌ Forbidden (Copyleft / Viral Licenses) - CONTRACTUAL VIOLATION

These licenses require **derivative works to be open-sourced** under the same license. Using these means clients cannot keep their code proprietary and **violates Zartis contractual obligations**.

| License | SPDX ID | Risk Level | Why Forbidden |
|---------|---------|------------|---------------|
| GNU General Public License v2.0 | GPL-2.0, GPL-2.0-only, GPL-2.0-or-later | Not Allowed | Strong copyleft - entire program must be GPL |
| GNU General Public License v3.0 | GPL-3.0, GPL-3.0-only, GPL-3.0-or-later | Not Allowed | Strong copyleft + anti-tivoization |
| GNU Lesser General Public License v2.1 | LGPL-2.1, LGPL-2.1-only, LGPL-2.1-or-later | Not Allowed | Copyleft (per Zartis guidelines) |
| GNU Lesser General Public License v3.0 | LGPL-3.0, LGPL-3.0-only, LGPL-3.0-or-later | Not Allowed | Copyleft (per Zartis guidelines) |
| GNU Affero General Public License v3.0 | AGPL-3.0, AGPL-3.0-only, AGPL-3.0-or-later | Not Allowed | Network copyleft - even API usage triggers |
| Server Side Public License | SSPL | Not Allowed | Extremely restrictive, like AGPL but worse |
| Open Software License 3.0 | OSL-3.0 | Not Allowed | Copyleft variant |
| European Union Public License 1.2 | EUPL-1.2 | Not Allowed | Copyleft license |

**Impact of using:**
- **Contractual violation** - Direct breach of Zartis obligations to client
- All code using the library must be released as open source
- Client cannot sell their software as proprietary
- Exposes client to unforeseen licensing costs
- Legal liability for Zartis and Zartisian

**Action:**
1. **BLOCK IMMEDIATELY** - Do NOT use under any circumstances
2. Create GitHub/ADO issue with `[License Compliance - CONTRACTUAL VIOLATION]` tag
3. Find alternative with permissive (low risk) license
4. If absolutely critical, escalate to Engineering Director and legal team

---

### ⚠️ Requires Specialized Review

These licenses require **case-by-case evaluation** and escalation to Engineering Director.

| License | SPDX ID | Risk Level | Notes |
|---------|---------|------------|-------|
| Eclipse Public License 1.0 | EPL-1.0 | Requires Review | Weak copyleft - needs legal evaluation |
| Eclipse Public License 2.0 | EPL-2.0 | Requires Review | Weak copyleft - needs legal evaluation |
| Common Public License 1.0 | CPL-1.0 | Requires Review | Weak copyleft - needs legal evaluation |

**Action:**
1. Document usage in `docs/DEPENDENCY_LICENSES.md` (Requires Review section)
2. **Escalate to Engineering Director** for legal review
3. Document in ADR if significant architectural dependency
4. Add to audit log with justification and approval details

---

### 💰 Commercial / Proprietary Licenses

Some packages require **purchasing a license** for commercial use.

**Examples:**
- Dual-licensed packages (GPL + Commercial option)
- Proprietary SDKs from vendors
- "Free for non-commercial use" packages

**Action:**
1. **Verify purchase** - Has Zartis or client purchased license?
2. **Check terms:**
   - Development vs production licenses
   - Per-seat, per-server, or site license?
   - Time-limited or perpetual?
   - Renewal date?
3. **Document in `docs/DEPENDENCY_LICENSES.md`** (Commercial section):
   - Invoice/purchase order number
   - Approved by (name + date)
   - License terms summary
   - Renewal date (if applicable)
4. **Set reminder** for license renewal

---

### ❓ Unknown / Custom Licenses

Some packages have **no license** or **custom licenses**.

**Important:** If no license is specified, legally the code is **"all rights reserved"** - you have NO permission to use it.

**Action:**
1. **Check package repository** for LICENSE file
2. **Contact maintainer** if unclear
3. **If no license found** → Do NOT use (same as forbidden)
4. **If custom license** → Send to legal team for review
5. Document findings and decision

---

## Dual-Licensed Packages

Some packages offer **multiple license options** (e.g., GPL OR Commercial).

**Example:** MongoDB driver (SSPL OR Commercial)

**Action:**
1. **Identify available licenses**
2. **Choose permissive option** if available
3. **If only copyleft + commercial:**
   - Verify if Zartis/client has commercial license
   - If not, find alternative package
4. **Document chosen license** in compliance report

---

## Transitive Dependencies

Dependencies of your dependencies can have different licenses.

**Risk:** A safe package (MIT) might depend on a GPL package, pulling copyleft into your project.

**Action:**
1. **Scan full dependency tree** (use `--deep` flag in `/dependency-audit`)
2. **Flag transitive violations** just like direct dependencies
3. **Options if found:**
   - Find alternative to the direct dependency
   - Contact maintainer about the transitive dep
   - Fork and remove problematic transitive dep (if license allows)

---

## License Changes Between Versions

Packages can **change licenses** between versions (e.g., v1.0 was MIT, v2.0 is GPL).

**Action:**
1. **Detect changes** during audits
2. **Flag risky changes** (permissive → copyleft)
3. **Options:**
   - Stay on older version with safe license
   - Find alternative package
   - Get legal approval if upgrade is critical

---

## Project-Specific Policy Overrides

Some clients may have **different requirements:**

**More Restrictive:**
- "No LGPL at all" (some clients don't want any copyleft)
- "Apache-2.0 only" (patent concerns)
- "No GPL, LGPL, or MPL"

**Less Restrictive:**
- "LGPL okay if dynamically linked"
- "Customer has purchased commercial license for X"

**Action:**
1. **Document in `docs/DEPENDENCY_LICENSES.md`** (Policy Overrides section)
2. **Include:**
   - Customer name
   - Policy variation
   - Approval by (name, role, date)
   - Supporting documentation (email, contract clause)
3. **Configure license-guardian** to use custom policy

---

## Enforcement

### Pre-Commit / Pre-PR
- Run `/dependency-audit` before creating PR
- Automated hooks can trigger on `package.json` changes
- CI/CD pipeline should include license check

### Monthly/Quarterly Audits
- Full dependency audit on all active projects
- Review and renew commercial licenses
- Update compliance documentation

### On Dependency Addition
- **Developer:** Must consult `/check-license` before adding
- **Senior-developer agent:** Auto-consults license-guardian
- **License-guardian:** Auto-approves or blocks

---

## Escalation Process

### Forbidden License Found
1. **Immediate:** Block PR, create issue
2. **Developer:** Find alternative within 1 business day
3. **If critical:** Escalate to tech lead within 1 day
4. **If no alternative:** Legal review required

### Weak Copyleft (Requires Review)
1. **Developer:** Document usage and justification
2. **Tech Lead:** Review and approve/reject within 2 business days
3. **Document:** Add to ADR if architecturally significant

### Commercial License Needed
1. **Check:** Has license been purchased?
2. **If no:** Request purchase approval from project manager
3. **If yes:** Document purchase details
4. **Monitor:** Set renewal reminders

---

## Resources

- **License Compatibility Chart:** https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
- **SPDX License List:** https://spdx.org/licenses/
- **Choose a License:** https://choosealicense.com/
- **TL;DR Legal:** https://tldrlegal.com/

---

## Quick Reference

**Low Risk (Permissive - Requires ED Approval):**
✅ MIT, Apache-2.0, BSD-2/3-Clause, ISC, CC0, Unlicense, MPL-2.0

**Never use (Copyleft - Contractual Violation):**
❌ GPL-2.0/3.0, AGPL-3.0, LGPL-2.1/3.0, SSPL, OSL-3.0, EUPL-1.2

**Requires specialized review (Escalate to ED):**
⚠️ EPL-1.0/2.0, CPL-1.0

**Requires purchase:**
💰 Commercial, Proprietary, Dual-licensed (GPL + Commercial)

**No license = forbidden:**
❌ Treat as "all rights reserved"

---

**Official Zartis OSS Guidelines:** https://docs.google.com/document/d/1Fzoh32EjHMyvXjOLDvQF_hdGrMn-AJ-RRLNgR_jT7vw/edit?tab=t.0
**Questions?** Consult the license-guardian agent or contact Engineering Director
