#!/usr/bin/env bash
# skills/osint-research/lib/inbound-filter.sh
# Reads NDJSON results from stdin, drops blocklisted ones, writes survivors to stdout.
# Reports `filtered=<N>` on stderr.

set -uo pipefail

# Hardcoded default blocklist. Cannot be shrunk by user — only extended via
# OSINT_EXTRA_BLOCKLIST (comma-separated additional hosts).
DEFAULT_BLOCKLIST="pastebin.com paste.ee ghostbin.com hastebin.com justpaste.it paste.org ix.io \
breached.cc breachforums.is breachforums.st raidforums.com cracked.io \
dehashed.com leakcheck.io intelx.io leak-lookup.com \
doxbin.com doxbin.org doxbin.net \
ddosecrets.com distributeddenialofsecrets.com \
nulled.to leakix.net snusbase.com weleakinfo.to"

EXTRA="${OSINT_EXTRA_BLOCKLIST:-}"
EXTRA="${EXTRA//,/ }"

BLOCKLIST="$DEFAULT_BLOCKLIST $EXTRA"

# Build a single anchored regex: (?:^|\.)(host1|host2|...)$ against URL host,
# and a content regex matching any blocklisted host as a substring.
# Tokens are validated to be hostname-shaped before inclusion so they cannot
# inject regex metachars or shell metachars.
host_alt=""
for h in $BLOCKLIST; do
    [ -z "$h" ] && continue
    [[ "$h" =~ ^[a-zA-Z0-9.-]+$ ]] || continue
    esc=$(printf '%s' "$h" | sed 's/\./\\./g')
    host_alt="${host_alt}|${esc}"
done
host_alt="${host_alt#|}"

# Per-line processing in python so JSON-escapes (\/, \", \\, \uXXXX) decode
# correctly before the blocklist regex runs. Earlier pure-perl regex extraction
# was bypassed by valid JSON encodings of the URL (escaped slashes) and content
# (escaped quotes / unicode escapes), letting blocklisted hosts through.
_py_tmp=$(mktemp)
trap 'rm -f "$_py_tmp"' EXIT
cat > "$_py_tmp" <<'PY'
import os, re, sys, json

host_alt = os.environ.get("HOST_ALT", "")
if not host_alt:
    # No tokens — pass through unchanged but still report the count.
    for line in sys.stdin:
        sys.stdout.write(line)
    print("filtered=0", file=sys.stderr)
    sys.exit(0)

host_re = re.compile(r"(?:^|\.)(?:" + host_alt + r")$", re.IGNORECASE)
content_re = re.compile(r"\b(?:" + host_alt + r")\b", re.IGNORECASE)
url_host_re = re.compile(r"^https?://(?:[^/@]*@)?([^/]+)", re.IGNORECASE)

filtered = 0
for raw in sys.stdin:
    line = raw.rstrip("\n")
    if not line:
        continue
    try:
        rec = json.loads(line)
    except Exception:
        # Malformed JSON: drop silently to be safe (don't pass through
        # something whose contents we can't inspect).
        filtered += 1
        continue

    url = rec.get("url", "") or ""
    content = rec.get("content", "") or ""

    blocked = False

    if isinstance(url, str):
        m = url_host_re.match(url)
        if m and host_re.search(m.group(1)):
            blocked = True

    if not blocked and isinstance(content, str) and content_re.search(content):
        blocked = True

    if blocked:
        filtered += 1
    else:
        # Re-emit the original line verbatim so downstream sees identical bytes.
        sys.stdout.write(line + "\n")

print(f"filtered={filtered}", file=sys.stderr)
PY

HOST_ALT="$host_alt" python3 "$_py_tmp"
