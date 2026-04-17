[Skip to main content](https://docs.tavily.com/changelog#content-area)

[Tavily Docs home page![light logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/light.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=c5c878011f13d458af0997f3a540eb4f)![dark logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/dark.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=1521677768a1f26b34a9ad86d04c62cc)](https://tavily.com/)

Search...

Ctrl KAsk AI

Search...

Navigation

Changelog

[Home](https://docs.tavily.com/welcome) [Introduction](https://docs.tavily.com/documentation/about) [API & SDKs](https://docs.tavily.com/documentation/api-reference/introduction) [Ecosystem](https://docs.tavily.com/documentation/mcp) [Examples](https://docs.tavily.com/examples/hub) [Changelog](https://docs.tavily.com/changelog) [Help](https://docs.tavily.com/documentation/help)

- [API Playground](https://app.tavily.com/playground)
- [Community](https://discord.gg/TPu2gkaWp2)
- [Blog](https://tavily.com/blog)

- [Changelog](https://docs.tavily.com/changelog)

Enterprise API key management endpoints

March 2026

**Enterprise API key management — [Generate Keys](https://docs.tavily.com/documentation/enterprise/generate-keys), [Deactivate Keys](https://docs.tavily.com/documentation/enterprise/deactivate-keys), [Key Info](https://docs.tavily.com/documentation/enterprise/key-info)**

- Enterprise users can programmatically manage API keys via dedicated endpoints.
- **[POST /generate-keys](https://docs.tavily.com/documentation/enterprise/generate-keys)** — Generate new API keys for your organization.
- **[POST /deactivate-keys](https://docs.tavily.com/documentation/enterprise/deactivate-keys)** — Deactivate existing API keys.
- **[GET /key-info](https://docs.tavily.com/documentation/enterprise/key-info)** — Retrieve information about an existing API key.
- These endpoints are available on the **Enterprise plan only**. [Talk to an expert](https://tavily.com/enterprise) to learn more.

Exact match parameter

February 2026

**`exact_match` parameter for [Search](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-exact-match)**

- Use `exact_match` to ensure that only search results containing the exact quoted phrase(s) in your query are returned, bypassing synonyms or semantic variations.
- Wrap target phrases in quotes within your query (e.g. `“John Smith” CEO Acme Corp`).
- **Type:**`boolean`
- **Default:**`false`
- Because this narrows retrieval, it may return fewer results or empty result fields when no exact matches are found.
- Best suited for due diligence, data enrichment, and legal/compliance use cases where verbatim matches are required.

Project tracking with X-Project-ID header

January 2026

**Track API usage by project with the new `X-Project-ID` header**

- You can now attach a Project ID to your API requests to organize and track usage by project. This is useful when a single API key is used across multiple projects or applications.
- **HTTP Header:** Add `X-Project-ID: your-project-id` to any API request
- **Python SDK:** Pass `project_id=“your-project-id”` when instantiating the client, or set the `TAVILY_PROJECT` environment variable
- **JavaScript SDK:** Pass `projectId: “your-project-id”` when instantiating the client, or set the `TAVILY_PROJECT` environment variable
- An API key can be associated with multiple projects
- Filter requests by project in the [/usage endpoint](https://docs.tavily.com/documentation/api-reference/endpoint/usage) and platform usage dashboard to keep track of where requests originate from

New search\_depth options fast and ultra-fast (BETA)

December 2025

**[`search_depth` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-search-depth) \- New options: `fast` and `ultra-fast`**

- **`fast` (BETA)**


  - Optimized for low latency while maintaining high relevance to the user query
  - **Cost:** 1 API Credit
- **`ultra-fast` (BETA)**


  - Optimized strictly for latency
  - **Cost:** 1 API Credit

Intent Based Extraction

December 2025

**[`query`](https://docs.tavily.com/documentation/api-reference/endpoint/extract#body-query) and [`chunks_per_source`](https://docs.tavily.com/documentation/api-reference/endpoint/extract#body-chunks-per-source) parameters for Extract and Crawl**

- **`query` (Extract)**


  - **Type:**`string`
  - User intent for reranking extracted content chunks. When provided, chunks are reranked based on relevance to this query.
- **`chunks_per_source` (Extract & Crawl)**


  - **Type:**`integer`
  - **Range:** 1 to 5
  - **Default:** 3
  - Chunks are short content snippets (maximum 500 characters each) pulled directly from the source.
  - Use `chunks_per_source` to define the maximum number of relevant chunks returned per source and to control the `raw_content` length.
  - Chunks will appear in the `raw_content` field as: `<chunk 1> […] <chunk 2> […] <chunk 3>`.
  - Available only when `query` is provided (Extract) or `instructions` are provided (Crawl).

Include usage parameter

December 2025

**[`include_usage` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-usage)**

- You can now include credit usage information in the API response for the [Search](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-usage), [Extract](https://docs.tavily.com/documentation/api-reference/endpoint/extract#body-include-usage), [Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl#body-include-usage), and [Map](https://docs.tavily.com/documentation/api-reference/endpoint/map#body-include-usage) endpoints.
- Set the `include_usage` parameter to `true` to receive credit usage information in the API response.
- **Type:**`boolean`
- **Default:**`false`
- When enabled, the response includes a `usage` object with `credits` information, making it easy to track API credit consumption for each request.
- **Note:** The value may be 0 if the total successful calls have not yet reached the minimum threshold. See our [Credits & Pricing documentation](https://docs.tavily.com/documentation/api-credits) for details.

Vercel AI SDK v5 integration

November 2025

**[Tavily is now integrated with Vercel AI SDK v5](https://docs.tavily.com/documentation/integrations/vercel)**

- We’ve released a new [`@tavily/ai-sdk`](https://www.npmjs.com/package/@tavily/ai-sdk) package that provides pre-built AI SDK tools for Vercel’s AI SDK v5.
- Easily add real-time web search, content extraction, intelligent crawling, and site mapping to your AI SDK project with ready-to-use tools.
- **Available Tools:**`tavilySearch`, `tavilyExtract`, `tavilyCrawl`, and `tavilyMap`
- Full TypeScript support with proper type definitions and seamless integration with Vercel AI SDK v5.
- Check out our [integration guide](https://docs.tavily.com/documentation/integrations/vercel) to get started.

Crawl & Map timeout parameter

November 2025

**[`timeout` parameter for Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl#body-timeout) and [`timeout` parameter for Map](https://docs.tavily.com/documentation/api-reference/endpoint/map#body-timeout)**

- You can now specify a custom timeout for the [Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl) and [Map](https://docs.tavily.com/documentation/api-reference/endpoint/map) endpoints to control how long to wait for the operation before timing out.
- **Type:**`float`
- **Range:** Between 10 and 150 seconds
- **Default:** 150 seconds
- This gives you fine-grained control over crawl and map operation timeouts, allowing you to balance between reliability and speed based on your specific use case.

New team roles & permissions

August 2025

**Role options: Owner, Admin, Member**

You can now assign roles to team members, giving you more control over access and permissions. Each team has one owner, while there can be multiple admins and multiple members.
The key distinction between roles is in their permissions for Billing and Settings:

- **Owner**


  - Full access to all Settings
  - Access and ownership of the Billing account
- **Admin**


  - Full access to Settings except ownership transfer
  - No access to Billing
- **Member**


  - Limited Settings access (view members only)
  - No access to Billing

Extract timeout parameter

August 2025

**[`timeout` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/extract#body-timeout)**

- You can now specify a custom timeout for the [Extract](https://docs.tavily.com/documentation/api-reference/endpoint/extract) endpoint to control how long to wait for URL extraction before timing out.
- **Type:**`number` (float)
- **Range:** Between 1.0 and 60.0 seconds
- **Default behavior:** If not specified, automatic timeouts are applied based on `extract_depth`: 10 seconds for basic extraction and 30 seconds for advanced extraction.
- This gives you fine-grained control over extraction timeouts, allowing you to balance between reliability and speed based on your specific use case.

Start date & end date Parameters

July 2025

**[`start_date` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-start_date), [`end_date` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-end-date)**

- You can now use both the `start_date` and `end_date` parameters in the [Search](https://docs.tavily.com/documentation/api-reference/endpoint/search) endpoints.
- `start_date` will return all results after the specified start date. Required to be written in the format YYYY-MM-DD.
- `end_date` will return all results before the specified end date. Required to be written in the format YYYY-MM-DD.
- Set `start_date` to `2025-01-01` and `end_date` to `2025-04-01` to reiceive results strictly from this time range.

Usage dashboard

July 2025

**[Login to your account to view the usage dashboard](https://www.tavily.com/)**

The usage dashboard provides the following features to paid users/teams:

- The Usage Graph offers a breakdown of daily usage across all Tavily endpoints with historical data to enable month over month usage and spend comparison.
- The Logs Table offers granular insight into each API request to ensure visibility and traceability with every Tavily interaction.

Include favicon parameter

June 2025

**[`include_favicon` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-favicon)**

- You can now include the favicon URL for each result in the [Search](https://docs.tavily.com/documentation/api-reference/endpoint/search), [Extract](https://docs.tavily.com/documentation/api-reference/endpoint/extract), and [Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl) endpoints.
- Set the `include_favicon` parameter to `true` to receive the favicon URL (if available) for each result in the API response.
- This makes it easy to display website icons alongside your search, extraction, or crawl results, improving the visual context and user experience in your application.

Auto parameters

June 2025

**Tavily Search**

**[`auto_parameters`](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-auto-parameters)**

- **Boolean default:**`false`
- When `auto_parameters` is enabled, Tavily automatically configures search parameters based on your query’s content and intent. You can still set other parameters manually, and your explicit values will override the automatic ones.
- The parameters `include_answer`, `include_raw_content`, and `max_results` must always be set manually, as they directly affect response size.
- **Note:**`search_depth` may be automatically set to `advanced` when it’s likely to improve results. This uses **2 API credits per request**. To avoid the extra cost, you can explicitly set `search_depth` to `basic`.

Usage endpoint

May 2025

**[`/usage` endpoint](https://docs.tavily.com/documentation/api-reference/endpoint/usage)**

**Easily check your API usage and plan limits.**

Just `GET https://api.tavily.com/usage` with your API key to monitor your account in real time.

Country parameter

May 2025

**Tavily Search**

**[`country` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-country)**

**Boost search results from a specific country.**

This will prioritize content from the selected country in the search results. Available only if `topic` is `general`.

Make & n8n integrations

May 2025

**Make & n8n Integrations**

- **[Tavily is now available for no-code integration through n8n.](https://docs.tavily.com/documentation/integrations/n8n)**


Integrate Tavily with n8n to enhance your workflows with real-time web search and content extraction—without writing code. With Tavily’s powerful search and extraction capabilities, you can seamlessly integrate up-to-date online information into your n8n automations.

- **[Integrate Tavily with Make without writing a single line of code.](https://docs.tavily.com/documentation/integrations/make)**


With Tavily’s powerful search and content extraction capabilities, you can seamlessly integrate real-time online information into your Make workflows and automations.


Markdown format

May 2025

**Tavily Extract**

**[`format` parameter](https://docs.tavily.com/documentation/api-reference/endpoint/extract#body-format)**

- **Type:**`enum<string>`
- **Default:**`markdown`
- The format of the extracted web page content. `markdown` returns content in markdown format. `text` returns plain text and may increase latency.
- **Available options:**`markdown`, `text`

Advanced search & chunks per source

April 2025

**Tavily Search**

**[`search_depth`](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-search-depth) and [`chunks_per_source`](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-chunks-per-source) parameters**

- **`search_depth`**




  - **Type:**`enum<string>`
  - **Default:**`basic`
  - The depth of the search. `advanced` search is tailored to retrieve the most relevant sources and content snippets for your query, while `basic` search provides generic content snippets from each source.
  - A `basic` search costs 1 API Credit, while an `advanced` search costs 2 API Credits.
  - **Available options:**`basic`, `advanced`

- **`chunks_per_source`**




  - Chunks are short content snippets (maximum 500 characters each) pulled directly from the source.
  - Use `chunks_per_source` to define the maximum number of relevant chunks returned per source and to control the content length.
  - Chunks will appear in the content field as: `<chunk 1> […] <chunk 2> […] <chunk 3>`.
  - Available only when `search_depth` is `advanced`.
  - **Required range:**`1 < x < 3`

Tavily crawl (BETA)

April 2025

[Tavily Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl)

- Tavily Crawl enables you to traverse a website like a graph, starting from a base URL and automatically discovering and extracting content from multiple linked pages. With Tavily Crawl, you can:

  - Specify the starting URL and let the crawler intelligently follow links to map out the site structure.
  - Control the depth and breadth of the crawl, allowing you to focus on specific sections or perform comprehensive site-wide analysis.
  - Apply filters and custom instructions to target only the most relevant pages or content types.
  - Aggregate extracted content for further analysis, reporting, or integration into your workflows.
  - Seamlessly integrate with your automation tools or use the API directly for flexible, programmatic access.

Tavily Crawl is ideal for use cases such as large-scale content aggregation, competitive research, knowledge base creation, and more.

For full details and API usage examples, see the [Tavily Crawl API reference](https://docs.tavily.com/documentation/api-reference/endpoint/crawl).

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.