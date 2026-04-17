# Source 08: Firecrawl vs Tavily — официальное сравнение от Firecrawl

**URL:** https://www.firecrawl.dev/alternatives/firecrawl-vs-tavily
**Type:** competitor-comparison (Firecrawl perspective)
**Date:** 2026
**Quality:** B (conflict of interest — Firecrawl сравнивает себя с Tavily)
**Relevant to:** subq3 (прямое сравнение)

## Key facts

- Позиционирование: "Firecrawl handles full web extraction — search, crawl, format. Tavily is better suited to summary-first retrieval."
- **Pricing at high-volume:**
  - Firecrawl: $83/мес (100k credits fixed plan)
  - Tavily: ~$800 PAYG for 100k (10× дороже)
  - **Firecrawl 10× cheaper at 100k volume**
- **SDK coverage:**
  - Firecrawl: Python, Node.js, Rust, Go
  - Tavily: Python async only (меньше)
- Integrations (оба): LangChain, LlamaIndex, n8n, Zapier, Make, MCP
- Proxy support:
  - Firecrawl: can configure own proxies
  - Tavily: not documented
- **Batch API:**
  - Firecrawl: yes (async jobs + webhooks)
  - Tavily: no (request-response only)

## Key quotes

> "Firecrawl handles full web extraction - search, crawl, format. Tavily is better suited to summary-first retrieval."
> "Depends on your use case. Firecrawl is better for building knowledge bases from specific sites (docs, wikis). Tavily excels at retrieving fresh context from multiple sources for agent queries. Use Firecrawl for depth, Tavily for breadth."
> "You can combine them, but Firecrawl's /agent endpoint does a phenomenal job navigating, searching, and gathering web data at scale."

## Notes

- **Bias warning:** Firecrawl's page, поэтому подсвечиваются свои преимущества
- Confirms: разное позиционирование — depth vs breadth
- Honest claim: "Yes, you can combine them" — не отрицает совместное использование
- Gap: не показывает кейсы где Tavily лучше для specific use cases
