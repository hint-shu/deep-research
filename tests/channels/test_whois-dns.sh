#!/usr/bin/env bash
# tests/channels/test_whois-dns.sh
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../lib/asserts.sh"
WD="$SCRIPT_DIR/../../skills/osint-research/channels/whois-dns.sh"

echo "== test_whois-dns =="

# example.com is RFC reserved and stable. Allow integration test to skip if no network.
if ! command -v whois >/dev/null || ! command -v dig >/dev/null; then
    echo "  SKIP: whois/dig missing"
    assert_summary
    exit 0
fi

got=$(bash "$WD" --type domain --target example.com 2>/dev/null || true)
assert_contains "$got" "example.com" "result references target"
assert_contains "$got" '"channel":"whois-dns"' "channel label present"
assert_contains "$got" '"record_type"' "structured records"

# Invalid input
bash "$WD" --type domain --target "" >/dev/null 2>&1
assert_exit_code 1 $? "empty target fails"

assert_summary
