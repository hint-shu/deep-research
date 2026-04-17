# Firecrawl vs Tavily для research-пайплайнов в 2026 — L3 Expert Report

**Query:** Firecrawl vs Tavily для research-пайплайнов в 2026 — когда что использовать, сильные и слабые стороны
**Level:** L3 (Expert) — includes L1, L2
**Sources:** 12 (L1) + 10 (L2) + 10 (L3) = 32
**Generated:** 2026-04-17

---

## Executive Summary

Firecrawl и Tavily — два AI-native инструмента для research/RAG-пайплайнов с **чётко различными ролями**: Tavily оптимизирован для **discovery** (стартует с вопроса, возвращает ранжированные URL + снипеты), Firecrawl — для **deep extraction** (полный контент в markdown/JSON из known URLs + agent-level навигация). Для deep research pipelines рекомендуется **комбинированный подход** (Tavily search → Firecrawl scrape → LLM synthesis), хотя Writer production case [13] показывает что полный Tavily-only stack также возможен.

**Ключевые корректировки после critic review и fact-check:**

1. **Firecrawl success rate не 99%, а 65%** на независимом Scrapeway benchmark с anti-bot targets [30]. На стандартных tech/docs/news сайтах — выше. Не использовать Firecrawl для hostile anti-bot workloads — там нужны Scrapfly (99%) или Bright Data (98.44%) [30, 31].

2. **"Firecrawl 6-10× дешевле Tavily" — валидно только для pure scrape use case.** Сравнение scrape credits vs search credits — unit mismatch. Для discovery-heavy use cases (many searches + few scrapes) Tavily может быть выгоднее.

3. **Nebius acquisition Tavily (Feb 2026, $275M)** — 2 месяца post-acquisition не показали breaking changes; API/brand/CEO сохранены, active development продолжается [13, 14, 15]. Но long-term (6-18 мес) риск остаётся — monitor.

4. **Firecrawl self-hosting — не full cloud parity:** `/agent`, `/browser`, Fire-engine не доступны self-hosted [26]. Если нужны эти features — только hosted.

5. **FIRE-1 agent requests billed even on failure [24]** — важный cost pitfall для production budgeting.

**Recommendation:** Для L0-L5 research ladder бери комбинированный подход. Free tiers (Firecrawl 500 one-time + Tavily 1000/мес) покрывают ~20 L1 research sessions/мес. При росте — Firecrawl Hobby ($16/мес) закрывает 80% потребности. Tavily Growth ($500/мес) обоснована при 60+ research sessions/мес.

**Risk для monitoring:** Nebius long-term strategic shift, Tavily pricing, Firecrawl billing на FIRE-1 failures.

---

## Context

В 2026 AI-research пайплайны (RAG, autonomous agents, knowledge bases) опираются на 2+ web-API stack: **search API** для discovery + **scrape API** для deep content extraction. Рынок имеет 14+ провайдеров [18], но Firecrawl и Tavily выделились как AI-native (LLM-optimized output) раздельно:

- **Firecrawl** — open-source core (AGPL-3.0) + hosted с 6 endpoints (scrape/crawl/map/search/agent/interact) [1]. Y Combinator-backed, 44,700+ GitHub stars [9].
- **Tavily** — closed-source hosted с 4-5 endpoints (search/extract/map/crawl/research), 1M+ developers [14]. В феврале 2026 приобретён Nebius за $275M [14, 16].

Разработчику, собирающему research pipeline, нужен workflow "найти релевантные источники → получить полный контент → скормить LLM". Кто что делает лучше — центральный вопрос.

---

## Findings by Sub-question

### SubQ 1-3 (L1): Firecrawl vs Tavily fundamentals

**Firecrawl** предлагает URL-centric extraction: endpoint/query → clean markdown/JSON, включая JS-rendered контент, structured extraction через JSON schema, webhooks для production (HMAC-SHA256 signed). FIRE-1 agent handles пагинации/клики/простые CAPTCHA [1, 9, 24]. Enterprise customers: Shopify, Canva, Apple, Zapier, Replit, DoorDash [1].

**Tavily** предлагает question-centric discovery: natural-language query → ranked URL list со scoring, optional content snippets, LangChain default integration [5, 25]. Clients: IBM, Cohere, Groq, LangChain internally [14].

**Подтверждённое разделение ролей:** Firecrawl = "extract from URLs you have", Tavily = "find URLs by asking questions" [8, 25].

### SubQ 4 (L2 follow-up): Production experience и latency

