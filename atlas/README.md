# Project Atlas OS

Project Atlas converts macro, policy, regulatory, company, and market signals into explicit, falsifiable capital decisions.

## What is implemented

- Exact 25-source operating system with master router
- Domain routing across power, data centers, nuclear, cooling, compute, networking, robotics, defense, and materials
- Evidence hierarchy, contradiction testing, No Repeat Rule, and 10% Conviction Rule
- 0–100 Atlas Conviction and Stealth Compounder scoring
- Daily, deep, weekly, and monthly run modes
- Decision Journal, Kill List, action-report, What Changed, and rebuild templates
- Codex run-packet generator and source-integrity tests

## Directory map

```text
atlas/
├── AGENTS.md
├── README.md
├── config/
│   ├── modules.json
│   └── scoring.yaml
├── prompts/
│   └── project-atlas-system.md
├── scripts/
│   ├── build_run_packet.py
│   └── validate_atlas.py
├── sources/
│   └── 00...24 (exactly 25 permanent sources)
├── state/
│   └── README.md
├── templates/
│   ├── action-report.md
│   ├── decision-journal.md
│   ├── deep-rebuild.md
│   ├── kill-list.md
│   └── what-changed.md
└── tests/
    └── test_atlas_sources.py
```

## Use in Codex

Open the repository in Codex and work inside `atlas/`. Codex automatically inherits `atlas/AGENTS.md`.

Daily material-change run:

```text
Run Atlas on the current watchlist. Use fresh primary sources, route findings through the relevant domains, enforce the No Repeat and 10% Conviction rules, update decision state only when material, and use templates/what-changed.md.
```

Deep weekend rebuild:

```text
Perform a Deep Atlas rebuild. Load all 25 sources, re-score every active thesis, attack each thesis, update the Decision Journal and Kill List, and use templates/deep-rebuild.md.
```

Company action report:

```text
Run Project Atlas on TICKER. Use current primary sources, config/scoring.yaml, and templates/action-report.md. End with one verdict and a position stage.
```

## Build a run packet

```bash
python atlas/scripts/build_run_packet.py --mode deep --query "Rebuild the AI infrastructure watchlist" --output /tmp/atlas-run.md
```

For a routed daily run:

```bash
python atlas/scripts/build_run_packet.py --mode daily --domains power_grid_utility,data_centers_land_permitting_water --query "What changed today?"
```

## Validate

```bash
python atlas/scripts/validate_atlas.py
python -m unittest discover -s atlas/tests -v
```

Atlas does not execute trades. It structures evidence, expected value, timing, and risk for human review.
