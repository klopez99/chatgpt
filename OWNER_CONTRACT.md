# Home Health Owner Contract

This contract defines the operating boundaries for the home-health products in this repository.

## Scope

This contract applies to the clinician-controlled nursing documentation and home-health workflow code at the repository root and in home-health-specific directories, including `app/`, `home-health-streamline-soc/`, `home-health-toolkit/`, `docs/`, `prompts/`, `templates/`, `src/`, and `tests/`.

It does **not** govern `atlas/`, which has its own nested agent instructions.

## 1. System

The system is a clinician-controlled home-health documentation and workflow copilot.

Its job is to transform nurse-provided facts and approved agency templates into reviewable drafts, QA flags, task lists, and structured workflow outputs. Typical outputs include skilled nursing narratives, teaching/response text, wound documentation blocks, medication concern summaries, care-coordination notes, Kaiser/UM authorization wording, order-request drafts, and follow-up tasks.

Clinical truth originates from the clinician, source record, or an explicitly approved reference. The system may organize, format, summarize, validate, and flag; it must not manufacture clinical facts.

The system is not an autonomous EHR agent. It must not diagnose, prescribe, backdate, fabricate findings, select unsupported OASIS answers, sign records, submit records, lock charts, bill, or represent that a clinician performed an action that was not documented.

## 2. Agents, tools, and context

Agents working on home-health code must read, in order:

1. this file;
2. `docs/kinnser-nursing-agent-spec.md`;
3. `prompts/home-health-charting-system.md`;
4. the relevant template, test, and module documentation.

Agents may use repository code, synthetic fixtures, official CMS guidance, and authorized product documentation needed for the task. They must use the minimum necessary data and tool access.

Rules:

- Never place real PHI in source control, fixtures, screenshots, test logs, prompts committed to the repository, analytics, or public previews.
- Never collect or store WellSky/Kinnser credentials, MFA codes, cookies, or session tokens.
- When a material fact is missing or contradictory, produce a review/verify condition instead of inventing a value.
- Regulatory behavior must be grounded in a current authoritative source. For OASIS, prefer current CMS OASIS manuals, data specifications, and Q&A material.
- Any future direct EHR integration belongs behind a narrow adapter and requires explicit owner approval before it can perform a write.
- External communication to a payer, physician, patient, caregiver, vendor, or agency is consequential and must remain draft-only unless a separately approved workflow defines the exact action and human approval gate.

## 3. Validation

A change is not complete because generated text looks plausible.

Minimum validation:

- `npm test` passes for the root nursing prototype when affected.
- Material generated clinical statements remain traceable to user/source input or an approved template.
- Missing facts fail closed with a visible QA/review flag.
- Changes to wound, medication, authorization, OASIS, or other regulated workflows include tests for missing, contradictory, and unsupported input.
- UI or export changes receive a synthetic-data smoke test.
- Regulatory-rule changes identify the authoritative source and effective date in the PR.

The clinician remains the final validator of patient-specific content.

## 4. Deployment control

Use four release stages:

### DEV
Synthetic/de-identified data only. No production EHR, payer, physician, or patient actions.

### PREVIEW
Reviewable build or static preview. Synthetic data only. No PHI and no unattended external actions.

### PILOT
Limited authorized users in an agency-approved environment. Human review remains mandatory for all patient-record and external-communication actions.

### PRODUCTION
Only bounded behavior that has passed tests, privacy/security review, workflow review, and explicit owner approval.

Owner approval is required before any change that:

- permits real PHI to leave the local/approved environment;
- enables direct EHR write, sign, submit, lock, discharge, billing, or order actions;
- autonomously communicates externally;
- changes the clinician-as-author-of-record model;
- materially changes clinical/regulatory scope.

Public GitHub Pages content must contain no PHI. Public deployment is a distribution action, not a clinical authorization.

## Portfolio invariants

1. Clinical truth comes from clinicians/source records, not the model.
2. Transformations preserve provenance.
3. Agents receive minimum necessary tools and data.
4. Unknown information becomes REVIEW/VERIFY, never an invented answer.
5. Deterministic checks precede model judgment wherever possible.
6. Human approval becomes stronger as an action approaches the legal record, external communication, payment, or patient care.
