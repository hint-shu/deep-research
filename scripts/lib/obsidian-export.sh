#!/usr/bin/env bash
# =====================================================================
# obsidian-export.sh — sync L5 knowledge vault to user's Obsidian vault
# =====================================================================
#
# Copies the L5 /ultra-research vault structure into the user's Obsidian
# vault with proper wiki-links, YAML frontmatter, and tags so the
# research is immediately browseable with Obsidian's graph view,
# backlinks, and search.
#
# Optional — only runs when OBSIDIAN_VAULT env var points to a real
# Obsidian vault. Otherwise exits cleanly (0) with a "skipped" status.
#
# Usage from inside a skill's pipeline:
#
#   source "$HOME/.claude/scripts/lib/obsidian-export.sh"
#   export_l5_to_obsidian "<slug>"
#
# Or as a standalone CLI:
#
#   bash scripts/lib/obsidian-export.sh <slug>
#
# Environment variables:
#   OBSIDIAN_VAULT           — absolute path to Obsidian vault root (required)
#   OBSIDIAN_RESEARCH_FOLDER — subfolder name in vault (default: "Research")
#   DEEP_RESEARCH_BASE_DIR   — where L5/ artifacts live (default: .firecrawl/research)
#
# =====================================================================

set -u

OBSIDIAN_RESEARCH_FOLDER="${OBSIDIAN_RESEARCH_FOLDER:-Research}"
DEEP_RESEARCH_BASE_DIR="${DEEP_RESEARCH_BASE_DIR:-.firecrawl/research}"

# --- Internal helpers --------------------------------------------------

# Convert a filename to an Obsidian-style wiki-link target (strip .md)
_to_wikilink() {
    basename "$1" .md
}

# Generate YAML frontmatter for Obsidian notes — tags, created date, source
_yaml_frontmatter() {
    local slug="$1"
    local doc_type="$2"   # e.g. "executive-summary" / "report" / "playbook"
    local query="$3"
    local date
    date=$(date +%Y-%m-%d)

    cat <<YAML
---
tags: [research, deep-research, L5, ${doc_type}]
created: ${date}
slug: ${slug}
type: ${doc_type}
query: "${query}"
---

YAML
}

# --- Main export function ----------------------------------------------

