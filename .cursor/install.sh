#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap for the Kinnser Nursing Toolkit repo.
# Safe to run repeatedly and against cached/partially-prepared state.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Bootstrapping in ${REPO_ROOT}"

# The default base image ships Python 3.12 without the venv module. The
# Streamline SOC PDF builder needs an isolated virtualenv for pypdf/reportlab.
if ! python3 -c "import ensurepip" >/dev/null 2>&1; then
  echo "==> Installing python3.12-venv"
  sudo apt-get update -qq
  sudo apt-get install -y -qq python3.12-venv
fi

# Root Node prototype declares no runtime/dev dependencies, so there is nothing
# to install for it. package.json is present only to expose `npm test`.

# Python virtualenv for the Streamline SOC PDF builder.
echo "==> Preparing Streamline SOC virtualenv"
cd "$REPO_ROOT/home-health-streamline-soc"
python3 -m venv .venv
# shellcheck disable=SC1091
. .venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt
deactivate

echo "==> Bootstrap complete"
