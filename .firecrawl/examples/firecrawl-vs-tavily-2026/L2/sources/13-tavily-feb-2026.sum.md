# Source 13: Tavily — What We Shipped: February 2026

**URL:** https://www.tavily.com/blog/what-we-shipped-february-2026
**Type:** official-blog
**Date:** March 6, 2026
**Quality:** A
**Relevant to:** subq5 (Nebius acquisition impact + new features)

## Key facts

- **Nebius acquisition подтверждён официально Tavily**: "Tavily is joining Nebius. Together, we are bringing core AI infrastructure and a production-grade web access layer closer"
- **Официальное заявление Tavily о стабильности:** "The most important thing to say clearly: nothing changes about how you use Tavily today. The API remains the same, your data policies remain the same, and zero data retention remains core"
- **Цель Nebius backing:** "improve latency and uptime, support larger and more complex deployments, invest more deeply in reliability and performance"
- **Новое: Cursor MCP marketplace** — Tavily доступен для coding agent'ов в Cursor
- **Новое: Generative UI Research Canvas** — интеграция с LangChain + Tako + CopilotKit
- **Production case study: Writer** — их Research Agent использует pattern "/search для поиска pages, /extract для pull контента — broad retrieval first, deep extraction second, grounded in live web data"

## Key quotes

> "Nothing changes about how you use Tavily today. The API remains the same, your data policies remain the same, and zero data retention remains core."
> "Writer's Research Agent: The pattern is clean: /search to find the right pages, /extract to pull the full content. Broad retrieval first, deep extraction second, all grounded in live web data."

## Notes

- **Confirms:** acquisition не сломал продукт, API-compatibility сохранена
- **Writer case подтверждает ту же схему, что L1 обнаружил:** discovery (search) → extraction (scrape/extract) — официальный Tavily pattern совпадает с тем что data4ai называл complementary use
- Contradicts fears: нет breaking changes
