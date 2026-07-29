# Project Atlas — GitHub ↔ ChatGPT Integration

This document defines how ChatGPT, Codex, and the GitHub repository work together as one Project Atlas operating system.

## Canonical authority

- The canonical Atlas methodology is the `atlas/` directory on the repository default branch.
- The permanent framework is exactly 25 source files in `atlas/sources/`, numbered `00` through `24`.
- `atlas/config/modules.json` is the machine-readable router.
- `atlas/config/scoring.yaml` is the scoring authority.
- `atlas/prompts/project-atlas-system.md` is the reusable system prompt.
- `atlas/state/` contains persistent decision state, not permanent methodology.
- Conversation uploads, pasted text, and local copies are working inputs until synchronized through a reviewed GitHub change.

## ChatGPT boot sequence

When the user invokes `@GitHub` and asks to run or use Project Atlas:

1. Resolve the repository as `klopez99/chatgpt` unless the user names another repository.
2. Read `atlas/prompts/project-atlas-system.md`.
3. Read `atlas/config/modules.json`.
4. Start with `atlas/sources/00_Atlas_Master_Index_and_Router.txt`.
5. Select the run mode and required domain modules.
6. Load all 25 permanent sources for deep, weekly, or monthly rebuilds.
7. Gather and verify dynamic facts live from appropriate primary sources.
8. Apply scoring, contradiction testing, the No Repeat Rule, and the 10% Conviction Rule.
9. Produce the output required by source `24` and the relevant template.
10. Write persistent thesis changes back through a branch and draft pull request rather than silently altering `main`.

## Command mapping

| User command | Atlas mode | Minimum repository inputs |
|---|---|---|
| `Run Atlas` | Daily material-change scan | Router, core modules, routed domains, output contract |
| `Run Atlas on TICKER` | Company action report | Router, core modules, relevant domains, scoring, action-report template |
| `Deep Atlas rebuild` | Full rebuild | All 25 sources, scoring, all relevant state, deep-rebuild template |
| `Weekly Atlas rebuild` | Weekly rebuild | All 25 sources, current state, rebuild rules |
| `Monthly Atlas rebuild` | Monthly regime rebuild | All 25 sources, current state, macro and portfolio modules |

## Dynamic-data rule

GitHub stores the framework and decision history. It is not the authority for changing external facts.

The following must be checked live before use:

- market prices and valuation inputs
- SEC filings and capital raises
- earnings, guidance, contracts, and backlog
- permits, interconnections, utility filings, and regulatory actions
- laws, policies, appropriations, and officeholders
- analyst estimates, ownership, short interest, and market positioning
- schedules, deadlines, and event timing

Every externally sourced claim should be labeled as fact, inference, estimate, hypothesis, unknown, or unverified according to the Atlas evidence protocol.

## State write-back policy

Persistent state belongs under `atlas/state/`:

- `decision-journal.md` — material conviction changes and decision rationale
- `kill-list.md` — rejected or invalidated theses with explicit reasons
- `watchlists.md` — monitored names, stage, trigger, and next validation event
- `predictions.md` — dated forecasts, probability, horizon, and resolution criteria

A state update should occur only when evidence materially changes conviction, position stage, catalyst probability, risk, or thesis validity. No material change means no forced write-back.

## GitHub change workflow

1. Create an `agent/<description>` branch from the default branch.
2. Change only the files needed for the integration or thesis update.
3. Preserve the exact 25-source architecture unless an explicit migration is approved.
4. Run the Atlas validation scripts for source, router, scoring, or code changes.
5. Open a draft pull request summarizing evidence, impact, validation, and unresolved questions.
6. Merge only after human review.

## Validation

For methodology, routing, scoring, scripts, or source changes:

```bash
python atlas/scripts/validate_atlas.py
python -m unittest discover -s atlas/tests -v
```

Documentation-only or state-only changes should still be checked for correct paths, dates, source labels, and internal consistency.

## Safety and decision boundary

Atlas is an investment-research and decision-structure system. It does not execute trades, guarantee outcomes, or replace independent judgment. Every action-oriented report must include valuation conditions, catalyst timing, confirmation signals, kill conditions, and the next validation event.
