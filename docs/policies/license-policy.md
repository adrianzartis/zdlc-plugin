# Zartis License Compliance Policy

**Last Updated:** 2025-01-18
**Maintained By:** Zartis Engineering
**Applies To:** All client projects and internal products

---

## Policy Summary

Zartis projects must only use dependencies with licenses that allow us to:
- Deliver code to clients as proprietary software
- Sell code as commercial products
- Maintain client's ability to use their codebase without restrictions

**Default stance:** If uncertain, ask legal or license-guardian agent.

---

## License Categories

### ✅ Auto-Approved (Safe for Commercial Use)

These licenses are **permissive** and place minimal restrictions on how the code is used:

| License | SPDX ID | Notes |
|---------|---------|-------|
| MIT License | MIT | Most permissive, widely used |
| Apache License 2.0 | Apache-2.0 | Includes explicit patent grant |
| BSD 2-Clause License | BSD-2-Clause | Simple permissive license |
| BSD 3-Clause License | BSD-3-Clause | Adds non-endorsement clause |
| ISC License | ISC | Similar to MIT, slightly simpler |
| CC0 1.0 Universal | CC0-1.0 | Public domain dedication |
| The Unlicense | Unlicense | Public domain |
| Zero-Clause BSD | 0BSD | Most permissive BSD variant |
| BlueOak License 1.0.0 | BlueOak-1.0.0 | Modern permissive license |
| Python Software Foundation | Python-2.0 | Python-specific permissive |

**Action:** Automatically approve and document in `docs/DEPENDENCY_LICENSES.md`

---

### ❌ Forbidden (Copyleft / Viral Licenses)

These licenses require **derivative works to be open-sourced** under the same license. Using these means clients cannot keep their code proprietary.

| License | SPDX ID | Why Forbidden |
|---------|---------|---------------|
| GNU General Public License v2.0 | GPL-2.0, GPL-2.0-only, GPL-2.0-or-later | Strong copyleft - entire program must be GPL |
| GNU General Public License v3.0 | GPL-3.0, GPL-3.0-only, GPL-3.0-or-later | Strong copyleft + anti-tivoization |
| GNU Affero General Public License v3.0 | AGPL-3.0, AGPL-3.0-only, AGPL-3.0-or-later | Network copyleft - even API usage triggers |
| Server Side Public License | SSPL | Extremely restrictive, like AGPL but worse |
| Open Software License 3.0 | OSL-3.0 | Copyleft variant |
| European Union Public License 1.2 | EUPL-1.2 | Copyleft license |

**Impact of using:**
- All code using the library must be released as open source
- Client cannot sell their software as proprietary
- Legal liability for Zartis

**Action:**
1. **Block immediately** - Do NOT use
2. Create GitHub/ADO issue with `[License Compliance]` tag
3. Find alternative with permissive license
4. If absolutely critical, escalate to legal team

---

### ⚠️ Requires Review (Weak Copyleft)

These licenses have **limited copyleft** requirements. May be acceptable depending on usage, but need case-by-case review.

#### Weak Copyleft (File/Library Level)

| License | SPDX ID | When Acceptable | When Problematic |
|---------|---------|-----------------|------------------|
| GNU Lesser GPL 2.1 | LGPL-2.1, LGPL-2.1-only, LGPL-2.1-or-later | Used as **unmodified** shared library (dynamically linked) | Modified or statically linked |
| GNU Lesser GPL 3.0 | LGPL-3.0, LGPL-3.0-only, LGPL-3.0-or-later | Used as **unmodified** shared library (dynamically linked) | Modified or statically linked |
| Mozilla Public License 2.0 | MPL-2.0 | Used as library, **not modified** | Files from library are modified |
| Eclipse Public License 1.0 | EPL-1.0 | Used as library, **not modified** | Modified or integrated deeply |
| Eclipse Public License 2.0 | EPL-2.0 | Used as library, **not modified** | Modified or integrated deeply |
| Common Public License 1.0 | CPL-1.0 | Used as library, **not modified** | Modified or integrated |

**Key Questions:**
1. Are we **modifying** the library's source code? (If yes → risky)
2. Are we **dynamically linking** vs statically linking? (Dynamic → safer)
3. Does the library remain a **separate component**? (If yes → safer)

**Action:**
1. Document usage in `docs/DEPENDENCY_LICENSES.md` (Requires Review section)
2. Get tech lead approval
3. Document in ADR if significant architectural dependency
4. Add to audit log with justification

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

**Safe to use without approval:**
✅ MIT, Apache-2.0, BSD-2/3-Clause, ISC, CC0, Unlicense

**Never use (copyleft):**
❌ GPL-2.0, GPL-3.0, AGPL-3.0, SSPL

**Use with caution (needs approval):**
⚠️ LGPL-2.1/3.0, MPL-2.0, EPL-1.0/2.0

**Requires purchase:**
💰 Commercial, Proprietary, Dual-licensed (GPL + Commercial)

**No license = forbidden:**
❌ Treat as "all rights reserved"

---

**Questions?** Consult the license-guardian agent or contact legal@zartis.com