- **Scrapeway benchmark (Apr 04-10 2026):** Firecrawl **65% success / 5.2s speed / $5.47 per 1000** — выше industry average (59.5%) по success но дороже ($3.2 avg) [30]. **Existing L2 claim about 99% success was wrong.**
- **Tavily latency:** зависит от search_depth (basic/advanced/fast/ultra-fast). `fast` и `ultra-fast` (Dec 2025 BETA) оптимизированы на <1s, advanced может занимать 3-5s [15, 21]. Ранние противоречия о latency resolved — оба right в своих depths.
- **Rate limits:** Tavily 100 RPM dev / 1000 RPM prod [6]. Firecrawl до 5000 RPM на enterprise tiers [10].

### SubQ 5 (L2 follow-up): Nebius acquisition + new Tavily features

Nebius acquisition Feb 10 2026 ($275M по Bloomberg [16]). Tavily продолжает существовать как brand, Rotem Weiss CEO, team переходит в Nebius [13, 14]. Post-acquisition официально подтверждено: API unchanged, zero data retention sохранено [13].

**Новые Tavily features post-acquisition:**
- **March 2026:** Enterprise API key management (generate/deactivate/info)
- **February 2026:** `exact_match` parameter для compliance/legal; Cursor MCP marketplace integration; Generative UI Research Canvas (LangChain + Tako + CopilotKit)
- **January 2026:** `X-Project-ID` header для project tracking
- **December 2025:** `fast` и `ultra-fast` search_depth [15]

---

## Multi-perspective analysis

### Proponent view

