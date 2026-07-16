#!/usr/bin/env python3
"""Build a deterministic Project Atlas context packet for Codex runs."""
from __future__ import annotations

import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "config" / "modules.json"


def load_manifest() -> dict:
    return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))


def selected_ids(mode: str, domains: list[str], manifest: dict) -> list[int]:
    if mode in {"deep", "weekly", "monthly"}:
        return list(range(25))
    ids = set(manifest["commands"]["run atlas"]["modules"])
    for domain in domains:
        if domain not in manifest["domain_routes"]:
            valid = ", ".join(sorted(manifest["domain_routes"]))
            raise ValueError(f"unknown domain '{domain}'. Valid domains: {valid}")
        ids.update(manifest["domain_routes"][domain])
    return sorted(ids)


def build_packet(mode: str, query: str, domains: list[str]) -> str:
    manifest = load_manifest()
    ids = selected_ids(mode, domains, manifest)
    by_id = {m["id"]: m for m in manifest["modules"]}
    chunks = [
        "# Project Atlas Codex Run Packet",
        "",
        f"- Mode: {mode}",
        f"- Query: {query}",
        f"- Domains: {', '.join(domains) if domains else 'router-selected / all for rebuild'}",
        "",
        "Follow atlas/AGENTS.md. Verify all dynamic facts live. Do not treat this packet as current market evidence.",
    ]
    for module_id in ids:
        module = by_id[module_id]
        path = ROOT / manifest["source_directory"] / module["file"]
        chunks.extend([
            "",
            "---",
            "",
            f"## Source {module_id:02d}: {module['title']}",
            "",
            path.read_text(encoding="utf-8").strip(),
        ])
    return "\n".join(chunks) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["daily", "deep", "weekly", "monthly"], default="daily")
    parser.add_argument("--query", required=True)
    parser.add_argument("--domains", default="", help="Comma-separated domain route names from config/modules.json")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    domains = [d.strip() for d in args.domains.split(",") if d.strip()]
    packet = build_packet(args.mode, args.query, domains)
    if args.output:
        args.output.write_text(packet, encoding="utf-8")
        print(args.output)
    else:
        print(packet, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
