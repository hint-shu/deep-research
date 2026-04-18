# Obsidian Auto-Sync for L5 (v0.7.0+)

Automatically export L5 `/ultra-research` knowledge vaults into your [Obsidian](https://obsidian.md) vault with wiki-links, YAML tags, and proper folder structure.

---

## Why

L5 produces a complete knowledge base — executive summary, main report, glossary, timeline, playbooks, counter-arguments, bibliography. Sitting in `.firecrawl/research/<slug>/L5/` it's hard to browse, link, and integrate into your existing second-brain workflow.

Obsidian auto-sync copies the whole vault into your Obsidian with:

- **Wiki-links** between all artifacts (`[[01-main-report]]`, `[[08-bibliography]]`)
- **YAML frontmatter** on each note — tags, query, creation date, source slug
- **Tags** for filtering: `#research #deep-research #L5 #playbook`
- **Index note** as the entry point showing the research structure
- **Subfolder** inside your vault: `<vault>/Research/<slug>/` (configurable)

Once imported, the research is immediately browsable with Obsidian's graph view, backlinks panel, and full-text search.

---

## Setup

### 1. Configure the vault path

Set one environment variable pointing to your Obsidian vault root:

```bash
# In ~/.zshrc or ~/.bashrc
export OBSIDIAN_VAULT="$HOME/Documents/MyVault"

# Optional — subfolder inside the vault (default: "Research")
export OBSIDIAN_RESEARCH_FOLDER="Research/Deep"
```

Verify: `ls "$OBSIDIAN_VAULT/.obsidian"` should exist (confirms it's a real Obsidian vault).

### 2. That's it

Next time you run `/ultra-research`, the L5 skill automatically exports the vault to Obsidian as its final step. No extra commands.

---

## Where things go

Example — if you run `/ultra-research MCP protocol knowledge vault` and your `OBSIDIAN_VAULT=~/Documents/MyBrain`:

```
~/Documents/MyBrain/Research/mcp-protocol-knowledge-vault/
├── 00-index.md                   ← entry point with wiki-links
├── 00-executive-summary.md       ← 500-word TL;DR
├── 01-main-report.md             ← 10,000+ word synthesis
├── 02-glossary.md
├── 03-timeline.md
├── 04-key-players.md
├── 05-playbooks/
│   ├── how-to-setup-mcp.md
│   └── how-to-debug-mcp.md
├── 06-counter-arguments.md
├── 07-open-questions.md
├── 08-bibliography.md
├── 09-methodology.md
└── 10-recommended-next-reading.md
```

Every file has YAML frontmatter like:

```yaml
---
tags: [research, deep-research, L5, report]
created: 2026-04-18
slug: mcp-protocol-knowledge-vault
type: report
query: "MCP protocol knowledge vault"
---
```

Index note (`00-index.md`) contains wiki-links so you can navigate the vault fluidly in Obsidian's graph view.

---

## Run manually (without running L5)

Already have an L5 run sitting on disk? Import it retroactively:

```bash
bash ~/.claude/scripts/lib/obsidian-export.sh <slug>
```

Uses `OBSIDIAN_VAULT` env + the `.firecrawl/research/<slug>/L5/` artifacts.

---

## Disable / opt-out

Three ways to skip the Obsidian export:

1. **Don't set** `OBSIDIAN_VAULT` — the skill skips automatically
2. **Explicit opt-out** — `export DEEP_RESEARCH_DISABLE_OBSIDIAN=1`
3. **Point elsewhere** — set `OBSIDIAN_RESEARCH_FOLDER` to a non-Obsidian folder and Obsidian-specific features (wiki-links, frontmatter) still work — just not rendered by the Obsidian app

---

## Things to know

- **No deletes on re-sync.** If you re-run research with the same slug, the script overwrites files in place. Old artifacts removed from source disappear from Obsidian too. Don't edit the imported files directly — they'll be overwritten on next sync. (Add your own companion notes with different filenames.)
- **No Obsidian app required during import.** The sync is just file operations. Obsidian picks up changes next time you open the vault.
- **Vault detection is soft.** The script warns if `.obsidian/` isn't present but continues anyway — use this to export into any markdown-friendly structure.
- **Relative paths aren't converted.** If an L5 file references `../L4/sources/...`, that reference won't work in Obsidian (Obsidian doesn't see the `.firecrawl/` tree). For cross-vault links, use full vault-relative paths in the research content.

---

## Implementation

See [`scripts/lib/obsidian-export.sh`](../scripts/lib/obsidian-export.sh) — ~180 lines, single function `export_l5_to_obsidian()`, called at the end of the L5 skill's pipeline. Same fault-tolerance pattern as Codex helper — returns 0 on success or skip, 1 on actual error.