**Firecrawl proponents:** сильный focus на developer ergonomics. One API call → LLM-ready markdown. 4 language SDKs (vs Tavily's 2). Open-source escape hatch (даже если ограниченный). Browser Sandbox (Jan 2026) для auth'd/interactive sites [23]. `/agent` endpoint для autonomous multi-step research [1, 20].

**Tavily proponents:** agent-first design. Clean structured output forLLMs. Fast integration in LangChain (default). Enterprise-ready safety (PII blocking, prompt injection защита [5]). Strong growth metrics: 1M+ devs, 3M monthly SDK downloads [14].

### Critic view

**Firecrawl critics:**

- **Pricing surprise** — Extract uses token-based billing separate from scrape credits; FIRE-1 agent billed on failure; JSON mode +4 credits, proxy +4 credits stacking to 9+ credits per page [4, 24, 26]
- **65% success rate** on hostile anti-bot targets (Scrapeway [30]) — marketing implies 99%+
- **Self-hosted not full parity** — key features (agent, browser, Fire-engine) hosted-only [26]
- **"Relatively expensive"** — $5.47/1000 vs $3.2 industry avg [30]
- **Credit system confusion** — multiple rate/cost dimensions

**Tavily critics:**

- **Returns snippets, not full content** — нужен separate scrape step для deep research [22]
- **Fewer SDKs** (Python/JS only), no Go/Rust community SDKs [9, 10]
- **No webhooks, no batch API** — less production-scale than Firecrawl [9]
- **No proxy control** — reliance on internal infrastructure [8]
- **Nebius acquisition uncertainty** — roadmap/pricing long-term unknown [7]

### Neutral/independent data

- **Scrapeway bi-weekly benchmark** [30]: Firecrawl #3 (65% success, 5.2s, $5.47/1000) — above average success, below average cost efficiency
- **AIMultiple 12,500-request benchmark** [32]: systematic analysis (specific numbers не в scraped content, но method rigorous)
- **Bright Data alternative rankings** [29, 31]: Bright Data #1 for hostile-target enterprise use case (98.44%, but different category)
- **Category frameworks** [17, 18]: оба Firecrawl и Tavily в "raw materials" camp (vs "answer engines" типа Perplexity) — подходят для agents с собственным synthesis LLM

### Synthesis

**Три perspectives соглашаются на ключевых моментах:**
- Firecrawl и Tavily **комплементарны, не равнозначны**
- **Use case determines winner** — нет universally "лучше"
- **Both limitations matter** — Firecrawl anti-bot weakness, Tavily depth limitation, oба long-term roadmap risks

**Disagreements остаются:**
- "Is the combined approach worth it?" — vendor blogs hype combined; independent reviewers ([24, 26]) часто recommend single-tool simplicity
- **Pricing multiplier interpretation** — depends on normalization

---

## Fact-check results (summary)

- **CONFIRMED:** Pricing multiplier direction (Firecrawl cheaper at scale for scraping), Nebius deal details, API stability post-acquisition, Writer pattern existence
- **DISPUTED:** Firecrawl universal 99% success (actually 65% on Scrapeway hostile targets — downgraded)
- **CONFIRMED w/ refinement:** "Tavily search → Firecrawl scrape" pattern — valid framework but exact tool-combo varies (Writer uses Tavily-only in practice)

Full details: `L3/fact-check.md`

---

## Addressing critic concerns

Critic review [L3/critic-report.md] identified 5 key issues. Response:

1. **"6-10x cheaper compares different operations"** — **Accepted.** Clarified in decision matrix: Firecrawl cheaper for pure scrape volume, Tavily может быть выгоднее для search-heavy workloads. Cross-endpoint comparison misleading.

2. **"Writer case contradicts headline pattern"** — **Accepted.** Fact-check explicitly corrected: Writer uses Tavily-only (/search + /extract), NOT Tavily+Firecrawl. Combined pattern остается recommended for deep research, но Writer не его единственный кейс.

3. **"65% anti-bot success rate buried in L3 only"** — **Accepted and fixed.** This L3 report surfaces finding в Executive Summary as correction #1 и в Multi-perspective/Critic view.

4. **"13/22 L2 sources vendor-authored (59% vendor bias)"** — **Accepted.** L3 layer добавила 5 independent sources (Filip Konecny, Scrapeway, AIMultiple, PYMNTS, Futurum) + Tavily perspective из tavily.com/competitors/firecrawl. L3 mix более balanced.

5. **"Nebius stability — 2 months ≠ long-term evidence"** — **Accepted.** L3 report теперь explicit: short-term (0-6 мес) stable, medium-term (6-18 мес) monitor, long-term (18+) speculative. Не claim "не блокер" absolute.

---

## Decision Matrix

**Target user assumed:** LLM-backed research pipelines, 1K-100K ops/мес, mainstream English sources.

| Option | Pipeline fit | Cost | DX | Content | Reliability | Stability | OSS | **Total** |
|--------|:------:|:-----:|:---:|:---:|:---:|:---:|:---:|:------:|
| Firecrawl only | 7 | 8 | 8 | 9 | 7 | 8 | 9 | **7.80** |
| Tavily only | 8 | 6 | 9 | 7 | 8 | 6 | 4 | **7.20** |
| **Combined** | **10** | **6** | **7** | **9** | **8** | **7** | **6** | **8.10** |

Full matrix + other user profile scenarios: `L3/decision-matrix.md`

---

## Recommendation

**For our use case (L0-L5 research ladder skills for Claude Code):**

1. **L0 `/quick-research`:** Tavily Search `fast` или `ultra-fast` search_depth. No scrape. Fastest lookup. Cost minimal.

2. **L1 `/research`:** Tavily Search `advanced` для discovery (3 subq × 5-8 URLs) + Firecrawl scrape top 10-15 URLs. Exactly как работает наш L1 сейчас. Optimal.

3. **L2+ `/deep-research`+:** тот же combined pattern + reflection loop + optional Codex cross-model. Codex v0.2 helper graceful degradation verified в этой session (получили real TIMEOUT — skill продолжил single-model).

4. **При anti-bot targets** (Cloudflare, Akamai protected sites) — **escalate к Scrapfly или Bright Data** для scraping half. Firecrawl проигрывает на этих targets.

5. **Budget tiers:**
   - **Free:** Firecrawl 500 one-time + Tavily 1000/мес = ~20 L1 sessions/мес
   - **Starter:** Firecrawl Hobby $16 + Tavily free = ~70 L1 sessions/мес
   - **Scale:** Firecrawl Standard $83 + Tavily Bootstrap $100 = reliable для intensive research

## Risks and caveats

- **Firecrawl FIRE-1 billing on failure** — budget buffer если много /agent calls
- **Nebius long-term:** если через 6-12 мес Tavily pricing меняется, planned fallback → Exa или Brave Search
- **65% anti-bot success** — не использовать Firecrawl на hostile targets; иметь Scrapfly/BrightData в плане
- **Self-hosting Firecrawl:** если нужно — знать что /agent, /browser, anti-bot будут недоступны
- **Tavily depth limit:** snippets only — если нужен full content, уже нужен scrape step

## Next steps

1. **Implement** combined pattern в L0-L5 skills (уже сделано)
2. **Monitor** Tavily changelog ежемесячно для breaking changes
3. **Benchmark** actual latency on типичных queries (разные search_depth)
4. **Set up** Firecrawl billing alerts для cost surprise prevention
5. **Test** fallback path к Scrapfly при sustained Firecrawl <50% success on specific targets

## Notes on L3 execution

**Cross-model verification:** **UNAVAILABLE** — Codex channel timed out on both neutral-angle и cross-model critic calls (v0.2 helper correctly classified as TIMEOUT, status files available at `L3/codex-{neutral,critic}.md.status`). Report is single-model (Claude only) + fact-check + critic agent (general-purpose subagent).

**Critic agent (subagent)** was invoked successfully — produced ~860-word critique which this synthesis addresses explicitly (Addressing critic concerns section).

**Bibliography:** см. `L3/bibliography.md` — 32 sources total (12 L1 + 10 L2 + 10 L3).
