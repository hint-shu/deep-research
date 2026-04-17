# Source 26: Filip Konecny — Firecrawl Limitations (independent critic review)

**URL:** https://filipkonecny.com/2026/03/29/firecrawl-limitations/
**Type:** independent-critic
**Angle:** critic
**Bias estimate:** low (independent blog, realistic assessment)
**Quality:** A
**Date:** March 29, 2026 (свежий)

## Key facts

**Critical Firecrawl limitations:**

1. **Free tier cap:** 500 one-time credits, **rate limits on free:** 10 scrape/min, 1 crawl/min, 5 search/min — "enough for real test, not for fake production confidence"

2. **Cost explosion:** Base 1 credit per page, но **JSON mode adds 4 extra credits**, **enhanced proxy adds 4 extra** — page с обоими = **9 credits fast**

3. **Self-hosting не full cloud parity:**
   - `/agent` не supported в self-hosted
   - `/browser` не supported в self-hosted
   - Fire-engine (anti-bot) — только hosted
   - "Open-source project with stronger hosted product"

4. **Framing:** "Firecrawl limitations are manageable because the core payoff is strong. It gets you from raw web pages to usable data faster, and that usually matters more than saving a small amount of money with a slower setup."

5. **Not a no-brainer:** "product becomes much easier to justify once you already know what you want it to power"

## Key quotes

> "a page that needs both [JSON mode + enhanced proxy] can jump to 9 credits fast"
> "Firecrawl is not really 'buy once, then move everything in-house with zero tradeoffs'; it is better understood as an open-source project with a stronger hosted product"

## Notes

- **Independent critic perspective** — balances vendor marketing
- Confirms pricing surprise concerns from [4]
- **New info:** specific rate limits on free tier, credit multipliers for specific modes
- **Self-hosted limitations серьёзные** — если нужен /agent или anti-bot, hosted обязателен
