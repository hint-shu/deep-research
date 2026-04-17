# Exa MCP Integration (v0.5.0+)

How to use [Exa](https://exa.ai) as a third search/research channel alongside Tavily and Firecrawl.

---

## What Exa adds to the stack

| Existing | Role | What it does well |
|----------|------|-------------------|
| **Firecrawl** | Extraction | Full page scrape, JS rendering, agent navigation |
| **Tavily** | Discovery | LLM-ready snippets, fast search, broad coverage |
| **Codex** (optional) | Cross-model | GPT-5.4 second opinion, different search index |
| **Exa** (v0.5.0+) | **Neural discovery** | Semantic search, own index of billions of docs, academic/technical content |

**Key differentiator:** Exa ranks results by **semantic similarity** (neural embedding), not just keyword match. For "architectures similar to MoE", keyword search finds pages saying "MoE architecture" — Exa finds pages about comparable sparse-expert designs even when they don't use that exact phrase.

---

## Installation

### 1. Get an API key

Sign up at [exa.ai](https://exa.ai). Free tier: 1,000 searches/month. Pay-as-you-go from $0.005/search.

### 2. Install the MCP server

One command:

```bash
claude mcp add --transport http exa \
  'https://mcp.exa.ai/mcp?exaApiKey=YOUR_EXA_KEY&tools=web_search_exa,web_search_advanced_exa,get_code_context_exa,crawling_exa,company_research_exa,people_search_exa,deep_researcher_start,deep_researcher_check'
```

Replace `YOUR_EXA_KEY` with your key. Restart Claude Code after.

Verify:

```bash
claude mcp list | grep exa
# exa: https://mcp.exa.ai/mcp?... - ✓ Connected
```

---

## Available Exa tools (after install)

| Tool | What it does | When skills use it |
|------|--------------|--------------------|
| `mcp__exa__web_search_exa` | Standard neural search | L0/L1/L2 — alternative to Tavily |
| `mcp__exa__web_search_advanced_exa` | With filters (category, domain, date) | L2/L3 — targeted gap-fill, academic |
| `mcp__exa__get_code_context_exa` | Retrieve code-specific context | Technical research on libraries |
| `mcp__exa__crawling_exa` | Structured page extraction | Alternative to Firecrawl scrape |
| `mcp__exa__company_research_exa` | Company info lookup | Business/market research |
| `mcp__exa__people_search_exa` | People search | Author/expert discovery |
| `mcp__exa__deep_researcher_start` | Start multi-step research task | L5 — kick off deep reasoning |
| `mcp__exa__deep_researcher_check` | Poll deep research status | L5 — retrieve structured answer |

---

## Per-tier integration

### L0 `/quick-research`

Exa is an **optional alternative** to Tavily for fact-checks. Can pick whichever returns faster for a given query.

```
mcp__exa__web_search_exa with:
  query: <fact-check query>
  num_results: 5
  type: "auto"
```

Result: 5 ranked URLs with 20k chars of content each (Full Text mode). No scraping needed — content already in response.

### L1 `/research`

Parallel channel alongside Firecrawl search + Tavily search. **Complements** Tavily by using a different index.

```
mcp__exa__web_search_exa with:
  query: <subq>
  num_results: 5
  type: "auto"
  contents: { text: { max_characters: 20000 } }
```

When Exa and Tavily disagree on top URLs → signal to scrape both. Disagreements often point to contradictions worth surfacing.

### L2 `/deep-research`

Exa `web_search_advanced_exa` for **gap-fill step** alongside Codex. When the L2 reflection identifies a specific gap ("missing critic perspective on X"), Exa's neural search is better at finding framework-level alternatives.

```
mcp__exa__web_search_advanced_exa with:
  query: <gap description>
  category: "news"  # or "research paper" for technical gaps
  num_results: 8
  type: "auto"
```

### L3 `/expert-research`

For **neutral-angle research** (Step 2.1 in skill), Exa with category filters beats keyword search:

```
mcp__exa__web_search_advanced_exa with:
  query: <original query>
  category: "research paper"  # or "news" depending on topic
  type: "auto"
  num_results: 10
```

Good for finding dissenting academic views or independent benchmarks.

### L4 `/academic-research`

**Major upgrade.** Previously L4 used Tavily with "academic" keywords — unreliable. Exa has a **native research paper index**:

```
mcp__exa__web_search_advanced_exa with:
  query: <academic sub-question>
  category: "research paper"
  type: "auto"
  num_results: 15
  contents: { text: { max_characters: 20000 } }
```

Result: ranked papers from arXiv, paperswithcode, academic preprint servers with full text. This is the biggest reason to add Exa.

### L5 `/ultra-research`

Use Exa's own deep-researcher mode for exhaustive coverage of specific sub-topics — async pattern:

```
# Step 1: Kick off
mcp__exa__deep_researcher_start with:
  query: <complex research question>

# Step 2: Poll (can take 1-5 minutes)
mcp__exa__deep_researcher_check with:
  id: <research_id_from_start>
```

Returns structured answer with grounded citations. Good for saturation-seeking at L5's knowledge-vault level.

---

## Exa vs Tavily vs Codex — decision matrix

| Scenario | Best choice |
|----------|-------------|
| Quick fact-check with citations | **Tavily** (bundled snippets) or Exa — roughly equivalent |
| Broad topic discovery (many URLs) | **Tavily** — proven wider coverage |
| Semantic search ("things like X") | **Exa** — neural ranking shines |
| Academic papers | **Exa category=research paper** |
| Company info | **Exa category=company** |
| Cross-model verification (2nd opinion) | **Codex** — different MODEL, not just different index |
| Avoiding SEO-spam | **Exa** (curated index) > Tavily > Firecrawl search |
| Max single-query depth | **Exa deep_researcher** — internal multi-step |

**Not mutually exclusive.** L2+ skills can run Tavily + Exa + Codex in parallel. Each adds a different dimension: Tavily=coverage, Exa=semantic, Codex=cross-model.

---

## Cost considerations

Exa pricing (as of Apr 2026):
- Free: 1,000 searches/month
- PAYG: $0.005/search (Tavily is $0.008)
- "Deep" mode: more expensive per query
- Full text mode (our default) vs highlights: same search cost, different content bytes returned

For our ladder with typical usage:
- L0-L1: maybe 5-20 Exa calls/session — within free tier for most users
- L2-L3: 20-40 Exa calls/session — may hit free tier monthly
- L4-L5: 80-150 Exa calls/session — expect to pay

**Free tier rule of thumb:** covers ~30 L1 sessions/month or ~5 L3 sessions.

---

## Disabling Exa

Skills check for Exa's MCP tools before calling. If not installed (or opt-out via env):

```bash
export DEEP_RESEARCH_DISABLE_EXA=1
```

Skills fall back to Tavily+Firecrawl only. Same graceful-degradation pattern as Codex.

---

## Known limitations

- **Exa's "deep" mode** can hit rate limits at free tier — prefer `type: "auto"` for most calls
- **Category filters are restrictive** — if you get 0 results with `category: "research paper"`, retry without the filter
- **Full text mode** can dump 20k chars per result × 10 results = 200k chars into a response — use `max_characters` to limit if context bloat matters
- **Not a scrape replacement** — Exa's `crawling_exa` works but Firecrawl handles hostile sites better (anti-bot, JS-heavy SPAs)
