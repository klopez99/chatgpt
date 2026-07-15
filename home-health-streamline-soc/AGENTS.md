# Codex Task Brief

## Product goal

Build a private, iPad-first Home Health Streamline SOC application that allows a field nurse to complete blank agency forms, obtain patient signatures with Apple Pencil, calculate screening scores, and export one flattened PDF for WellSky/Kinnser upload.

## Current baseline

`build_soc_packet.py` creates a fillable PDF from five blank source forms:

- consent;
- notice of financial responsibility;
- BIMS;
- MAHC-10;
- Norton Scale.

## Immediate priorities

1. Refactor field coordinates into a declarative JSON schema.
2. Add automated validation for required source files and page sizes.
3. Add repeated demographic values across relevant pages.
4. Add score calculation logic for BIMS, MAHC-10, and Norton.
5. Add a missing-fields summary before export.
6. Add a flatten/export command that preserves handwritten signatures.
7. Add automated PDF smoke tests: page count, field count, unique field names, and successful reopen.
8. Create an optional local-only browser UI optimized for iPad Safari.

## Privacy and safety constraints

- Never commit PHI, completed patient forms, signatures, addresses, DOBs, MRNs, medication lists, or exported clinical packets.
- Keep patient processing local to the device whenever possible.
- Do not send patient data to analytics, logging, telemetry, third-party APIs, or cloud storage by default.
- Do not alter the legal wording of agency consent or financial forms without agency approval.
- Keep a clear distinction between a workflow aid and the legal medical record.
- Do not imply CMS, payer, agency, or legal approval without formal review.

## UX requirements

- Portrait-first iPad layout.
- Large touch targets and signature boxes.
- Minimal typing and no tiny controls.
- Save/resume locally.
- Explicit review screen before final export.
- Export filename pattern: `LastName_FirstName_SOC_Forms_YYYY-MM-DD.pdf`.
- One combined PDF suitable for direct upload to Kinnser.

## Definition of done for the next milestone

A clinician can place the approved blank forms into `source_forms/`, run the builder, complete the output in Acrobat on iPad, sign it, flatten it, and reopen the final file with all entries visible and no missing pages.
