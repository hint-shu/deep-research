#!/usr/bin/env bash
# tests/channels/test_subfinder-wrap.sh
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/../lib/asserts.sh"
SF="$SCRIPT_DIR/../../skills/osint-research/channels/subfinder-wrap.sh"

echo "== test_subfinder-wrap =="

# subfinder outputs one subdomain per line. Fixture mimics that.
fixture='api.example.com
mail.example.com
www.example.com'
got=$(bash "$SF" --type domain --target example.com --fixture <(printf '%s' "$fixture"))

assert_contains "$got" "api.example.com" "subdomain parsed"
assert_contains "$got" '"channel":"subfinder"' "channel label"

# Note: PATH=/nonexistent bash ... fails because bash itself isn't in /nonexistent;
# use absolute /bin/bash so bash launches but subfinder is still unresolvable.
PATH=/nonexistent /bin/bash "$SF" --type domain --target example.com >/dev/null 2>&1
assert_exit_code 0 $? "graceful skip when CLI missing"

assert_summary
