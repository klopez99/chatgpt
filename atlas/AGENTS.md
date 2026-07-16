# Project Atlas — Codex Operating Instructions

Project Atlas is an evidence-first investment intelligence system. Its purpose is to convert verified signals into disciplined capital decisions, not to maximize research volume.

## Source architecture

- The canonical operating system is exactly 25 permanent source files in `sources/`, numbered `00` through `24`.
- Start every run with `sources/00_Atlas_Master_Index_and_Router.txt`.
- Use `config/modules.json` to route the question and choose domain modules.
- `Run Atlas` means a material-change scan. `Deep Atlas rebuild`, `weekly rebuild`, and `monthly rebuild` load all 25 sources.
- Dynamic facts never belong in permanent sources. Prices, filings, laws, contracts, permits, officeholders, schedules, and market conditions must be verified live.

## Governing principles

1. Discernment over discovery.
2. No thesis without evidence.
3. Distinguish fact, inference, estimate, hypothesis, unknown, and unverified.
4. Prefer primary sources and actively search for contradictory evidence.
5. Apply the No Repeat Rule: if evidence does not materially change conviction, say `No material change`.
6. Apply the 10% Conviction Rule before promoting alerts.
7. Never invent unknown values or disguise weak evidence with precise scores.
8. Update the Decision Journal and Kill List whenever conviction changes materially.
9. Every thesis needs a deadline, kill conditions, and a next validation event.
10. Never frame outcomes as guaranteed or provide personalized fiduciary advice.

## Required analysis sequence

1. Define the question, time horizon, and domains.
2. Load the router and evidence protocol.
3. Gather fresh public evidence.
4. Route evidence to domain modules.
5. Map bottlenecks and second-order effects.
6. Score the company and thesis using `config/scoring.yaml`.
7. Test market blindness, stealth-compounder conditions, leadership, and capital allocation.
8. Forecast catalysts and validation events.
9. Red-team the thesis.
10. Update decision state and produce the output contract in source `24`.

## Mandatory verdict and stage

Every completed company or asset analysis ends with exactly one verdict: `BUY`, `STARTER`, `WATCH`, `AVOID`, or `REDUCE`. Include position stage, price/valuation condition, catalyst window, invalidation conditions, and next validation event.

Position stages:
- Stage 0 — Research only
- Stage 1 — Starter
- Stage 2 — Confirmation add
- Stage 3 — Execution add
- Stage 4 — Acceleration add
- Stage 5 — Harvest / reduce

## Capital-bucket guardrail

Default conceptual framework unless the user supplies another allocation:
- Foundation capital: 70–80%
- Conviction capital: 15–25%
- Discovery capital: 5–10%

This is risk architecture, not an instruction to trade.

## Validation

Before committing changes to Atlas, run:

```bash
python atlas/scripts/validate_atlas.py
python -m unittest discover -s atlas/tests -v
```
