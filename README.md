# Nursing Charting & Kinnser Workflow Agent Blueprint

This repository contains a starter blueprint and first local prototype for building an assistant that helps a licensed clinician with home-health nursing charting and daily workflow in WellSky Home Health & Hospice (formerly Kinnser) at `kinnser.net`.

## Current prototype

The first implementation is a dependency-free browser app for a clinician-controlled documentation draft workflow:

- Structured visit-fact form for de-identified test data.
- Editable draft sections for visit narrative, teaching/response, medication concerns, care coordination, and follow-up tasks.
- QA flags for missing required fields, wound detail gaps, medication follow-up gaps, teaching without response, intervention response gaps, pain contradictions, and unresolved uncertainty.
- Explicit clinician approval gate before copying approved draft text.
- No Kinnser connection, no credential handling, no patient-data storage, and no EMR submission.

Open `index.html` in a browser to try the prototype locally. Run `npm test` to execute the dependency-free drafting and QA tests.

## Goal

Create a clinician-controlled assistant that reduces repetitive documentation work while preserving professional judgment, patient privacy, and final nurse review before anything is entered or submitted in Kinnser.

## Non-negotiable safeguards

- **No autonomous clinical decisions.** The agent may summarize, organize, and draft documentation from nurse-provided facts, but it must not diagnose, prescribe, create unsupported findings, or choose OASIS/assessment answers without clinician confirmation.
- **No unattended EMR actions.** The agent must not submit, sign, lock, transmit, or finalize a Kinnser note without an explicit final review and confirmation from the authorized clinician.
- **No credential collection in chat.** The agent must never ask for or store Kinnser usernames, passwords, MFA codes, or security questions.
- **HIPAA-first data handling.** Protected Health Information must be minimized, encrypted in transit and at rest, retained only as long as necessary, and handled only under appropriate organizational authorization and Business Associate Agreement coverage.
- **Auditability.** Drafts, edits, confirmations, and any browser-assist actions must be logged with timestamps, user identity, patient/task context, and whether the clinician approved the final text.

## Recommended first version

Start with a **human-in-the-loop documentation copilot** instead of full Kinnser automation:

1. The nurse dictates or types visit facts using a structured prompt.
2. The agent turns those facts into a concise draft note, visit narrative, teaching summary, medication issue list, care coordination summary, and follow-up task checklist.
3. The nurse reviews and edits the draft.
4. The nurse manually copies approved text into Kinnser, or a later browser-assist layer pastes only into fields the nurse has selected.
5. The nurse performs the final Kinnser validation, signature, and submission.

This version avoids direct EMR integration risk while still reducing after-hours documentation burden.

## What the agent can help with

- Pre-visit planning checklist based on nurse-entered schedule/task details.
- Visit narrative drafts from nurse-provided objective and subjective findings.
- Medication reconciliation issue summaries, without inventing medication decisions.
- Wound-care measurement formatting and trend summaries from provided measurements.
- Patient/caregiver teaching summaries and teach-back documentation.
- Care coordination notes for physician, therapy, aide, DME, pharmacy, or agency follow-up.
- Missed-visit, PRN-visit, recertification, discharge-planning, and supervisory-visit draft language.
- End-of-day task lists: incomplete notes, follow-up calls, orders to request, supply needs, and QA flags to review.

## What the agent must not do

- Fabricate assessment findings, vitals, wounds, medications, interventions, or patient responses.
- Recommend billing, eligibility, or regulatory coding without source evidence and clinician review.
- Select OASIS responses as final answers without the nurse verifying every item.
- Circumvent Kinnser security, session controls, user permissions, MFA, CAPTCHA, or Terms of Service.
- Scrape or export patient data outside authorized workflows.
- Store PHI in logs, analytics, screenshots, prompts, or third-party systems unless explicitly approved by the covered entity.

## Implementation roadmap

See [`docs/kinnser-nursing-agent-spec.md`](docs/kinnser-nursing-agent-spec.md) for the full product, compliance, workflow, and technical specification.
