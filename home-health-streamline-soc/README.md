# Home Health Streamline SOC

An iPad-first workflow for combining home-health start-of-care forms into one fillable PDF that can be signed with Apple Pencil and uploaded to WellSky/Kinnser as a single document.

## Current version

The initial builder:

- creates a cover sheet with patient/episode fields and a completion checklist;
- merges the agency consent, financial notice, BIMS, MAHC-10, and Norton forms;
- adds large AcroForm fields and checkboxes over the original forms;
- produces one combined PDF for iPad completion and Kinnser upload.

## Local setup

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Place the five source PDFs in `source_forms/` using the filenames listed in `build_soc_packet.py`, then run:

```bash
python build_soc_packet.py
```

The generated file is written to:

```text
output/Home_Health_Streamline_SOC_iPad_Fillable.pdf
```

## iPad workflow

1. Open the generated PDF in Adobe Acrobat on iPad.
2. Complete the fillable fields.
3. Use Fill & Sign with Apple Pencil for handwritten signatures.
4. Save a completed copy.
5. Flatten the copy before submission when required by agency policy.
6. Upload the single PDF to the patient document section in Kinnser.

## Privacy

Do not commit completed patient forms, PHI, signatures, medical-record numbers, addresses, or exported patient packets. Generic blank agency forms should also remain private unless the agency authorizes distribution.

## Planned development

- reusable demographic fields across all pages;
- automatic BIMS, MAHC-10, and Norton scoring;
- Apple Pencil-sized signature areas;
- form validation and missing-field summary;
- one-tap flattened export;
- standardized Kinnser filename generation;
- optional browser-based iPad interface with local-only processing.
