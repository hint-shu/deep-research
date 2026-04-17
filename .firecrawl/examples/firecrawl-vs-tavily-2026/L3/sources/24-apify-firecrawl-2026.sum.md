# Source 24: Use-Apify — Firecrawl Review 2026

**URL:** https://use-apify.com/blog/firecrawl-review-2026
**Type:** third-party-review (Apify competitor)
**Angle:** neutral (but Apify is competitor)
**Bias estimate:** medium
**Quality:** B
**Date:** 2026

## Key facts

**Detailed pros/cons table:**

Pros:
- Single API call replaces scraper + proxy + browser setup
- LLM-native output (Markdown, JSON schema)
- MCP server for Claude Desktop, Cursor, Windsurf, VS Code
- Webhooks for production crawl pipelines
- Open-source core (MIT — **contradicts AGPL-3.0 из других источников** — нужна проверка)
- Browser Sandbox для interactive/authenticated scraping

Cons:
- **Free tier is only 500 lifetime credits (not monthly)**
- **Fire-engine (anti-bot) not available in self-hosted**
- **Credits don't roll over** on standard plans
- **No built-in scheduler** — manage cron externally
- At 10M+ pages/mo, self-hosted cheaper
- **FIRE-1 agent requests always billed even on failure**

Webhooks signed HMAC-SHA256, events: `crawl.page`, `crawl.completed`, `crawl.failed`

## Key quotes

> "FIRE-1 agent requests always billed even on failure"
> "Fire-engine (anti-bot) not available in self-hosted version"

## Notes

- **Surfacing critical gotchas** L1/L2 пропустил
- **Contradicts** previous sources on license: "MIT" vs "AGPL-3.0" — need resolution (может разные components: core AGPL, MCP server MIT)
- Important for production cost estimation — FIRE-1 billing on failure может быть expensive
