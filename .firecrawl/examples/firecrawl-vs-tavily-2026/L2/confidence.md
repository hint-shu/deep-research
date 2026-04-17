# Confidence Grading — Major claims

## High confidence (≥3 independent authoritative sources, recent, no contradictions)

- **Tavily и Firecrawl комплементарны, не взаимозаменяемы** [1, 8, 9, 10, 13, 22] — multiple sources independent
- **Tavily = discovery-first; Firecrawl = extraction-first** [8, 9, 10, 12, 22]
- **Обе системы интегрируются в LangChain, LlamaIndex, MCP** [1, 5, 7, 8, 9, 10]
- **Nebius acquired Tavily Feb 10, 2026** [7, 13, 14, 16, 19]
- **Tavily API compatibility сохранена после acquisition** [13, 14, 15, 16, 19] — официально подтверждено Tavily + Nebius + analyst
- **Tavily returns snippets, Firecrawl returns full page content** [10, 22]
- **Tavily credit pricing:** $0.008 PAYG, $30-500/мес plans [6, 9]
- **Firecrawl pricing:** $16/мес Hobby, $83/мес Standard, $333/мес Growth [2, 3, 9]

## Medium confidence (2 authoritative sources, or 1 authoritative + minor gaps)

- **Writer использует pattern "Tavily search → extract"** для Research Agent [13] — один официальный case study
- **Firecrawl имеет 44,700 GitHub stars** [1, 9] — confirmed but может быть inflated
- **Tavily имеет 3M+ monthly SDK downloads, 1M+ developers** [14] — Nebius release claim, не verified independently
- **$275M deal size** [16] — Bloomberg-sourced, Nebius не confirmed
- **Firecrawl 6-10× cheaper than Tavily at 100K/month** [6, 8, 9] — зависит от plan comparison choice (see C3)

## Low confidence (single source, or contradictions remain)

- **Tavily p95 latency 3.8-4.5s** [7] — single source (competitor bias), контрадикт с [10]
- **Tavily <1s per query** [10] — single independent source, контрадикт с [7]
- **Firecrawl `/agent` лучший для autonomous multi-step research** [11, 20] — только Firecrawl's own blog posts
- **Tavily's new `fast`/`ultra-fast` search_depth** latency numbers [15, 21] — BETA, no independent benchmarks
- **1M+ developer community Tavily** — vendor claim, не измерено независимо

## Unresolved (нужна escalation на L3/L4)

- Реальные production latency comparison между Firecrawl и Tavily — нужны end-to-end benchmarks
- Long-term impact Nebius acquisition (past 1 year) — time will tell
- Сравнение `Firecrawl /agent` vs `Tavily /research` endpoints в реальных deep-research задачах
