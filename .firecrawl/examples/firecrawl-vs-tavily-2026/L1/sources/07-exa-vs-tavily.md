[Introducing WebCode: search evals for coding agents](https://exa.ai/blog/webcode) [Introducing WebCode: search evals for coding agents](https://exa.ai/blog/webcode) [Read more](https://exa.ai/blog/webcode)

# Exa vs. Tavily

Last updatedFebruary 12, 2026

Tavily, acquired by Nebius in February 2026, offers a search API that performs well on basic queries. Exa is faster, more accurate on hard queries, and has dedicated people, company, and code search.

Accuracy

Exa81%

Tavily71%

WebWalker multi-hop web retrieval benchmark, independently evaluated.

Latency

Exa1.4s

Tavily4.5s

p95 response time on WebWalker queries, independently measured.

Result Categories

Exa7

Tavily3

Specialized search indexes for different content types.

Customizability

Exa1,200

Tavily300

Maximum domains in include/exclude filter per query.

## Benchmark Results

Search accuracyp95 latency

Exa

Tavily

81%

71%

WebWalker

70%

63%

MKQA

71.6%

67.4%

FreshQA

WebWalkerMKQAFreshQASimpleQA

Benchmark Overview [Methodology ↗](https://arxiv.org/abs/2501.07572)

WebWalker tests complex multi-hop web retrieval: queries that require traversing multiple pages and synthesizing information across them. Real AI agent queries are rarely single-hop — a research agent asked 'What was the revenue impact of Company X's acquisition of Company Y?' needs to find the acquisition announcement, then the earnings report, then extract the specific figure.

The benchmark uses 100 multi-layered questions where each answer requires navigating from an initial web page through a chain of links. This tests both retrieval accuracy (can the API find the right starting point?) and content depth (can it follow the information chain?).

How it was run

A Fortune 100 enterprise company ran this evaluation in January 2025 across four search API providers. 100 questions, top 5 results per provider, GPT-5.1 as answering LLM, GPT-4.1 as judge.

## Key Differentiators

01

### Exa scores 10 points higher on complex retrieval in independent enterprise testing.

Most search APIs handle simple factual lookups. The queries that break things are multi-hop: 'What was the revenue impact of this acquisition?' requires finding the announcement, then the earnings report, then extracting the figure. If the search API can't follow that chain, the agent silently fails.

Tavily's keyword-based retrieval keeps up on simple lookups but falls behind when queries need semantic understanding or multi-step reasoning. The harder the query, the wider the gap.

WebWalker

Exa

81%

Tavily

71%

MKQA

Exa

70%

Tavily

63%

FreshQA

Exa

71.6%

Tavily

67.4%

Higher is better. Sources: Fortune 100 enterprise evaluation (Jan 2025), Exa internal FreshQA evaluation (Dec 2025).

02

### p95 latency under 1.7 seconds, with an instant mode under 200ms.

An agent that chains 50 searches per workflow loses minutes to a slow API. For voice and real-time AI, anything over 500ms breaks the interaction. In the Fortune 100 enterprise evaluation, Exa's p95 ranged from 1.4s to 1.7s across three benchmarks. Tavily's ranged from 3.8s to 4.5s.

Tavily reports 90ms for its ultra-fast mode, but that number only holds for the simplest queries. On typical evaluation queries: 210ms. On longer queries: 420ms. Exa Instant delivers sub-200ms with no query-length penalty.

WebWalker

Exa

1.4s

Tavily

4.5s

SimpleQA

Exa

1.5s

Tavily

3.8s

MKQA

Exa

1.7s

Tavily

4.4s

Lower is better. Source: Fortune 100 enterprise evaluation, p95 latency (Jan 2025).

03

### Search 1B+ people and companies by role, location, and industry.

Sales enrichment, recruiting agents, competitive intelligence, and due diligence all require searching for specific people and companies, not web pages. General web search returns LinkedIn profile pages if you're lucky, but can't filter by role, funding stage, or employee count. Tavily has no people or company search.

Exa indexes over 1 billion LinkedIn profiles with 50M+ updates per week, plus a dedicated company search index built on proprietary embeddings. Queries like 'Series B fintech companies in Singapore with 50-200 employees' or 'VP of Engineering at mid-market healthcare companies' return structured, current results. The company index covers entities that general web search misses: pre-Series A startups, niche B2B verticals, regional players with minimal web presence. Both benchmarks (~800 company queries, 1,400 people queries) are open-sourced on GitHub.

Exa people search

```
from exa_py import Exa

exa = Exa(api_key="your-api-key")

results = exa.search(
    "VP of Engineering at Series B healthcare companies",
    category="people",
    num_results=10,
    contents={
        "highlights": {
            "query": "engineering leadership experience",
            "num_sentences": 3
        }
    }
)
```

Tavily has no equivalent for people or company search.

04

### Code search extracts the relevant snippet, not the whole docs page.

Coding agents that pull full documentation pages into their context window waste tokens on navigation, sidebars, and unrelated sections. The agent needs the relevant function signature or usage example, not the surrounding page chrome. Exa Code searches 1B+ web pages and returns token-succinct excerpts, typically a few hundred tokens per result. The `maxCharacters` parameter lets agents set exact context budgets: 500 characters for a quick API reference, 5,000 for a full tutorial. Tavily has no code search.

Exa search with token-budgeted highlights

```
import requests

response = requests.post(
    "https://api.exa.ai/context",
    headers={
        "Content-Type": "application/json",
        "x-api-key": "your-api-key"
    },
    json={
        "query": "React Server Components with Next.js App Router",
        "tokensNum": 5000
    }
)

# Returns token-succinct code excerpts, not full pages
print(response.json()["response"])
```

Returns the most relevant code excerpts, not full documentation pages.

05

### Query-dependent highlights cut tokens 50-75% while improving RAG accuracy.

RAG pipelines that send full page text to the LLM pay for irrelevant tokens and get worse answers. Exa's highlights extract the passages that actually answer the query, improving RAG accuracy by 10% in internal testing at 50-75% fewer tokens. The `maxCharacters` parameter sets a per-page token budget so agents control exactly how much context goes downstream.

Tavily returns static page content via `include_raw_content`, the same text regardless of what was searched. Searching for 'React Server Components' against a Next.js docs page returns the same content as searching for 'deployment configuration' against that same page. All filtering happens in your LLM, at your token cost.

06

### 1,200-domain filters and text matching that hold under production load.

Production deployments need to restrict results to approved sources. An IT support agent that returns results outside its domain allowlist is a security issue, not a quality issue. Exa's `includeDomains` and `excludeDomains` accept up to 1,200 entries each. Tavily caps at 300 include and 150 exclude.

Exa also has `includeText` / `excludeText` for content keyword matching, ISO 8601 date ranges on both publish and crawl dates, category filters (`company`, `people`, `news`, `research_paper`), livecrawl control via `maxAgeHours`, and language filtering. Tavily has date presets, country boosting, and safe search, but no category filters beyond news and finance.

Exa search with full filter stack

```
results = exa.search(
    "AI regulation updates 2026",
    type="auto",
    num_results=25,
    include_domains=["reuters.com", "ft.com", "wsj.com"],
    exclude_domains=["reddit.com", "twitter.com"],
    start_published_date="2026-01-01",
    include_text=["artificial intelligence"],
    category="news",
    contents={
        "highlights": {"max_characters": 1000}
    }
)
```

Domain filters, date ranges, keyword filters, and category selection in one request.

* * *

## Feature Comparison

### Search

| Feature | Exa | Tavily |
| --- | --- | --- |
| Search modes | Instant, fast, auto, deep | Basic, fast, advanced, ultra-fast |
| Neural/semantic search | Yes | No |
| Max results per query | 100+ | 20 |
| Category filters | Company, people, news, research paper, personal site, financial report | General, news, finance |
| People search | 1B+ indexed profiles | No |
| Company search | Yes | No |
| Code search | Yes | No |

### Filtering & customization

| Feature | Exa | Tavily |
| --- | --- | --- |
| Include domains limit | 1,200 | 300 |
| Exclude domains limit | 1,200 | 150 |
| Date filtering | Yes, publish + crawl date | Presets (day/week/month/year) + custom range |
| Location filtering | Yes | Yes, general topic only |
| Language filtering | Yes | No |
| Moderation / safe search | Yes | Yes |

### Content & output

| Feature | Exa | Tavily |
| --- | --- | --- |
| Query-dependent highlights | Yes (+10% RAG accuracy) | No |
| Full page text | Yes | Yes |
| LLM-generated answers | Yes | Yes |
| Structured JSON output | Yes | No |

### Infrastructure

| Feature | Exa | Tavily |
| --- | --- | --- |
| Own search index | Billions of documents | No |
| p95 latency | 1.4-1.7s | 3.8-4.5s |
| Fastest search latency | Sub-200ms | 210-420ms |
| SOC2 | Yes | Yes |
| Rate limits (search) | 10+ QPS (custom on enterprise) | 1,000 req/min |

### Developer experience

| Feature | Exa | Tavily |
| --- | --- | --- |
| SDKs | Python, JavaScript | Python, JavaScript |
| MCP support | Yes | Yes |
| Framework integrations | LangChain, LlamaIndex, CrewAI, Vercel AI SDK, Google ADK, Composio, n8n, Zapier, Make, and 20+ more | LangChain (default), LlamaIndex, CrewAI, Vercel AI SDK, Dify, Make, n8n, Zapier, and 20+ more |
| OpenAI SDK compatibility | Yes | No |
| Free tier | $10 free credits | 1,000 credits/month |

* * *

Trusted by the fastest-growing AI companies

![Cursor](https://exa.ai/images/testimonial/cursor_monochrome.svg)

![Vercel](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2FVercel_logo_black.webp&w=256&q=75)

![Salesloft](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fsalesloft.png&w=256&q=75)

![AWS](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Faws.png&w=256&q=75)

![Databricks](https://exa.ai/images/testimonial/databricks_monochrome.svg)

![Groq](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fgroq.jpg&w=256&q=75)

![HubSpot](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fhubspot_logo.png&w=256&q=75)

![Monday.com](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fmonday_logo.png&w=256&q=75)

![WebFX](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fwebfx.png&w=256&q=75)

![Lovable](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Flovable.png&w=256&q=75)

![StackAI](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fstackai.png&w=256&q=75)

![Anara](https://exa.ai/_next/image?url=%2Fimages%2Ftestimonial%2Fanara.png&w=256&q=75)

* * *

## FAQ

Is Exa more accurate than Tavily?

On WebWalker (complex multi-hop retrieval), Exa scored 81% vs Tavily's 71% in an independent Fortune 100 enterprise evaluation. On multilingual queries (MKQA), Exa scored 70% vs 63%. A separate 500-query evaluation using real customer workloads measured Exa at 0.648 vs Tavily's 0.343. The gap is largest on queries requiring semantic understanding or multi-step reasoning.

Is Exa faster than Tavily?

In the enterprise evaluation, Exa's p95 latency was 1.4-1.7s vs Tavily's 3.8-4.5s across three benchmarks. Exa Instant delivers sub-200ms. Tavily's ultra-fast mode claims 90ms but measures 210ms on typical queries and 420ms on longer inputs.

Can Tavily search for people or companies?

No. Tavily has general, news, and finance search categories. Exa indexes 1B+ LinkedIn profiles for people search and maintains a dedicated company search index with structured attributes like industry, geography, employee count, and funding data. Both benchmarks (800 company queries, 1,400 people queries) are open-sourced on GitHub.

How does Exa pricing compare to Tavily?

Exa charges $5 per 1,000 searches plus $1 per 1,000 pages for text or highlights. Tavily uses a credit system at $0.008 per credit with raw content included free. For workloads that need full page text on every result, Tavily's bundled pricing is cheaper. For workloads using Exa's query-dependent highlights, the gap narrows because highlights deliver higher RAG accuracy at fewer tokens, reducing downstream LLM costs.

How easy is it to switch from Tavily to Exa?

Both provide Python and JavaScript SDKs, and both integrate with LangChain, LlamaIndex, CrewAI, Vercel AI SDK, and MCP.

Which is better for RAG pipelines, Exa or Tavily?

Exa's query-dependent highlights extract the most relevant passages per page, scoring 10% higher on RAG benchmarks than full-text retrieval while sending 50-75% fewer tokens to the LLM. The maxCharacters parameter sets a per-page token budget for precise context window management. Tavily returns the same static page content regardless of query, requiring more downstream processing to isolate relevant passages.

Who acquired Tavily?

Nebius, an Amsterdam-based AI cloud infrastructure company, announced its acquisition of Tavily in February 2026. Nebius plans to integrate Tavily's agentic search capabilities into its AI cloud platform. Exa is an independent company focused entirely on search for AI, with no parent company to redirect product priorities.

What does the Tavily acquisition by Nebius mean for Tavily users?

Acquisitions can change product roadmaps, pricing, API contracts, and support priorities. Teams using or evaluating Tavily should monitor how Nebius integrates the product. Exa remains independently operated with its full roadmap focused on search. For teams considering migration, Exa's SDKs work with the same frameworks (LangChain, LlamaIndex, Vercel AI SDK, MCP).