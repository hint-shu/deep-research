# Source 21: Tavily — Official Search API docs

**URL:** https://docs.tavily.com/documentation/api-reference/endpoint/search
**Type:** official-docs
**Date:** 2026 (current)
**Quality:** A
**Relevant to:** subq4, subq5 (Tavily features, latency options)

## Key facts

- **Four search_depth options** (с Dec 2025):
  - `basic` — 1 API credit, baseline latency/quality
  - `advanced` — cost higher, deeper analysis
  - `fast` (BETA) — optimized for low latency + high relevance, 1 credit
  - `ultra-fast` (BETA) — strictly latency optimized, 1 credit
- **`exact_match`** (Feb 2026) — boolean, quoted phrases, bypasses synonyms
- **Topic parameter:** general, news, finance
- **Time range:** day, week, month, year, start_date, end_date
- **Domains:** include_domains, exclude_domains для filtering
- **Max results:** default 5, configurable
- Returns: results with score, title, url, content, raw_content (optional)

## Key quotes

> "fast (BETA): Optimized for low latency while maintaining high relevance"

## Notes

- **Confirms:** Tavily Search API существенно расширен в 2025-2026
- `fast` и `ultra-fast` — прямой ответ на latency критику
- exact_match для compliance/due-diligence use cases
- Gap: конкретные latency numbers для fast/ultra-fast не опубликованы в doc, только claims
