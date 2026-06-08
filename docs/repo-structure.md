# Repository Structure

This repo is organized as a practical home-health nursing toolkit, not a full autonomous EMR bot.

## Current structure

```text
.
├── README.md
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

## Folder purpose

### `app/`
Usable tools that can be opened directly in Safari/Chrome on iPhone, iPad, Mac, or Windows.

Current MVP:

- `offline-field-toolkit.html` — single-file offline drafting tool with sections for SN visit notes, follow-up auths, physician orders, wound blocks, and QA checks.

### `docs/`
Product specs, safety rules, build roadmap, and implementation notes.

Use this folder for:

- Workflow maps.
- Safety / HIPAA planning.
- Kinnser/WellSky browser-assist design.
- Future feature specs.

### `prompts/`
Reusable prompt instructions for ChatGPT or a future local/hosted assistant.

Use this folder for:

- System prompts.
- Note-generation prompts.
- QA-check prompts.
- Patient-safe wording rules.

### `templates/`
Reusable text templates for common home-health documentation tasks.

Use this folder for:

- Get Auth / follow-up authorization formats.
- SNV note formats.
- Wound care blocks.
- Foley care blocks.
- Recert / discharge / missed visit templates.

## Build direction

### Phase 1 — Field MVP

Goal: fast, offline-friendly, nurse-controlled text generation.

- Open local HTML tool.
- Enter/dictate visit facts.
- Generate structured note blocks.
- Copy approved text into Kinnser manually.
- Nurse verifies and signs in Kinnser.

### Phase 2 — Better local workflow

- Add Apple Shortcut launcher.
- Add quick buttons for common cases: Foley, wound, CHF, DM, edema/lymphedema, fall risk, med issue.
- Add local export to `.txt`.
- Add clear warning before storing any PHI locally.

### Phase 3 — QA assistant

- Add completeness rules by visit type.
- Flag contradictions.
- Flag missing wound fields, missing teach-back, missing skilled rationale, and missing follow-up.
- Keep final clinical decisions with the nurse.

### Phase 4 — Browser-assist only after safety review

A future browser-assist layer may paste nurse-approved text into selected fields, but must never collect credentials, bypass security, submit, sign, lock, or transmit records.

## Non-negotiable product rule

The tool drafts and organizes. The clinician verifies, edits, manually enters, and signs.
