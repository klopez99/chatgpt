#!/usr/bin/env python3
"""Validate Project Atlas source integrity without third-party dependencies."""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCES = ROOT / "sources"
MANIFEST = ROOT / "config" / "modules.json"

REQUIRED_ROUTER_PHRASES = [
    "ROUTING ORDER FOR EVERY RUN",
    "No Repeat Rule",
    "10% Conviction Rule",
    "Contradiction requirement",
]


def source_files() -> list[Path]:
    return sorted(SOURCES.glob("[0-2][0-9]_Atlas_*.txt"))


def validate() -> list[str]:
    errors: list[str] = []
    files = source_files()
    if len(files) != 25:
        errors.append(f"expected exactly 25 source files, found {len(files)}")

    prefixes = []
    for path in files:
        match = re.match(r"^(\d{2})_Atlas_.+\.txt$", path.name)
        if not match:
            errors.append(f"invalid source filename: {path.name}")
            continue
        prefixes.append(int(match.group(1)))
        text = path.read_text(encoding="utf-8")
        if not text.startswith("PROJECT ATLAS —"):
            errors.append(f"missing canonical header: {path.name}")
        if path.name != "00_Atlas_Master_Index_and_Router.txt" and "GLOBAL ATLAS RULES" not in text:
            errors.append(f"missing global rules: {path.name}")

    if prefixes != list(range(25)):
        errors.append(f"source numbering must be 00-24, got {prefixes}")

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    if manifest.get("source_count") != 25:
        errors.append("manifest source_count must equal 25")
    manifest_files = [m["file"] for m in manifest.get("modules", [])]
    actual_files = [p.name for p in files]
    if manifest_files != actual_files:
        errors.append("manifest module list does not exactly match source directory")

    router = (SOURCES / manifest["router"]).read_text(encoding="utf-8")
    for phrase in REQUIRED_ROUTER_PHRASES:
        if phrase not in router:
            errors.append(f"router missing required phrase: {phrase}")

    output = (SOURCES / "24_Atlas_Output_Contract_and_Domain_Registry.txt").read_text(encoding="utf-8")
    for phrase in ["STANDARD RUN OUTPUT", "RUN ATLAS", "Deep rebuild"]:
        if phrase.lower() not in output.lower():
            errors.append(f"output contract missing: {phrase}")

    scoring = (ROOT / "config" / "scoring.yaml").read_text(encoding="utf-8")
    for section in ["atlas_weights:", "stealth_score_weights:", "material_change:", "verdict_thresholds:"]:
        if section not in scoring:
            errors.append(f"scoring config missing section: {section}")

    return errors


def main() -> int:
    errors = validate()
    if errors:
        print("Atlas validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1
    print("Atlas validation passed: 25 sources, router, manifest, scoring, and output contract are consistent.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
