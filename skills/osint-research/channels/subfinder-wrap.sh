#!/usr/bin/env bash
# skills/osint-research/channels/subfinder-wrap.sh
# Wraps the optional subfinder CLI. Silent no-op when CLI is absent.
# Emits NDJSON: one {"channel":"subfinder",...} object per discovered subdomain.
set -uo pipefail

ENTITY_TYPE=""
TARGET=""
FIXTURE=""
while [ $# -gt 0 ]; do
    case "$1" in
        --type)    ENTITY_TYPE="$2"; shift 2;;
        --target)  TARGET="$2";      shift 2;;
        --fixture) FIXTURE="$2";     shift 2;;
        *) echo "subfinder-wrap: unknown flag: $1" >&2; exit 1;;
    esac
done

[ -z "$TARGET" ] && { echo "subfinder-wrap: empty target" >&2; exit 1; }

# subfinder only makes sense for domain/company targets
case "$ENTITY_TYPE" in
    domain|company) ;;
    *) exit 0;;
esac

if [ -n "$FIXTURE" ]; then
    lines=$(cat "$FIXTURE")
elif command -v subfinder >/dev/null 2>&1; then
    lines=$(subfinder -d "$TARGET" -silent 2>/dev/null || true)
else
    # subfinder not installed — silent skip
    exit 0
fi

# Use "|| [ -n "$sub" ]" to catch an unterminated final line (defense-in-depth;
# herestring adds a trailing newline but the pattern is consistent with other channels).
while IFS= read -r sub || [ -n "$sub" ]; do
    [ -z "$sub" ] && continue
    printf '{"channel":"subfinder","record_type":"subdomain","url":"subfinder://%s","content":"%s","metadata":{"target":"%s"}}\n' \
        "$TARGET" "$sub" "$TARGET"
done <<<"$lines"
