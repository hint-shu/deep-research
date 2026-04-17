# Contradictions found

## C1: Tavily latency — значительное расхождение

**Source A** ([10] data4ai, March 2026): "Tavily: <1s per query"
**Source B** ([7] Exa vs Tavily): "Tavily p95 latency: 3.8-4.5s, fastest search latency 210-420ms"

**Analysis:**
- Exa — конкурент Tavily, имеет bias в сторону подсветить свои преимущества
- Data4ai — независимый analyst, но источник latency могли быть Tavily claims
- Объяснение: разные search_depth имеют разную латентность. `ultra-fast` (Dec 2025) оптимизирован для < 1s, `advanced` может занимать 3-5s. Возможно Exa замерял advanced, а data4ai — default/fast
- Подтверждение от [21] Tavily Search API docs: 4 уровня search_depth (basic/advanced/fast/ultra-fast) означают существенно разную латентность

**Resolution:** **Оба правы в зависимости от search_depth.** Низкая латентность (<1s) достижима с `fast`/`ultra-fast` (Dec 2025 BETA). Высокая p95 (3-5s) — default advanced. Уточнить в отчёте что latency = function of search_depth choice.

## C2: Стабильность Tavily после Nebius acquisition

**Source A** ([7] Exa perspective): "Acquisitions can change product roadmaps, pricing, API contracts, and support priorities. Teams using or evaluating Tavily should monitor how Nebius integrates the product."
**Source B** ([13] Tavily official): "Nothing changes about how you use Tavily today. The API remains the same, your data policies remain the same, and zero data retention remains core."

**Analysis:**
- Exa — конкурент, мотивирован подсветить uncertainty
- Tavily — продукт, мотивирован успокоить клиентов
- Объективная картина из [14, 15, 16]: brand continues, CEO stays, API-compat preserved, активные релизы продолжаются (Feb/March 2026 ship-log). Deal value $275M (из [16]) — серьёзный investment, не liquidation.

**Resolution:** **Tavily правее на short-to-medium term.** Нет objective evidence of breaking changes. Risk реален, но не реализовался за 2 месяца. Long-term (1+ year) всё ещё нужен monitoring.

## C3: Pricing comparison at scale

**Source A** ([8] Firecrawl, [9] Apify): "Firecrawl 10× cheaper at 100k volume" ($83/mo vs $800 PAYG)
**Source B** (implicit from [6] Tavily pricing docs): Tavily Growth plan $500/mo for 100K — cheaper than $800 PAYG

**Analysis:**
- [8, 9] сравнивают с Tavily PAYG ($0.008/credit), не с Growth plan
- Tavily Growth ($500/mo, $0.005/credit) при 100K = $500, не $800
- Firecrawl Standard ($83/mo) всё равно 6× дешевле Tavily Growth, но не 10×

**Resolution:** **Все правы в своих frames.** Firecrawl dramatically дешевле для pure scraping at volume. Tavily Growth plan выгоднее PAYG если use case стабилен. Уточнить в отчёте: **exact multiplier зависит от plan choice.**

## Summary

3 contradictions found, все резолвятся через дополнительный контекст. Главный take-away: **латентность Tavily зависит от search_depth**, **acquisition impact пока не материализовался**, **pricing multiplier требует точного plan comparison.**
