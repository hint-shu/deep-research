# Fact-check Report — Top 5 Critical Claims

## Claim 1: "Firecrawl 6-10× cheaper than Tavily at 100K volume"

**Source in L2 report:** [6, 8, 9]

**Verification attempts:**
- ✓ Confirmed: [9] Apify comparison: "At 100k pages per month, Firecrawl's Standard plan is roughly 10× cheaper than Tavily's PAYG bucket"
- ✓ Confirmed: [8] Firecrawl's own page: $83/mo (100K) vs Tavily ~$800 PAYG
- ✓ Confirmed: [30] Scrapeway: Firecrawl Standard $83/100K documented
- ? Nuance: Tavily Growth plan at $500/100K — only 6× not 10×

**Verdict:** **CONFIRMED** (High confidence). Multiplier 6-10× depending on Tavily plan choice (PAYG vs Growth). Direction unambiguous — Firecrawl значительно дешевле at scale for pure scraping.

---

## Claim 2: "Tavily API compatibility preserved after Nebius acquisition"

**Source in L2 report:** [13, 14, 15, 19]

**Verification attempts:**
- ✓ Confirmed: [13] Tavily official: "API remains the same, data policies remain the same, zero data retention remains core"
- ✓ Confirmed: [14] Nebius official: "Tavily will continue operating under its current brand"
- ✓ Confirmed: [15] Changelog shows active development post-acquisition (Feb 2026 `exact_match`, March 2026 enterprise endpoints)
- ✓ Confirmed: [19] Futurum analyst consistent
- No contradictions found from indepent sources

**Verdict:** **CONFIRMED** (High confidence). No breaking changes observed 2 months post-acquisition.

---

## Claim 3: "Firecrawl success rate is 99% on anti-bot scraping"

**Source in L2 report:** Implicitly via vendor marketing [1, 3]

**Verification attempts:**
- ✗ **CONTRADICTED:** [30] Scrapeway independent benchmark Apr 2026: Firecrawl **65% success rate** on 11 popular scraping targets (vs 99% for Scrapfly, 89% WebScrapingAPI)
- ✓ Note: 65% is above industry avg (59.5%), but **well below** specialized anti-bot providers
- Scrapfly (99%) and Bright Data (98.44% per [31]) dramatically outperform Firecrawl on hostile targets

**Verdict:** **DISPUTED — downgrade claim.** Firecrawl performs well on standard content sites, but loses on aggressive anti-bot (Cloudflare, Akamai, etc.). If use case requires high success on protected sites → specialized provider needed. Firecrawl's strength is LLM-ready output, not anti-bot wizardry.

---

## Claim 4: "Nebius acquired Tavily for $275M in February 2026"

**Source in L2 report:** [14, 16]

**Verification attempts:**
- ✓ Confirmed: [16] PYMNTS article — Bloomberg-sourced $275M figure
- ✓ Confirmed: [14] Nebius official release — doesn't disclose but doesn't deny
- ✓ Confirmed: [19] Futurum analyst — consistent date/parties
- Note: **$275M is Bloomberg report, not officially disclosed by Nebius**

**Verdict:** **CONFIRMED with caveat.** Deal and Feb 10 date primary-sourced. $275M price from Bloomberg (secondary). Acceptable confidence.

---

## Claim 5: "Production pattern = Tavily search → Firecrawl scrape → LLM synthesis"

**Source in L2 report:** [13] Writer case study

**Verification attempts:**
- ✓ Confirmed primary: [13] Tavily official blog — Writer Research Agent uses "/search to find the right pages, /extract to pull the full content"
- ✓ Partial: [10] data4ai — "they complement each other in a modern AI data pipeline"
- ⚠️ Caveat: Writer uses **Tavily /extract**, not Firecrawl /scrape. L2 report оверсиплифицировало: пайплайн можно делать fully-Tavily OR Tavily+Firecrawl
- ✓ Confirmed supporting: [22] Firecrawl blog admits "Tavily works as a search layer for agents" и advocates combining

**Verdict:** **CONFIRMED with refinement.** Pattern "discovery → extraction" подтверждён. Конкретная комбинация tools зависит от use case. Writer = Tavily-only stack. Complementary-tool stack (Tavily + Firecrawl) рекомендован для deep research use cases [8, 10].

---

## Summary

- CONFIRMED: 3 claims (pricing multiplier direction, API stability, deal details)
- DISPUTED: 1 claim (99% success rate — actually 65% on hostile targets)
- CONFIRMED with refinement: 1 claim (exact pipeline pattern varies)

**Most important correction for final report:** Firecrawl's marketing implies universal high success; reality is 65% on challenging targets. Our L2 report должен быть обновлён to reflect this.
