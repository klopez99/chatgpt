# Home Health agent instructions

## Scope

These instructions govern home-health work in this repository. A nested `AGENTS.md` takes precedence for its subtree. In particular, `atlas/` is outside this contract and has its own instructions.

## Authority

Before changing home-health code, read:

1. `OWNER_CONTRACT.md`
2. `docs/kinnser-nursing-agent-spec.md`
3. `prompts/home-health-charting-system.md`
4. relevant templates and tests

If code and the owner contract disagree, stop the behavior from becoming more autonomous and reconcile the conflict in the same change.

## Non-negotiable rules

- Use only clinician/source-provided facts or approved templates for patient-specific statements.
- Never fabricate findings, vitals, wounds, medications, interventions, responses, communications, orders, or skilled need.
- Missing or contradictory information must surface as QA/VERIFY.
- Never add credential collection or unattended Kinnser/WellSky sign/submit/lock/transmit behavior.
- Never commit PHI, real patient screenshots, credentials, tokens, or production session material.
- Use synthetic fixtures for tests and demos.
- Keep external communications draft-only unless an explicitly approved workflow defines the recipient, payload, authorization, and human approval step.
- For current OASIS rules, use official CMS material rather than memory or secondary summaries.

## Engineering expectations

For every behavior change:

- add or update the narrowest regression test;
- run `npm test`;
- preserve a human-readable failure mode;
- state any remaining uncertainty;
- do not broaden permissions as a side effect of a feature.

Clinical/regulatory changes must include the source and effective date in the PR description.

## Definition of done

A home-health change is done only when the intended workflow is clear, tests pass, synthetic fixtures cover the important failure path, privacy boundaries remain intact, and no consequential action was made more autonomous without owner approval.
