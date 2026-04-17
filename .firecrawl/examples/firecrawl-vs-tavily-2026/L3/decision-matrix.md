# Decision Matrix — Firecrawl vs Tavily (vs Combined)

## User profile assumptions

**Target user:** Developer building RAG/research pipelines with LLM-based synthesis (Claude/GPT/Gemini). Mid-volume (1K-100K operations/month). Mix of mainstream and technical content sources.

**Not targeted here:** Enterprise buyers needing SOC2/SLA, teams with heavy anti-bot requirements (hostile targets like Amazon/Zillow), air-gapped self-hosting users. These require different recommendations.

## Criteria (weighted)

| Criterion | Weight | Why it matters for target user |
|-----------|:------:|-------------------------------|
| **Pipeline fit** | 25% | Core question — does it solve the research workflow? |
| **Cost predictability** | 20% | Per-month budget; surprise costs erode trust |
| **DX & integration** | 15% | LangChain/MCP ease; time-to-first-value |
| **Content quality** | 15% | LLM-ready output reduces post-processing |
| **Reliability on main targets** | 10% | Success rate on typical tech/docs/news (not hostile) |
| **Long-term stability** | 10% | Risk of vendor change, acquisitions, deprecations |
| **Open source / escape hatch** | 5% | Self-hosting если нужно |

## Options scored

| Option | Pipeline fit | Cost | DX | Content | Reliability | Stability | OSS | **Weighted** |
|--------|:------:|:-----:|:---:|:---:|:---:|:---:|:---:|:------:|
| **Firecrawl only** | 7 | 8 | 8 | 9 | 7 | 8 | 9 | **7.80** |
| **Tavily only** | 8 | 6 | 9 | 7 | 8 | 6 | 4 | **7.20** |
| **Combined (both)** | 10 | 6 | 7 | 9 | 8 | 7 | 6 | **8.10** |

**Scores взяты из подтверждённых L2+L3 данных с critic-adjusted weights:**
- Firecrawl reliability: 7 (65% anti-bot из [30], но 80%+ на стандартных сайтах)
- Cost для Firecrawl-only: 8 (dominant при pure-scrape use cases)
- Cost для Combined: 6 (двойная стоимость — платишь обоим)
- Stability Tavily: 6 (свежая acquisition, long-term unknown)

## Winner: **Combined (Tavily + Firecrawl)** — 8.10

**Почему combined обгоняет:**

- Tavily solves discovery лучше (started-from-question, [25])
- Firecrawl solves deep extraction лучше (full content, schema-based [1, 9, 10])
- Pattern подтверждён production (Writer [13], хотя Writer-specifically Tavily-only — fact-check [5])
- Bloom в tools eсt duplication, но overall cost stays manageable на free+Hobby tiers

## When to pick **Firecrawl only** instead

- **Pure known-URL scraping** — у тебя уже есть list URLs (docs, wikis, known competitors)
- **High-volume** (50K+ scrapes/мес) — Firecrawl dramatically дешевле
- **Self-hosting required** — AGPL-3.0 core доступен (но /agent, /browser, Fire-engine недоступны self-hosted [26])
- **JSON schema extraction** — Firecrawl's native feature с Pydantic support [1]
- **Need webhooks** — Firecrawl поддерживает HMAC-signed webhooks, Tavily no [9, 24]

## When to pick **Tavily only** instead

- **Discovery > extraction** — нужно много разных запросов, мало scrape'ов
- **Quick RAG prototyping** — fastest LangChain integration [12]
- **Citation-ready output** — Tavily returns scored, ranked, citation-friendly snippets [5]
- **Need for due-diligence/compliance** — Tavily `exact_match` (Feb 2026 [15])
- **Agent loops with short queries** — low-latency `fast`/`ultra-fast` search_depth (Dec 2025 BETA [15, 21])

## When to pick **neither** (go elsewhere)

- **Anti-bot warfare** (Amazon, Zillow, Cloudflare-protected) — use Scrapfly (99%) or Bright Data (98.44%) [30, 31]
- **10M+ pages/month** — self-hosted Firecrawl eventually cheaper, но specialized providers часто лучше value [24]
- **Semantic search без scraping** — Exa (neural-based, own index) [7]
- **Answer-engine (не raw materials)** — Perplexity Sonar если не хочешь LLM synthesis step [11, 18]

## Critical caveats from fact-check and critic review

- **Firecrawl 65% success on Scrapeway benchmark [30]** — anti-bot handling weaker than specialized scrapers
- **"6-10× cheaper" compares different operations** (scrape vs search) — multiplier valid at similar use, misleading cross-endpoint
- **Nebius stability: 2 months evidence only** — long-term (6-18 мес) still monitor
- **Selection bias in research:** 13 of 22 L2 sources vendor-authored — real-user voice underrepresented
