[Skip to main content](https://docs.tavily.com/documentation/api-reference/endpoint/search#content-area)

[Tavily Docs home page![light logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/light.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=c5c878011f13d458af0997f3a540eb4f)![dark logo](https://mintcdn.com/tavilyai/HY1Rnt85q4usR4-R/logo/dark.svg?fit=max&auto=format&n=HY1Rnt85q4usR4-R&q=85&s=1521677768a1f26b34a9ad86d04c62cc)](https://tavily.com/)

Search...

Ctrl KAsk AI

Search...

Navigation

API Reference

Tavily Search

[Home](https://docs.tavily.com/welcome) [Introduction](https://docs.tavily.com/documentation/about) [API & SDKs](https://docs.tavily.com/documentation/api-reference/introduction) [Ecosystem](https://docs.tavily.com/documentation/mcp) [Examples](https://docs.tavily.com/examples/hub) [Changelog](https://docs.tavily.com/changelog) [Help](https://docs.tavily.com/documentation/help)

- [API Playground](https://app.tavily.com/playground)
- [Community](https://discord.gg/TPu2gkaWp2)
- [Blog](https://tavily.com/blog)

##### API Reference

- [Introduction](https://docs.tavily.com/documentation/api-reference/introduction)
- [POST\\
\\
Search](https://docs.tavily.com/documentation/api-reference/endpoint/search)
- [POST\\
\\
Extract](https://docs.tavily.com/documentation/api-reference/endpoint/extract)
- [POST\\
\\
Crawl](https://docs.tavily.com/documentation/api-reference/endpoint/crawl)
- [POST\\
\\
Map](https://docs.tavily.com/documentation/api-reference/endpoint/map)
- Research

- [GET\\
\\
Usage](https://docs.tavily.com/documentation/api-reference/endpoint/usage)

##### Enterprise API Reference

- API Key Generator


##### Python SDK

- [Quickstart](https://docs.tavily.com/sdk/python/quick-start)
- [SDK Reference](https://docs.tavily.com/sdk/python/reference)

##### JavaScript SDK

- [Quickstart](https://docs.tavily.com/sdk/javascript/quick-start)
- [SDK Reference](https://docs.tavily.com/sdk/javascript/reference)

##### Best Practices

- [Search](https://docs.tavily.com/documentation/best-practices/best-practices-search)
- [Extract](https://docs.tavily.com/documentation/best-practices/best-practices-extract)
- [Crawl](https://docs.tavily.com/documentation/best-practices/best-practices-crawl)
- [Research](https://docs.tavily.com/documentation/best-practices/best-practices-research)
- [API Key Management](https://docs.tavily.com/documentation/best-practices/api-key-management)

Python SDK

Python

```
from tavily import TavilyClient

tavily_client = TavilyClient(api_key="tvly-YOUR_API_KEY")
response = tavily_client.search("Who is Leo Messi?")

print(response)
```

200

400

401

429

432

433

500

```
{
  "query": "Who is Leo Messi?",
  "answer": "Lionel Messi, born in 1987, is an Argentine footballer widely regarded as one of the greatest players of his generation. He spent the majority of his career playing for FC Barcelona, where he won numerous domestic league titles and UEFA Champions League titles. Messi is known for his exceptional dribbling skills, vision, and goal-scoring ability. He has won multiple FIFA Ballon d'Or awards, numerous La Liga titles with Barcelona, and holds the record for most goals scored in a calendar year. In 2014, he led Argentina to the World Cup final, and in 2015, he helped Barcelona capture another treble. Despite turning 36 in June, Messi remains highly influential in the sport.",
  "images": [],
  "results": [\
    {\
      "title": "Lionel Messi Facts | Britannica",\
      "url": "https://www.britannica.com/facts/Lionel-Messi",\
      "content": "Lionel Messi, an Argentine footballer, is widely regarded as one of the greatest football players of his generation. Born in 1987, Messi spent the majority of his career playing for Barcelona, where he won numerous domestic league titles and UEFA Champions League titles. Messi is known for his exceptional dribbling skills, vision, and goal",\
      "score": 0.81025416,\
      "raw_content": null,\
      "favicon": "https://britannica.com/favicon.png",\
      "images": [\
        {\
          "url": "<string>",\
          "description": "<string>"\
        }\
      ]\
    }\
  ],
  "response_time": "1.67",
  "auto_parameters": {
    "topic": "general",
    "search_depth": "basic"
  },
  "usage": {
    "credits": 1
  },
  "request_id": "123e4567-e89b-12d3-a456-426614174111"
}
```

POST

/

search

Python SDK

Python

```
from tavily import TavilyClient

tavily_client = TavilyClient(api_key="tvly-YOUR_API_KEY")
response = tavily_client.search("Who is Leo Messi?")

print(response)
```

200

400

401

429

432

433

500

```
{
  "query": "Who is Leo Messi?",
  "answer": "Lionel Messi, born in 1987, is an Argentine footballer widely regarded as one of the greatest players of his generation. He spent the majority of his career playing for FC Barcelona, where he won numerous domestic league titles and UEFA Champions League titles. Messi is known for his exceptional dribbling skills, vision, and goal-scoring ability. He has won multiple FIFA Ballon d'Or awards, numerous La Liga titles with Barcelona, and holds the record for most goals scored in a calendar year. In 2014, he led Argentina to the World Cup final, and in 2015, he helped Barcelona capture another treble. Despite turning 36 in June, Messi remains highly influential in the sport.",
  "images": [],
  "results": [\
    {\
      "title": "Lionel Messi Facts | Britannica",\
      "url": "https://www.britannica.com/facts/Lionel-Messi",\
      "content": "Lionel Messi, an Argentine footballer, is widely regarded as one of the greatest football players of his generation. Born in 1987, Messi spent the majority of his career playing for Barcelona, where he won numerous domestic league titles and UEFA Champions League titles. Messi is known for his exceptional dribbling skills, vision, and goal",\
      "score": 0.81025416,\
      "raw_content": null,\
      "favicon": "https://britannica.com/favicon.png",\
      "images": [\
        {\
          "url": "<string>",\
          "description": "<string>"\
        }\
      ]\
    }\
  ],
  "response_time": "1.67",
  "auto_parameters": {
    "topic": "general",
    "search_depth": "basic"
  },
  "usage": {
    "credits": 1
  },
  "request_id": "123e4567-e89b-12d3-a456-426614174111"
}
```

#### Authorizations

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#authorization-authorization)

Authorization

string

header

required

Bearer authentication header in the form Bearer , where  is your Tavily API key (e.g., Bearer tvly-YOUR\_API\_KEY).

#### Body

application/json

Parameters for the Tavily Search request.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-query)

query

string

required

The search query to execute with Tavily.

Example:

`"who is Leo Messi?"`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-search-depth)

search\_depth

enum<string>

default:basic

Controls the latency vs. relevance tradeoff and how `results[].content` is generated:

- `advanced`: Highest relevance with increased latency. Best for detailed, high-precision queries. Returns multiple semantically relevant snippets per URL (configurable via `chunks_per_source`).
- `basic`: A balanced option for relevance and latency. Ideal for general-purpose searches. Returns one NLP summary per URL.
- `fast`: Prioritizes lower latency while maintaining good relevance. Returns multiple semantically relevant snippets per URL (configurable via `chunks_per_source`).
- `ultra-fast`: Minimizes latency above all else. Best for time-critical use cases. Returns one NLP summary per URL.

Cost:

- `basic`, `fast`, `ultra-fast`: 1 API Credit
- `advanced`: 2 API Credits

See [Search Best Practices](https://docs.tavily.com/documentation/best-practices/best-practices-search#search-depth) for guidance on choosing the right search depth.

Available options:

`advanced`,

`basic`,

`fast`,

`ultra-fast`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-chunks-per-source)

chunks\_per\_source

integer

default:3

Chunks are short content snippets (maximum 500 characters each) pulled directly from the source. Use `chunks_per_source` to define the maximum number of relevant chunks returned per source and to control the `content` length. Chunks will appear in the `content` field as: `<chunk 1> [...] <chunk 2> [...] <chunk 3>`. Available only when `search_depth` is `advanced`.

Required range: `1 <= x <= 3`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-max-results)

max\_results

integer

default:5

The maximum number of search results to return.

Required range: `0 <= x <= 20`

Example:

`1`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-topic)

topic

enum<string>

default:general

The category of the search.`news` is useful for retrieving real-time updates, particularly about politics, sports, and major current events covered by mainstream media sources. `general` is for broader, more general-purpose searches that may include a wide range of sources.

Available options:

`general`,

`news`,

`finance`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-time-range)

time\_range

enum<string>

The time range back from the current date to filter results based on publish date or last updated date. Useful when looking for sources that have published or updated data.

Available options:

`day`,

`week`,

`month`,

`year`,

`d`,

`w`,

`m`,

`y`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-start-date)

start\_date

string

Will return all results after the specified start date based on publish date or last updated date. Required to be written in the format YYYY-MM-DD

Example:

`"2025-02-09"`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-end-date)

end\_date

string

Will return all results before the specified end date based on publish date or last updated date. Required to be written in the format YYYY-MM-DD

Example:

`"2025-12-29"`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-answer-one-of-0)

include\_answer

booleanenum<string>booleanenum<string>

default:false

Include an LLM-generated answer to the provided query. `basic` or `true` returns a quick answer. `advanced` returns a more detailed answer.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-raw-content-one-of-0)

include\_raw\_content

booleanenum<string>booleanenum<string>

default:false

Include the cleaned and parsed HTML content of each search result. `markdown` or `true` returns search result content in markdown format. `text` returns the plain text from the results and may increase latency.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-images)

include\_images

boolean

default:false

Include images in the response. Returns both a top-level `images` list of query-related images and an `images` array inside each result object with images extracted from that specific source.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-image-descriptions)

include\_image\_descriptions

boolean

default:false

When `include_images` is `true`, also add a descriptive text for each image.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-favicon)

include\_favicon

boolean

default:false

Whether to include the favicon URL for each result.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-domains)

include\_domains

string\[\]

A list of domains to specifically include in the search results. Maximum 300 domains.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-exclude-domains)

exclude\_domains

string\[\]

A list of domains to specifically exclude from the search results. Maximum 150 domains.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-country)

country

enum<string>

Boost search results from a specific country. This will prioritize content from the selected country in the search results. Available only if topic is `general`.

Available options:

`afghanistan`,

`albania`,

`algeria`,

`andorra`,

`angola`,

`argentina`,

`armenia`,

`australia`,

`austria`,

`azerbaijan`,

`bahamas`,

`bahrain`,

`bangladesh`,

`barbados`,

`belarus`,

`belgium`,

`belize`,

`benin`,

`bhutan`,

`bolivia`,

`bosnia and herzegovina`,

`botswana`,

`brazil`,

`brunei`,

`bulgaria`,

`burkina faso`,

`burundi`,

`cambodia`,

`cameroon`,

`canada`,

`cape verde`,

`central african republic`,

`chad`,

`chile`,

`china`,

`colombia`,

`comoros`,

`congo`,

`costa rica`,

`croatia`,

`cuba`,

`cyprus`,

`czech republic`,

`denmark`,

`djibouti`,

`dominican republic`,

`ecuador`,

`egypt`,

`el salvador`,

`equatorial guinea`,

`eritrea`,

`estonia`,

`ethiopia`,

`fiji`,

`finland`,

`france`,

`gabon`,

`gambia`,

`georgia`,

`germany`,

`ghana`,

`greece`,

`guatemala`,

`guinea`,

`haiti`,

`honduras`,

`hungary`,

`iceland`,

`india`,

`indonesia`,

`iran`,

`iraq`,

`ireland`,

`israel`,

`italy`,

`jamaica`,

`japan`,

`jordan`,

`kazakhstan`,

`kenya`,

`kuwait`,

`kyrgyzstan`,

`latvia`,

`lebanon`,

`lesotho`,

`liberia`,

`libya`,

`liechtenstein`,

`lithuania`,

`luxembourg`,

`madagascar`,

`malawi`,

`malaysia`,

`maldives`,

`mali`,

`malta`,

`mauritania`,

`mauritius`,

`mexico`,

`moldova`,

`monaco`,

`mongolia`,

`montenegro`,

`morocco`,

`mozambique`,

`myanmar`,

`namibia`,

`nepal`,

`netherlands`,

`new zealand`,

`nicaragua`,

`niger`,

`nigeria`,

`north korea`,

`north macedonia`,

`norway`,

`oman`,

`pakistan`,

`panama`,

`papua new guinea`,

`paraguay`,

`peru`,

`philippines`,

`poland`,

`portugal`,

`qatar`,

`romania`,

`russia`,

`rwanda`,

`saudi arabia`,

`senegal`,

`serbia`,

`singapore`,

`slovakia`,

`slovenia`,

`somalia`,

`south africa`,

`south korea`,

`south sudan`,

`spain`,

`sri lanka`,

`sudan`,

`sweden`,

`switzerland`,

`syria`,

`taiwan`,

`tajikistan`,

`tanzania`,

`thailand`,

`togo`,

`trinidad and tobago`,

`tunisia`,

`turkey`,

`turkmenistan`,

`uganda`,

`ukraine`,

`united arab emirates`,

`united kingdom`,

`united states`,

`uruguay`,

`uzbekistan`,

`venezuela`,

`vietnam`,

`yemen`,

`zambia`,

`zimbabwe`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-auto-parameters)

auto\_parameters

boolean

default:false

When `auto_parameters` is enabled, Tavily automatically configures search parameters based on your query's content and intent. You can still set other parameters manually, and your explicit values will override the automatic ones. The parameters `include_answer`, `include_raw_content`, and `max_results` must always be set manually, as they directly affect response size. Note: `search_depth` may be automatically set to advanced when it's likely to improve results. This uses 2 API credits per request. To avoid the extra cost, you can explicitly set `search_depth` to `basic`.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-exact-match)

exact\_match

boolean

default:false

Ensure that only search results containing the exact quoted phrase(s) in the query are returned, bypassing synonyms or semantic variations. Wrap target phrases in quotes within your query (e.g. `"John Smith" CEO Acme Corp`). Punctuation is typically ignored inside quotes.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-include-usage)

include\_usage

boolean

default:false

Whether to include credit usage information in the response.

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#body-safe-search)

safe\_search

boolean

default:false

🔒 Enterprise only.
whether to filter out adult or unsafe content from results. Not supported for `fast` or `ultra-fast` search depths.

#### Response

200

application/json

Search results returned successfully

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-query)

query

string

required

The search query that was executed.

Example:

`"Who is Leo Messi?"`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-answer)

answer

string

required

A short answer to the user's query, generated by an LLM. Included in the response only if `include_answer` is requested (i.e., set to `true`, `basic`, or `advanced`)

Example:

`"Lionel Messi, born in 1987, is an Argentine footballer widely regarded as one of the greatest players of his generation. He spent the majority of his career playing for FC Barcelona, where he won numerous domestic league titles and UEFA Champions League titles. Messi is known for his exceptional dribbling skills, vision, and goal-scoring ability. He has won multiple FIFA Ballon d'Or awards, numerous La Liga titles with Barcelona, and holds the record for most goals scored in a calendar year. In 2014, he led Argentina to the World Cup final, and in 2015, he helped Barcelona capture another treble. Despite turning 36 in June, Messi remains highly influential in the sport."`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-images)

images

object\[\]

required

A list of query-related images from image search. If `include_image_descriptions` is true, each item will have `url` and `description`. Note: per-result images are also returned inside each result object's `images` field.

Showchild attributes

Example:

```json
[]
```

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-results)

results

object\[\]

required

A list of sorted search results, ranked by relevancy.

Showchild attributes

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-response-time)

response\_time

number<float>

required

Time in seconds it took to complete the request.

Example:

`"1.67"`

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-auto-parameters)

auto\_parameters

object

A dictionary of the selected auto\_parameters, only shown when `auto_parameters` is true.

Example:

```json
{
  "topic": "general",
  "search_depth": "basic"
}
```

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-usage)

usage

object

Credit usage details for the request.

Example:

```json
{ "credits": 1 }
```

[​](https://docs.tavily.com/documentation/api-reference/endpoint/search#response-request-id)

request\_id

string

A unique request identifier you can share with customer support to help resolve issues with specific requests.

Example:

`"123e4567-e89b-12d3-a456-426614174111"`

[Introduction\\
\\
Previous](https://docs.tavily.com/documentation/api-reference/introduction) [Tavily Extract\\
\\
Next](https://docs.tavily.com/documentation/api-reference/endpoint/extract)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.