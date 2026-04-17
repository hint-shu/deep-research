# Research examples

Real research outputs preserved as live examples. Every folder here was produced by running the skills on an actual query. These are committed to the repo (whitelisted in `.gitignore`) so new users can see what the pipeline output looks like without running research themselves.

---

## Available examples

### `firecrawl-vs-tavily-2026/` (v0.2.2 live test, added v0.3.0)

- **Levels executed:** L1 → L2 → L3 (full end-to-end)
- **Query:** "Firecrawl vs Tavily для research-пайплайнов в 2026 — когда что использовать, сильные и слабые стороны"
- **Generated:** 2026-04-17
- **Total sources:** 32 (12 L1 + 10 L2 + 10 L3)
- **Codex cross-model channel:** tested under real failure conditions — RATE_LIMITED (L2) and TIMEOUT (L3 x2); v0.2 helper correctly degraded to single-model mode
- **Subagent critic review:** executed successfully (~1200 words, integrated into L3 synthesis)
- **All verification checkpoints passed:** 4× L2 + L3 final (multi-citation safe regex from v0.2.2)

**Files worth reading:**

- `L1/report.md` — 944-word base synthesis with 12 sources
- `L1/sources/` — 12 full page scrapes + per-source summaries
- `L2/report.md` — 1511-word deep-research synthesis with contradictions
- `L2/contradictions.md` — 3 identified contradictions, all resolved with cross-source analysis
- `L2/confidence.md` — H/M/L grading per major claim
- `L2/codex-gap.md.status` — evidence of v0.2 Codex helper RATE_LIMITED path
- `L3/report.md` — 1777-word expert-level synthesis with critic integration
- `L3/critic-report.md` — adversarial subagent review findings
- `L3/fact-check.md` — 5 critical claims verified/disputed/refined
- `L3/decision-matrix.md` — weighted option scoring
- `L3/executive-summary.md` — 561-word stakeholder summary

**Verify this example with the shared library** (v0.3.0+):

```bash
# From the repo root
DEEP_RESEARCH_BASE_DIR=.firecrawl/examples \
    bash scripts/lib/verify-research.sh l1 firecrawl-vs-tavily-2026
# Output: ✅ L1 VERIFIED: 12 scrapes, 12 summaries, 944-word report, citations traceable

DEEP_RESEARCH_BASE_DIR=.firecrawl/examples \
    bash scripts/lib/verify-research.sh l2 firecrawl-vs-tavily-2026
# Output: ✅ All 4 L2 CHECKPOINTs PASSED

DEEP_RESEARCH_BASE_DIR=.firecrawl/examples \
    bash scripts/lib/verify-research.sh l3 firecrawl-vs-tavily-2026
# Output: ✅ L3 FINAL CHECKPOINT PASSED: 1777-word report, 10 L3 sources, critic + fact-check verified
```

This is a great way to see what the verification library actually checks.

---

### `codex-cli-research-agent/` (L3 — v0.1 release test)

- **Level:** L3 (expert-research)
- **Query:** "Best practices for using Codex CLI as a research agent"
- **Generated:** 2026-04-16
- **Sources:** 22+
- **Context:** The research that informed the Codex integration design documented in [docs/CODEX_INTEGRATION.md](../../docs/CODEX_INTEGRATION.md).

Note: this example predates the v0.1.1 verification checkpoints and v0.2.2 citation-regex fix — it has some artifact-structure inconsistencies (e.g., not all `L*/sources/*.sum.md` files exist). It is preserved as the history of how the Codex integration came about, not as a reference-quality artifact. For reference-quality output, see `firecrawl-vs-tavily-2026/`.

---

## Adding a new example

When you run a research session that produced an exemplary output, contribute it here:

1. Move the folder from `.firecrawl/research/<slug>/` → `.firecrawl/examples/<slug>/`
2. Add an entry in this README with tier, query, date, source count
3. Run the verification library to confirm all checkpoints pass:
   ```bash
   DEEP_RESEARCH_BASE_DIR=.firecrawl/examples \
       bash scripts/lib/verify-research.sh lN <slug>
   ```
4. **Verify no secrets or sensitive info** — these examples go in the public repo
5. Open a PR

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for more.
