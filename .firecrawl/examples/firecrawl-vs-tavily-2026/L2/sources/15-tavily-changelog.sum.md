# Source 15: Tavily — Official Changelog

**URL:** https://docs.tavily.com/changelog
**Type:** official-docs
**Date:** обновляется постоянно (самые свежие: March 2026)
**Quality:** A
**Relevant to:** subq5 (новые features)

## Key facts

Recent releases (последние 6 месяцев):

- **March 2026:** Enterprise API key management endpoints (generate/deactivate/info)
- **February 2026:** `exact_match` parameter для Search — поиск exact quoted phrases, bypasses synonyms/semantic variations; для due diligence, legal, compliance
- **January 2026:** Project tracking through `X-Project-ID` header — trackusage по projects когда один API key shared
- **December 2025:** new `search_depth` options — **`fast`** (BETA, low latency + high relevance, 1 credit) and **`ultra-fast`** (BETA, strictly latency, 1 credit)
- **December 2025:** Intent Based Extraction (в доке далее)
- **August 2025:** Team roles & permissions (Owner/Admin/Member)

## Key quotes

> "`fast` (BETA): Optimized for low latency while maintaining high relevance to the user query. Cost: 1 API Credit"
> "`ultra-fast` (BETA): Optimized strictly for latency. Cost: 1 API Credit"

## Notes

- **Confirms** что Tavily актівно developing ПОСЛЕ acquisition announcement (Feb → March)
- **`fast` и `ultra-fast` search_depth** отвечают на latency concerns из L1
- Enterprise features (API key management, project tracking, roles) — Tavily движется в enterprise-grade direction
- Gap: не показаны deprecations или breaking changes (если были)
