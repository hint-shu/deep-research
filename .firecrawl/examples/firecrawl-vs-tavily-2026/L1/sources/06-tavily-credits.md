[Skip to main content](https://docs.tavily.com/documentation/api-credits#content-area)

[Tavily Docs home page![light logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/light.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=c5c878011f13d458af0997f3a540eb4f)![dark logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/dark.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=1521677768a1f26b34a9ad86d04c62cc)](https://tavily.com/)

Search...

Ctrl KAsk AI

Search...

Navigation

Getting Started

Credits & Pricing

[Home](https://docs.tavily.com/welcome) [Introduction](https://docs.tavily.com/documentation/about) [API & SDKs](https://docs.tavily.com/documentation/api-reference/introduction) [Ecosystem](https://docs.tavily.com/documentation/mcp) [Examples](https://docs.tavily.com/examples/hub) [Changelog](https://docs.tavily.com/changelog) [Help](https://docs.tavily.com/documentation/help)

- [API Playground](https://app.tavily.com/playground)
- [Community](https://discord.gg/TPu2gkaWp2)
- [Blog](https://tavily.com/blog)

##### Getting Started

- [About](https://docs.tavily.com/documentation/about)
- [Quickstart](https://docs.tavily.com/documentation/quickstart)
- [Credits & Pricing](https://docs.tavily.com/documentation/api-credits)
- [Rate Limits](https://docs.tavily.com/documentation/rate-limits)

##### FAQ

- [Frequently Asked Questions](https://docs.tavily.com/faq/faq)

On this page

- [Free API Credits](https://docs.tavily.com/documentation/api-credits#free-api-credits)
- [Pricing Overview](https://docs.tavily.com/documentation/api-credits#pricing-overview)
- [API Credits Costs](https://docs.tavily.com/documentation/api-credits#api-credits-costs)
- [Tavily Search](https://docs.tavily.com/documentation/api-credits#tavily-search)
- [Tavily Extract](https://docs.tavily.com/documentation/api-credits#tavily-extract)
- [Tavily Map](https://docs.tavily.com/documentation/api-credits#tavily-map)
- [Tavily Crawl](https://docs.tavily.com/documentation/api-credits#tavily-crawl)
- [Tavily Research](https://docs.tavily.com/documentation/api-credits#tavily-research)

## [​](https://docs.tavily.com/documentation/api-credits\#free-api-credits)  Free API Credits

[**Get your free API key** \\
\\
You get 1,000 free API Credits every month. **No credit card required.**](https://app.tavily.com/)

## [​](https://docs.tavily.com/documentation/api-credits\#pricing-overview)  Pricing Overview

Tavily operates on a simple, credit-based model:

- **Free**: 1,000 credits/month
- **Pay-as-you-go**: $0.008 per credit (allows you to be charged per credit once your plan’s credit limit is reached).
- **Monthly plans**: $0.0075 - $0.005 per credit
- **Enterprise**: Custom pricing and volume

| **Plan** | **Credits per month** | **Monthly price** | **Price per credit** |
| --- | --- | --- | --- |
| **Researcher** | 1,000 | Free | - |
| **Project** | 4,000 | $30 | $0.0075 |
| **Bootstrap** | 15,000 | $100 | $0.0067 |
| **Startup** | 38,000 | $220 | $0.0058 |
| **Growth** | 100,000 | $500 | $0.005 |
| **Pay as you go** | Per usage | $0.008 / Credit | $0.008 |
| **Enterprise** | Custom | Custom | Custom |

Head to [billing](https://app.tavily.com/billing) to explore our different options and manage your plan.

## [​](https://docs.tavily.com/documentation/api-credits\#api-credits-costs)  API Credits Costs

### [​](https://docs.tavily.com/documentation/api-credits\#tavily-search)  Tavily Search

Your [search depth](https://docs.tavily.com/api-reference/endpoint/search#body-search-depth) determines the cost of your request.

- **Basic Search (`basic`):**
Each request costs **1 API credit**.
- **Advanced Search (`advanced`):**
Each request costs **2 API credits**.

### [​](https://docs.tavily.com/documentation/api-credits\#tavily-extract)  Tavily Extract

The number of successful URL extractions and your [extraction depth](https://docs.tavily.com/api-reference/endpoint/extract#body-extract-depth) determines the cost of your request. You never get charged if a URL extraction fails.

- **Basic Extract (`basic`):**
Every 5 successful URL extractions cost **1 API credit**
- **Advanced Extract (`advanced`):**
Every 5 successful URL extractions cost **2 API credits**

### [​](https://docs.tavily.com/documentation/api-credits\#tavily-map)  Tavily Map

The number of pages mapped and whether or not natural-language [instructions](https://docs.tavily.com/documentation/api-reference/endpoint/map#instructions) are specified determines the cost of your request. You never get charged if a map request fails.

- **Regular Mapping:**
Every 10 successful pages returned cost **1 API credit**
- **Map with (`instructions`):**
Every 10 successful pages returned cost **2 API credits**

### [​](https://docs.tavily.com/documentation/api-credits\#tavily-crawl)  Tavily Crawl

Tavily Crawl combines both mapping and extraction operations, so the cost is the sum of both:

- **Crawl Cost = Mapping Cost + Extraction Cost**

For example:

- If you crawl 10 pages with basic extraction depth, you’ll be charged **1 credit for mapping** (10 pages) + **2 credits for extraction** (10 successful extractions ÷ 5) = **3 total credits**
- If you crawl 10 pages with advanced extraction depth, you’ll be charged **1 credit for mapping** \+ **4 credits for extraction** = **5 total credits**

### [​](https://docs.tavily.com/documentation/api-credits\#tavily-research)  Tavily Research

Tavily Research follows a dynamic
pricing model with minimum and maximum credit consumption boundaries associated
with each request. The minimum and maximum boundaries differ based on if the
request uses `model=mini` or `model=pro`.

| Request Cost Boundaries | model=pro | model=mini |
| --- | --- | --- |
| Per-request minimum | 15 credits | 4 credits |
| Per-request maximum | 250 credits | 110 credits |

[Quickstart\\
\\
Previous](https://docs.tavily.com/documentation/quickstart) [Rate Limits\\
\\
Next](https://docs.tavily.com/documentation/rate-limits)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.