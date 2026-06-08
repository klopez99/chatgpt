# Nursing Charting & Kinnser Workflow Toolkit

This repository contains a practical, clinician-controlled toolkit for home-health nursing charting and daily workflow in WellSky Home Health & Hospice / Kinnser.

The project is intentionally designed as a **drafting and workflow copilot**, not an autonomous EMR bot.

## Start here

Open the offline field toolkit:

```text
app/offline-field-toolkit.html
```

You can download/open that file in Safari or Chrome on iPhone, iPad, Mac, or Windows. It is a single-file HTML tool with no external dependencies.

Current sections:

- Skilled Nursing Visit Note
- Follow-Up Authorization / Get Auth
- Physician Order Draft
- Wound Documentation Block
- QA Completeness Check

Basic workflow:

1. Enter or dictate visit facts.
2. Generate a copy block.
3. Review and edit the draft.
4. Copy only verified text into Kinnser.
5. Manually validate, sign, and submit in Kinnser.

## Goal

Create a clinician-controlled assistant that reduces repetitive documentation work while preserving professional judgment, patient privacy, and final nurse review before anything is entered or submitted in Kinnser.

## Non-negotiable safeguards

- **No autonomous clinical decisions.** The tool may summarize, organize, and draft documentation from nurse-provided facts, but it must not diagnose, prescribe, create unsupported findings, or choose OASIS/assessment answers without clinician confirmation.
- **No unattended EMR actions.** The tool must not submit, sign, lock, transmit, or finalize a Kinnser note without explicit final review and confirmation from the authorized clinician.
- **No credential collection.** The tool must never ask for or store Kinnser usernames, passwords, MFA codes, or security questions.
- **HIPAA-first data handling.** Protected Health Information must be minimized, retained only as long as necessary, and handled only in approved environments.
- **Auditability for future hosted/browser-assist versions.** Drafts, edits, confirmations, and any browser-assist actions should be logged with timestamps, user identity, patient/task context, and clinician approval status.

## Repository map

```text
.
├── app/
│   └── offline-field-toolkit.html
├── docs/
│   ├── kinnser-nursing-agent-spec.md
│   └── repo-structure.md
├── prompts/
│   └── home-health-charting-system.md
└── templates/
    ├── get-auth-template.md
    └── snv-note-template.md
```

See [`docs/repo-structure.md`](docs/repo-structure.md) for expansion guidance.

## Recommended first version

Start with a **human-in-the-loop documentation copilot** instead of full Kinnser automation:

1. The nurse dictates or types visit facts using a structured prompt or the offline HTML form.
2. The tool turns those facts into a concise draft note, visit narrative, teaching summary, medication issue list, care coordination summary, authorization request, order request, wound block, or follow-up task checklist.
3. The nurse reviews and edits the draft.
4. The nurse manually copies approved text into Kinnser.
5. The nurse performs the final Kinnser validation, signature, and submission.

This version avoids direct EMR integration risk while still reducing after-hours documentation burden.

## What the toolkit can help with

- Pre-visit planning checklist based on nurse-entered schedule/task details.
- Visit narrative drafts from nurse-provided objective and subjective findings.
- Follow-up authorization / Get Auth wording.
- Medication reconciliation issue summaries, without inventing medication decisions.
- Wound-care measurement formatting and trend summaries from provided measurements.
- Patient/caregiver teaching summaries and teach-back documentation.
- Care coordination notes for physician, therapy, aide, DME, pharmacy, or agency follow-up.
- Missed-visit, PRN-visit, recertification, discharge-planning, and supervisory-visit draft language.
- End-of-day task lists: incomplete notes, follow-up calls, orders to request, supply needs, and QA flags to review.

## What the toolkit must not do

- Fabricate assessment findings, vitals, wounds, medications, interventions, or patient responses.
- Recommend billing, eligibility, or regulatory coding without source evidence and clinician review.
- Select OASIS responses as final answers without the nurse verifying every item.
- Circumvent Kinnser security, session controls, user permissions, MFA, CAPTCHA, or Terms of Service.
- Scrape or export patient data outside authorized workflows.
- Store PHI in logs, analytics, screenshots, prompts, or third-party systems unless explicitly approved by the covered entity.

## Implementation roadmap

See [`docs/kinnser-nursing-agent-spec.md`](docs/kinnser-nursing-agent-spec.md) for the full product, compliance, workflow, and technical specification.

Next practical build targets:

1. Add one-click common condition modules: Foley, wound, CHF, DM, edema/lymphedema, fall risk, med issue, ALF limitations.
2. Add text export/download from the offline toolkit.
3. Add Apple Shortcut launcher instructions.
4. Add a Kinnser field-by-field paste map for manual copy/paste.
5. Add sample de-identified test cases for QA.
