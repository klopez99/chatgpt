# Kinnser Nursing Charting & Workflow Agent Specification

## 1. Context

WellSky Home Health & Hospice is commonly accessed through `kinnser.net`. Public login pages identify the service as WellSky HHH and list separate home-health and hospice support channels. WellSky also describes Kinnser Link as an encrypted offline documentation tool that loads scheduled clinical documents and later sends completed documents back online.

Because nursing documentation involves Protected Health Information, clinical judgment, regulatory requirements, and potentially billable records, this assistant should be designed as a clinician-controlled copilot rather than an autonomous EMR bot.

## 2. Primary users

- Field RN/LPN/LVN documenting home-health or hospice visits.
- Clinical manager or QA reviewer checking completeness before submission.
- Agency administrator configuring templates, retention rules, and allowed workflows.

## 3. Core principles

1. **Clinician remains author of record.** The agent drafts and organizes; the licensed user verifies, edits, and approves.
2. **Minimum necessary PHI.** Collect only what is required for the immediate documentation task.
3. **Evidence-linked drafts.** Every clinical statement should map back to nurse-provided input or approved agency templates.
4. **No silent EMR submission.** Browser assistance may paste reviewed text, but signing/submission remains manual.
5. **Configurable agency policy.** The system should support agency-specific charting rules, abbreviations, QA checks, and retention settings.

## 4. Version 1 scope

### 4.1 Inputs

The initial release should accept nurse-entered or dictated text in a structured encounter form:

- Visit type and date.
- Patient initials or agency-approved non-identifying alias.
- Subjective report.
- Objective findings and vitals.
- Interventions performed.
- Medication changes or concerns.
- Wound measurements and treatment, if applicable.
- Teaching provided and patient/caregiver response.
- Care coordination performed or needed.
- Supplies, orders, labs, DME, or referrals needed.
- Nurse concerns and follow-up plan.

### 4.2 Outputs

The agent should produce editable drafts for:

- Skilled nursing visit narrative.
- Problem-focused assessment summary.
- Interventions and response-to-care paragraph.
- Patient/caregiver education paragraph.
- Medication issue summary.
- Care coordination note.
- Follow-up task checklist.
- QA completeness checklist.

### 4.3 Review workflow

1. Nurse enters visit facts.
2. Agent asks clarification questions only for missing or contradictory items.
3. Agent generates a draft note with highlighted uncertainty.
4. Nurse edits the draft.
5. Agent runs a completeness and consistency check.
6. Nurse approves final text.
7. Nurse manually enters text into Kinnser, or a future browser-assist tool pastes nurse-approved text into selected fields.
8. Nurse performs Kinnser validation, signature, and submission manually.

## 5. Browser-assist design for Kinnser

A later phase may provide browser assistance, but it should be constrained:

- Run only in a browser session opened and authenticated by the clinician.
- Never collect or store credentials, MFA codes, cookies, or session tokens.
- Detect fields only after the nurse has navigated to the correct patient and note.
- Require the nurse to select the destination field or explicitly confirm a field mapping.
- Paste only nurse-approved text.
- Never click final submit, sign, lock, transmit, discharge, approve, or bill buttons.
- Log the draft identifier, destination field label, timestamp, and clinician confirmation.

If WellSky offers an official integration, API, or partner pathway to the agency, that approved pathway should be preferred over screen automation.

## 6. Compliance and security requirements

### 6.1 HIPAA readiness

Before handling real PHI, the deployment must have:

- A signed Business Associate Agreement with each required vendor handling PHI.
- Access controls tied to the agency identity provider where possible.
- Role-based permissions for nurses, reviewers, and administrators.
- Encryption in transit and at rest.
- Short retention defaults for draft notes unless the agency requires retention.
- PHI-safe logging that excludes raw note text unless explicitly configured.
- Audit trails for draft generation, edits, approvals, exports, and deletion.
- Administrative controls for data deletion, export, and breach response.

### 6.2 Model safety controls

- Use a system instruction that prohibits fabrication and requires uncertainty flags.
- Prefer structured outputs with source fields for each generated paragraph.
- Add a final checklist requiring the nurse to verify all vitals, medications, wounds, allergies, orders, and patient responses.
- Refuse requests to falsify documentation or backdate unsupported events.
- Warn when the user asks for unsupported clinical, billing, or regulatory conclusions.

## 7. Example structured prompt

```text
Visit type:
Date/time:
Patient alias or initials:
Primary diagnosis/problem:
Subjective report:
Vitals:
Assessment findings:
Skilled interventions performed:
Medications reviewed / issues:
Wounds / measurements / treatment:
Teaching provided:
Patient or caregiver response:
Care coordination:
Orders, supplies, labs, referrals needed:
Follow-up plan:
Anything uncertain or not assessed:
```

## 8. Example output format

```text
Draft visit narrative:
[Concise skilled nursing note based only on provided facts.]

Teaching and response:
[Education and teach-back summary.]

Medication concerns:
[Issues requiring clinician or prescriber follow-up.]

Care coordination:
[Calls/messages/orders/supplies/follow-up needed.]

QA flags for nurse review:
- Verify all vitals are accurate.
- Confirm medication names, strengths, routes, and frequencies.
- Confirm wound measurements and treatment orders.
- Resolve any highlighted uncertainty before copying into Kinnser.
```

## 9. Quality checks

The agent should flag:

- Missing visit date, visit type, or patient context.
- Vitals omitted when expected.
- Wound note missing location, measurements, drainage, odor, periwound, treatment, or response.
- Medication concern without follow-up action.
- Teaching documented without patient/caregiver response.
- Intervention documented without skilled rationale or response.
- Contradictions, such as “no pain” and “pain 8/10” in the same draft.
- Unsupported phrases like “tolerated well” when response was not provided.

## 10. Phased build plan

### Phase 1: Local drafting prototype

- Build a secure form for structured visit facts.
- Generate drafts and QA checklists.
- Store only de-identified test data.
- Validate templates with sample non-PHI scenarios.

### Phase 2: Agency pilot

- Add authentication, audit logging, retention controls, and role-based access.
- Execute HIPAA/vendor review and Business Associate Agreements.
- Configure agency-approved templates and forbidden phrases.
- Pilot with manually copied notes only.

### Phase 3: Assisted field insertion

- Add optional browser-assist paste into nurse-selected fields.
- Keep final Kinnser review and submission manual.
- Add screenshots only in non-PHI test mode or with PHI redaction.
- Monitor errors, clinician edits, time savings, and QA outcomes.

### Phase 4: Approved integration

- Prefer official WellSky or agency-approved integration pathways if available.
- Replace screen automation with API or export/import mechanisms when authorized.
- Maintain full audit trails and nurse final approval.

## 11. Open questions before implementation

- Is this for home health, hospice, private duty, or mixed workflows?
- Which note types are most time-consuming in Kinnser?
- Will the agency approve AI-assisted documentation and sign a BAA with vendors?
- Should the first version run locally, inside an agency network, or as a hosted HIPAA-eligible service?
- Are agency templates, abbreviations, and QA rules available for configuration?
- Is official WellSky integration access available, or should the first release avoid direct integration?

## 12. Public references used for this blueprint

- WellSky HHH login: `https://kinnser.net/login.cfm`
- Kinnser Link product page: `https://get.wellsky.com/link.html`

These references were used only to understand the public-facing product context. The implementation should rely on the agency's own WellSky contract, policies, and any official integration documentation made available to that agency.
