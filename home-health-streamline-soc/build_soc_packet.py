from __future__ import annotations

from io import BytesIO
from pathlib import Path

from pypdf import PdfReader, PdfWriter
from pypdf.generic import ArrayObject, BooleanObject, DictionaryObject, NameObject
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

ROOT = Path(__file__).resolve().parent
SOURCE_DIR = ROOT / "source_forms"
OUTPUT_DIR = ROOT / "output"
OUTPUT_FILE = OUTPUT_DIR / "Home_Health_Streamline_SOC_iPad_Fillable.pdf"

SOURCE_FORMS = [
    (SOURCE_DIR / "Consent Form 2025_2.pdf", "Consent"),
    (SOURCE_DIR / "Notice of Financial Responsibility_1.pdf", "Financial"),
    (SOURCE_DIR / "BIMS test_1.pdf", "BIMS"),
    (SOURCE_DIR / "MAHC 10 Fall Risk Assessment Tool.pdf", "MAHC"),
    (SOURCE_DIR / "Norton Scale_1.pdf", "Norton"),
]


def add_text_field(form, name: str, x: float, y: float, width: float, height: float = 18, font_size: int = 9):
    form.textfield(
        name=name,
        x=x,
        y=y,
        width=width,
        height=height,
        borderWidth=0.8,
        borderColor=colors.HexColor("#1f5d7a"),
        fillColor=colors.Color(1, 1, 1, alpha=0.72),
        fontName="Helvetica",
        fontSize=font_size,
    )


def add_checkbox(form, name: str, x: float, y: float, size: float = 12):
    form.checkbox(
        name=name,
        x=x,
        y=y,
        size=size,
        buttonStyle="check",
        borderWidth=0.7,
        borderColor=colors.HexColor("#1f5d7a"),
    )


def build_cover_page():
    buffer = BytesIO()
    pdf = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter

    pdf.setFillColor(colors.HexColor("#123b5d"))
    pdf.rect(0, height - 86, width, 86, fill=1, stroke=0)
    pdf.setFillColor(colors.white)
    pdf.setFont("Helvetica-Bold", 20)
    pdf.drawString(36, height - 48, "Home Health Streamline SOC Packet")
    pdf.setFont("Helvetica", 10)
    pdf.drawString(36, height - 67, "iPad fillable • Apple Pencil friendly • Kinnser upload ready")

    pdf.setFillColor(colors.black)
    pdf.setFont("Helvetica-Bold", 12)
    pdf.drawString(36, height - 115, "Patient / Episode")
    form = pdf.acroForm

    def labeled_field(name: str, x: float, y: float, field_width: float, label: str):
        pdf.setFont("Helvetica", 8)
        pdf.drawString(x, y + 27, label)
        add_text_field(form, name, x, y, field_width, 24, 11)

    labeled_field("patient_name", 36, height - 165, 250, "Patient name")
    labeled_field("dob", 306, height - 165, 120, "DOB")
    labeled_field("mrn", 446, height - 165, 130, "MRN")
    labeled_field("soc_date", 36, height - 215, 140, "SOC date")
    labeled_field("clinician", 196, height - 215, 250, "Clinician")
    labeled_field("agency", 466, height - 215, 110, "Agency")

    pdf.setFont("Helvetica-Bold", 12)
    pdf.drawString(36, height - 260, "Quick visit checklist")
    checklist = [
        "Consent completed",
        "Financial notice completed",
        "BIMS scored",
        "MAHC-10 scored",
        "Norton scored",
        "Medication reconciliation completed",
        "Wound photos uploaded",
        "Orders / MD notifications completed",
    ]
    y = height - 290
    for index, item in enumerate(checklist):
        add_checkbox(form, f"check_{index}", 38, y - 2, 14)
        pdf.setFont("Helvetica", 10)
        pdf.drawString(58, y, item)
        y -= 27

    pdf.setFont("Helvetica-Bold", 11)
    pdf.drawString(36, 170, "Submission notes / Kinnser document title")
    form.textfield(
        name="submission_notes",
        x=36,
        y=80,
        width=540,
        height=78,
        fieldFlags="multiline",
        borderWidth=1,
        borderColor=colors.HexColor("#54748a"),
        fontName="Helvetica",
        fontSize=10,
    )

    pdf.setFont("Helvetica-Oblique", 8)
    pdf.setFillColor(colors.HexColor("#555555"))
    pdf.drawString(
        36,
        55,
        "Complete in Acrobat on iPad, sign with Fill & Sign, save/flatten a copy, then upload the single PDF to Kinnser.",
    )
    pdf.showPage()
    pdf.save()
    buffer.seek(0)
    return PdfReader(buffer).pages[0]


