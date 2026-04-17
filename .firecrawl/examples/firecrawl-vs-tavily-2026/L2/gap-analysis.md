# Gap Analysis

**Based on:** L1/report.md (12 sources, 944 words)

## Unanswered in L1

- **Конкретные benchmark-числа:** L1 упоминает что обе системы заявляют <1s latency, но бенчмарков между ними напрямую не найдено
- **Реальный impact Nebius acquisition:** Feb 2026 прошло 2 месяца — какие изменения уже были в продукте, pricing, roadmap? L1 только отметил риск
- **Tavily `/research` endpoint** — новый в линейке, что он реально делает vs старый `/search`? L1 упомянул вскользь
- **Firecrawl `/agent` vs Firecrawl `/search` + `/scrape`** — разница в реальной работе и cost
- **Реальный опыт интеграции в LangChain/LlamaIndex** — какие gotchas, error handling patterns

## Shallow coverage

- **Rate limits при heavy parallel usage** — упомянуты теоретические значения (100/1000 RPM для Tavily, до 5000 RPM Firecrawl), но нет реальных данных о деградации
- **Self-hosting Firecrawl** — AGPL-3.0 упомянуто, но что требуется инфраструктурно, какие ограничения
- **Robustness на hostile websites** — как обе системы ведут себя с Cloudflare, captcha, JS-heavy SPAs

## Missing perspectives

- **Критики Firecrawl** — ревью в стиле "почему мы ушли с Firecrawl на Y"
- **Критики Tavily после Nebius** — были ли users, которые мигрировали после acquisition?
- **Альтернативы:** Exa, Serper, Perplexity Sonar — где они сильнее чем Firecrawl/Tavily
- **Реальные production metrics** — uptime, support quality, SLA

## Unverified claims

- **"Tavily <1s per query"** (data4ai [10]) vs **"Tavily p95 3.8-4.5s"** (Exa [7]) — прямое противоречие, нужны нейтральные benchmarks
- **"Firecrawl 10× cheaper at 100k"** — правда при use case 100% scrape, но если 50% searches — картина меняется
- **Nebius acquisition Feb 2026** — подтверждено только из Exa (bias warning)
- **1M+ developers Tavily**, **44,700 GitHub stars Firecrawl** — маркетинговые цифры, нужна реальность
