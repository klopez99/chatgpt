# Referral-to-OASIS reuse workflow

This document describes a generic, clinician-controlled workflow for reducing repetitive data entry in home-health documentation. It contains no patient-identifying information and is intended for de-identified development and testing.

## Goal

Enter verified referral information once, reuse it safely across downstream documents, and keep the nurse as the final reviewer for every clinical and administrative output.

## Canonical flow

```text
referral / intake packet
-> extract structured facts
-> nurse verifies the extracted facts
-> populate reusable encounter/context object
-> prefill SOC booklet and administrative forms
-> reuse verified facts in OASIS-E2 preparation
-> generate draft authorization/order/visit-support text
-> nurse reviews, edits, and manually submits/signs in the approved system
```

## Referral extraction

Support both digital and scanned referral packets. The extraction layer may identify candidate values for:

- demographics and contact fields needed for the immediate workflow;
- payer/insurance and Medicare identifiers where required;
- referral diagnoses and recent hospitalization context;
- ordering/referring provider and agency contacts;
- ordered disciplines/frequencies when explicitly present;
- medication, wound, line/device, and safety information when present in the source.

Extracted values are **candidates**, not final charted facts. Every field should preserve source provenance and a verification state.

## Reusable context object

After nurse verification, maintain one structured context object for the active workflow so downstream forms do not require repeated copy/paste. At minimum, distinguish:

- source-derived facts;
- nurse-assessed facts;
- agency/payer template rules;
- generated draft text;
- unresolved/uncertain fields.

Never convert missing data into assumed clinical findings.

## SOC and administrative prefilling

The reusable context may prefill administrative portions of:

- SOC booklet fields;
- consent/acknowledgment paperwork;
- financial-responsibility forms;
- agency intake worksheets;
- other non-clinical fields that the agency permits to be prepopulated.

The user must verify all fields before use. Signatures, acknowledgments, and attestations remain manual.

## OASIS-E2 reuse

The workflow may carry forward verified demographic/referral context into an OASIS-E2 preparation view, but it must not autonomously select final OASIS responses that depend on the nurse's assessment or clinical judgment.

For every candidate OASIS value, the interface should show:

- source or assessment origin;
- whether it was referral-derived or nurse-assessed;
- verification status;
- conflicts or missing information.

## Downstream drafting

The verified context may support drafts for:

- Kaiser/Get Auth or subsequent authorization requests;
- physician/order requests;
- visit summaries;
- wound-care blocks;
- care-coordination notes;
- follow-up task lists.

Generated text must stay traceable to verified facts and controlled templates.

## Scanned documents

When source packets are image-based or scanned, the system should support document-image extraction as an intake step. Because extraction can be imperfect, low-confidence fields should be surfaced for nurse verification rather than silently accepted.

## Medicare number handling

Where an agency workflow requires a Medicare identifier, include a dedicated field rather than burying it in free text. Handle identifiers as sensitive data: minimize persistence, do not include them in logs/analytics/test fixtures, and never commit them to source control.

## Privacy boundaries

- No real PHI in public repositories, test fixtures, screenshots, logs, or analytics.
- Use de-identified/synthetic examples for development.
- Store real patient information only in agency-approved systems and environments.
- Do not persist referral files longer than the approved workflow requires.

## Nurse approval gates

A human review is required before:

1. accepting extracted referral facts;
2. using prefilled administrative fields;
3. accepting any clinical assessment value;
4. copying generated documentation into the EMR;
5. signing, submitting, transmitting, or finalizing any clinical record.

## Future implementation targets

- source-linked extraction UI with confidence/verification states;
- reusable structured patient/context object for one active episode;
- SOC/consent/financial-responsibility prefill mapping;
- OASIS-E2 preparation mapping;
- payer-specific authorization templates;
- export formats that preserve familiar agency form layout;
- explicit deletion/retention controls for temporary intake data.