export_l5_to_obsidian() {
    local slug="$1"
    local src_dir="${DEEP_RESEARCH_BASE_DIR}/${slug}/L5"
    local status_file="${src_dir}/obsidian-sync.status"

    # Write to status file only when src_dir exists; otherwise just stderr.
    # Prevents cosmetic mkdir/tee errors when helper is invoked on a slug
    # that hasn't produced L5 artifacts yet (opt-out flow).
    _status() {
        local msg="$1"
        if [ -d "$src_dir" ]; then
            echo "$msg" | tee "$status_file" >&2
        else
            echo "$msg" >&2
        fi
    }

    # --- 1. Opt-out checks ---
    if [ -n "${DEEP_RESEARCH_DISABLE_OBSIDIAN:-}" ]; then
        _status "SKIPPED: Obsidian sync disabled via DEEP_RESEARCH_DISABLE_OBSIDIAN"
        return 0
    fi

    if [ -z "${OBSIDIAN_VAULT:-}" ]; then
        _status "SKIPPED: OBSIDIAN_VAULT env var not set — L5 vault stays in ${src_dir}"
        return 0
    fi

    if [ ! -d "$OBSIDIAN_VAULT" ]; then
        _status "ERROR: OBSIDIAN_VAULT=${OBSIDIAN_VAULT} — directory does not exist"
        return 1
    fi

    # Verify it's actually an Obsidian vault (has .obsidian dir — soft check)
    if [ ! -d "$OBSIDIAN_VAULT/.obsidian" ]; then
        echo "WARN: OBSIDIAN_VAULT=${OBSIDIAN_VAULT} has no .obsidian/ subdirectory (not a real vault?) — syncing anyway" >&2
    fi

    # --- 2. Verify L5 source exists ---
    if [ ! -d "$src_dir" ]; then
        _status "ERROR: L5 source directory not found: ${src_dir}"
        return 1
    fi

    local main_report="${src_dir}/01-main-report.md"
    if [ ! -f "$main_report" ]; then
        # Fallback for partial L5 runs
        main_report="${src_dir}/report.md"
    fi

    if [ ! -s "$main_report" ]; then
        _status "ERROR: No main report found in ${src_dir}"
        return 1
    fi

    # --- 3. Extract query from frontmatter or first heading ---
    local query
    query=$(grep -m1 -oE '\*\*Query:\*\* [^\n]+' "$main_report" 2>/dev/null | sed 's/\*\*Query:\*\* //' | tr -d '"' | head -c 200)
    query="${query:-$slug}"

    # --- 4. Create destination ---
    local dest_dir="${OBSIDIAN_VAULT}/${OBSIDIAN_RESEARCH_FOLDER}/${slug}"
    mkdir -p "$dest_dir"

    # --- 5. Copy all L5 .md files with YAML frontmatter injected ---
    local copied=0
    for src_file in "$src_dir"/*.md "$src_dir"/playbooks/*.md "$src_dir"/crew/*.md; do
        [ -f "$src_file" ] || continue

        local rel_path
        rel_path=$(echo "$src_file" | sed "s|${src_dir}/||")
        local dest_file="${dest_dir}/${rel_path}"
        mkdir -p "$(dirname "$dest_file")"

        local basename_noext
        basename_noext=$(basename "$src_file" .md)
        local doc_type
        case "$basename_noext" in
            *executive-summary*) doc_type="executive-summary" ;;
            *main-report*|*report*) doc_type="report" ;;
            *glossary*) doc_type="glossary" ;;
            *timeline*) doc_type="timeline" ;;
            *playbook*|*how-to*) doc_type="playbook" ;;
            *counter-argument*) doc_type="counter-arguments" ;;
            *open-question*) doc_type="open-questions" ;;
            *bibliography*) doc_type="bibliography" ;;
            *methodology*) doc_type="methodology" ;;
            *) doc_type="research-artifact" ;;
        esac

        # Skip files that already have YAML frontmatter — don't double-up
        if head -1 "$src_file" | grep -q '^---$'; then
            cp "$src_file" "$dest_file"
        else
            {
                _yaml_frontmatter "$slug" "$doc_type" "$query"
                cat "$src_file"
            } > "$dest_file"
        fi
        copied=$((copied + 1))
    done

    # --- 6. Generate Obsidian-style index note with wiki-links ---
    local index_file="${dest_dir}/00-index.md"
    {
        cat <<INDEX_HEADER
---
tags: [research, deep-research, L5, index]
created: $(date +%Y-%m-%d)
slug: ${slug}
query: "${query}"
---

# ${query}

> **L5 Ultra Research** — complete knowledge vault.
> Imported from [[${slug}]] on $(date +%Y-%m-%d).

## Navigate

INDEX_HEADER

        # List all md files as wiki-links
        for f in "$dest_dir"/*.md; do
            [ -f "$f" ] || continue
            local basename_noext
            basename_noext=$(basename "$f" .md)
            # Skip the index itself
            [ "$basename_noext" = "00-index" ] && continue
            echo "- [[${basename_noext}]]"
        done

        # Playbooks in subfolder
        if [ -d "${dest_dir}/playbooks" ]; then
            echo ""
            echo "## Playbooks"
            echo ""
            for f in "${dest_dir}/playbooks"/*.md; do
                [ -f "$f" ] || continue
                local basename_noext
                basename_noext=$(basename "$f" .md)
                echo "- [[playbooks/${basename_noext}]]"
            done
        fi

        cat <<INDEX_FOOTER

---

## Source artifacts

Original research files on disk: \`${src_dir}\`

Bibliography entries: [[08-bibliography]] or [[bibliography]]

INDEX_FOOTER
    } > "$index_file"

    # --- 7. Status file for skill to read ---
    _status "SUCCESS: exported ${copied} files to ${dest_dir}"
    return 0
}

# --- Standalone CLI mode ----------------------------------------------

if [ "${BASH_SOURCE[0]}" = "${0:-}" ] || [ -z "${BASH_SOURCE[0]:-}" ]; then
    SLUG="${1:-}"
    if [ -z "$SLUG" ]; then
        cat <<USAGE
Usage: obsidian-export.sh <slug>

Environment variables:
  OBSIDIAN_VAULT            — absolute path to Obsidian vault root (required)
  OBSIDIAN_RESEARCH_FOLDER  — subfolder in vault (default: Research)
  DEEP_RESEARCH_BASE_DIR    — where L5/ lives (default: .firecrawl/research)

Or source this file to get the export_l5_to_obsidian() function.
USAGE
        exit 2
    fi
    export_l5_to_obsidian "$SLUG"
fi