def build_overlay(page_width: float, page_height: float, kind: str):
    buffer = BytesIO()
    pdf = canvas.Canvas(buffer, pagesize=(page_width, page_height))
    form = pdf.acroForm

    if kind == "Consent":
        add_text_field(form, "consent_patient", 258, page_height - 102, 190)
        add_text_field(form, "consent_dob", 425, page_height - 102, 115)
        add_text_field(form, "consent_rn", 258, page_height - 126, 110)
        for index, x in enumerate([330, 367, 405, 442, 480, 520]):
            add_checkbox(form, f"service_{index}", x, page_height - 128, 10)
        add_text_field(form, "emergency_name", 125, 185, 235)
        add_text_field(form, "emergency_phone", 405, 185, 135)
        add_text_field(form, "consent_signed_name", 105, 105, 280)
        add_text_field(form, "consent_date", 390, 105, 90)
        add_text_field(form, "consent_time", 490, 105, 70)
        add_text_field(form, "consent_witness", 120, 62, 250)
    elif kind == "Financial":
        add_text_field(form, "fin_patient", 105, page_height - 93, 255)
        add_text_field(form, "fin_mrn", 445, page_height - 93, 115)
        add_checkbox(form, "fin_kpsa", 475, page_height - 147, 11)
        add_checkbox(form, "fin_annual", 52, 342, 11)
        add_checkbox(form, "fin_deductible", 52, 286, 11)
        add_checkbox(form, "fin_pervisit", 52, 240, 11)
        add_text_field(form, "fin_patient_signature", 110, 119, 430, 22)
        add_text_field(form, "fin_rep_signature", 150, 91, 390, 22)
        add_text_field(form, "fin_date", 70, 61, 150)
        add_text_field(form, "fin_staff", 365, 61, 175)
        add_text_field(form, "fin_time", 70, 35, 150)
    elif kind == "BIMS":
        add_text_field(form, "bims_resident", 85, page_height - 55, 210)
        add_text_field(form, "bims_id", 355, page_height - 55, 105)
        add_text_field(form, "bims_date", 500, page_height - 55, 75)
        add_text_field(form, "bims_score", 410, 34, 85, 22, 11)
    elif kind == "MAHC":
        add_text_field(form, "mahc_patient", 60, page_height - 48, 250)
        add_text_field(form, "mahc_date", 430, page_height - 48, 160)
        y = page_height - 145
        for index in range(10):
            add_text_field(form, f"mahc_{index + 1}", 618, y - index * 55, 38, 22, 10)
        add_text_field(form, "mahc_total", 618, 42, 38, 22, 10)
    elif kind == "Norton":
        add_text_field(form, "norton_patient", 60, page_height - 52, 260)
        add_text_field(form, "norton_date", 430, page_height - 52, 120)
        add_text_field(form, "norton_physical", 500, 520, 45)
        add_text_field(form, "norton_mental", 500, 430, 45)
        add_text_field(form, "norton_activity", 500, 342, 45)
        add_text_field(form, "norton_mobility", 500, 252, 45)
        add_text_field(form, "norton_incontinence", 500, 165, 45)
        add_text_field(form, "norton_total", 415, 92, 80, 22, 11)

    pdf.showPage()
    pdf.save()
    buffer.seek(0)
    return PdfReader(buffer).pages[0]


def validate_sources():
    missing = [str(path) for path, _ in SOURCE_FORMS if not path.exists()]
    if missing:
        joined = "\n - ".join(missing)
        raise FileNotFoundError(f"Missing source forms:\n - {joined}")


def build_packet():
    validate_sources()
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    writer = PdfWriter()
    writer.add_page(build_cover_page())

    for path, kind in SOURCE_FORMS:
        reader = PdfReader(path)
        page = reader.pages[0]
        page_width = float(page.mediabox.width)
        page_height = float(page.mediabox.height)
        page.merge_page(build_overlay(page_width, page_height, kind))
        writer.add_page(page)

    fields = ArrayObject()
    for page in writer.pages:
        for annotation in page.get("/Annots", []):
            widget = annotation.get_object()
            if widget.get("/Subtype") == "/Widget" and widget.get("/T"):
                fields.append(annotation)

    acroform = DictionaryObject(
        {
            NameObject("/Fields"): fields,
            NameObject("/NeedAppearances"): BooleanObject(True),
        }
    )
    writer._root_object.update({NameObject("/AcroForm"): writer._add_object(acroform)})

    with OUTPUT_FILE.open("wb") as handle:
        writer.write(handle)

    print(f"Created: {OUTPUT_FILE}")


if __name__ == "__main__":
    build_packet()
