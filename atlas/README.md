# Project Atlas Action Engine

Project Atlas converts macro, policy, regulatory, company, and market signals into explicit capital decisions.

## Purpose

The system is designed to answer one practical question:

> What should be done with capital now, what evidence would justify adding, and what would invalidate the thesis?

Research that does not change a decision is archived as context rather than promoted as a signal.

## Directory map

```text
atlas/
├── AGENTS.md
├── README.md
├── config/
│   └── scoring.yaml
├── prompts/
│   └── project-atlas-system.md
└── templates/
    ├── action-report.md
    ├── decision-journal.md
    └── kill-list.md
```

## Codex usage

Open this repository in Codex and work inside the `atlas/` directory. Codex will use the scoped `AGENTS.md` instructions.

Example task:

```text
Run Project Atlas on BTC and the Treasury-backed stablecoin thesis. Use current primary sources. Produce an action report, update the Decision Journal and Kill List, and end with one verdict and position stage.
```

Company example:

```text
Run Project Atlas on TICKER. Trace the signal cascade from policy/capex to bottleneck, orders, revenue, estimate revisions, and market recognition. Use scoring.yaml and action-report.md. Do not recommend action without valuation and kill conditions.
```

## Decision workflow

1. **Research:** collect primary evidence and label facts versus inference.
2. **Score:** complete Atlas and Fiscal Transmission scorecards.
3. **Decide:** issue exactly one verdict.
4. **Stage:** assign position stage 0–5.
5. **Journal:** record the decision, assumptions, deadline, and next validation event.
6. **Monitor:** update only when new evidence changes expected value.
7. **Kill or advance:** move the thesis to the Kill List or the next position stage.

## Verdict meanings

- `BUY` — evidence, valuation, and risk support full intended exposure within the correct capital bucket.
- `STARTER` — asymmetric thesis is credible but incomplete; use limited initial exposure with staged-add triggers.
- `WATCH` — potentially attractive, but price, evidence, timing, or risk does not support ownership yet.
- `AVOID` — expected value is unfavorable or the narrative is not supported by evidence.
- `REDUCE` — thesis, valuation, or risk has deteriorated relative to the current position.

## Safety and discipline

Atlas does not execute trades. It produces research and decision architecture for human review. Position sizing must account for liquidity needs, taxes, concentration, drawdown tolerance, and the possibility that a correct thesis can take longer than expected.
