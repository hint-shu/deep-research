#!/usr/bin/env bash
# tests/security/test_no_plaintext_secrets.sh
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../lib/asserts.sh"

echo "== test_no_plaintext_secrets =="
REDACT="$SCRIPT_DIR/../../skills/osint-research/lib/secret-redactor.sh"

# Construct seed values at runtime so this source file does not contain
# format-valid secret patterns that would trip GitHub Push Protection or
# similar partner-pattern scanners. Each seed is built to satisfy the
# corresponding regex in secret-patterns.txt at runtime; the redactor
# must then truncate or label it.
repeat() { local c="$1" n="$2"; printf "%${n}s" "" | tr ' ' "$c"; }

SEEDS=(
    "AKIA$(repeat A 16)"
    "ghp_$(repeat A 36)"
    "xoxb-$(repeat 0 10)-$(repeat 0 10)-$(repeat A 24)"
    "sk_live_$(repeat A 28)"
    "AC$(repeat 0 32)"
    "AIzaSy$(repeat A 33)"
)

INPUT=""
for s in "${SEEDS[@]}"; do INPUT="$INPUT seed=$s "; done
got=$(printf '%s' "$INPUT" | bash "$REDACT")

for s in "${SEEDS[@]}"; do
    assert_not_contains "$got" "$s" "seeded $s NOT in output"
done

assert_summary
