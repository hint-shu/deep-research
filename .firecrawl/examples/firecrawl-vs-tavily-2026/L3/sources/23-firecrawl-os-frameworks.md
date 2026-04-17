Introducing web-agent, an open framework for building web agents. Fork it, swap models, and add Skills. [Start building →](https://github.com/firecrawl/web-agent?utm_source=firecrawl-website&utm_medium=banner&utm_campaign=open-source-agent-launch&utm_content=start-building)

//

Get started

//

### Ready to build?

Start getting Web Data for free and scale seamlessly as your project expands.No credit card needed.

[Start for free](https://www.firecrawl.dev/signin) [See our plans](https://www.firecrawl.dev/pricing)

[Are you an AI agent? Get an API key here](https://www.firecrawl.dev/agent-onboarding/SKILL.md)

#### Table of Contents

[Blog](https://www.firecrawl.dev/blog)

The Best Open Source Frameworks For Building AI Agents in 2026

![placeholder](https://www.firecrawl.dev/_next/image?url=%2Fblog%2Fauthors%2Fbex.jpg&w=48&q=75&dpl=dpl_huGTNGwV4WezSnhFcEFFu7aGsMRb)Bex Tuychiev

Feb 24, 2026(updated)

![The Best Open Source Frameworks For Building AI Agents in 2026 image](https://www.firecrawl.dev/_next/image?url=%2Fimages%2Fblog%2Fagent-frameworks%2Fagent-frameworks.webp&w=3840&q=75&dpl=dpl_huGTNGwV4WezSnhFcEFFu7aGsMRb)

## TLDR

- Seven open source frameworks compared: LangGraph, OpenAI Agents SDK, AutoGen, CrewAI, Google ADK, Dify, and Mastra
- LangGraph leads in enterprise adoption (34.5M monthly downloads), Dify leads in GitHub stars (129.8k)
- Firecrawl's /agent endpoint handles web data collection for any framework
- 10 best practices from Anthropic, OpenAI, and McKinsey for deploying agents in production
- Comparison table with stars, downloads, features, and best-fit use cases for each framework

* * *

The hype around AI agents is very real and well-deserved. According to [Markets And Markets](https://www.marketsandmarkets.com/Market-Reports/ai-agents-market-15761548.html), the global agent market reached $7.84 billion in 2025 and is projected to hit $52.62 billion by 2030, with a compound annual growth rate (CAGR) of 46.3%. [Gartner predicts](https://www.gartner.com/en/newsroom/press-releases/2025-08-26-gartner-predicts-40-percent-of-enterprise-apps-will-feature-task-specific-ai-agents-by-2026-up-from-less-than-5-percent-in-2025) that 40% of enterprise applications will feature task-specific AI agents by end of 2026, up from less than 5% in 2025. This rapid growth is fueled by stronger and stronger foundational LLMs that seem to come out every week now.

For this reason, choosing appropriate frameworks to build AI agents has become essential if developers want to integrate existing infrastructure with language models. In this article, we will examine the most powerful and widely adopted open source frameworks to build agents in 2026, analyzing their technical features, implementation requirements and optimal use cases.

**Enhance Your Agents:** Combine agent frameworks with [RAG systems](https://www.firecrawl.dev/blog/best-open-source-rag-frameworks) for knowledge-augmented responses. Use [web scraping libraries](https://www.firecrawl.dev/blog/best-open-source-web-scraping-libraries) and [browser automation tools](https://www.firecrawl.dev/blog/browser-automation-tools-comparison) for data collection.

**Related Guides:** For converting websites into agents, see our [website to agent tutorial](https://www.firecrawl.dev/blog/website-to-agent-with-firecrawl-openai) and [website to LangGraph agent guide](https://www.firecrawl.dev/blog/website-to-langgraph-agent). For OpenAI-specific implementations, check [OpenAI agent builders and Firecrawl](https://www.firecrawl.dev/blog/openai-agent-builders-and-firecrawl). For a deep dive into [AI agent architecture and the types of AI agents](https://www.firecrawl.dev/blog/ai-agents) used in production, see our comprehensive guide.

## Our evaluation methodology to filter agent frameworks

To find the best agent frameworks, we used clear metrics and practical requirements. We gathered data from GitHub, PyPI downloads, documentation, and industry articles, looking for frameworks that can handle reasoning tasks, work together as multiple agents, and [use tools effectively](https://www.firecrawl.dev/blog/agent-tools).

We evaluated each framework based on:

- **GitHub metrics**: Stars, active contributors, and regular updates
- **Adoption**: Monthly download numbers
- **Technical features**: Ability to reason, collaborate between agents, and use tools
- **Documentation**: Clear guides and tutorials for developers
- **Real-world use**: Proven cases in actual production environments
- **Industry use**: How they work across different sectors like finance and customer service
- **Backing organizations**: Support from established companies for ongoing development

The seven frameworks we selected show real value based on these criteria and provide solid options for developers building AI agents in 2026.

## Firecrawl: The best web data collection agent

Before we get into the list, Firecrawl deserves its own mention. What started as a web scraping API has grown into a full data collection platform for agents. The [/agent endpoint](https://docs.firecrawl.dev/features/agent) handles the hardest part of agent development: getting structured data from the web without writing scraping scripts. You describe what you want in plain text, optionally pass a Pydantic schema, and the agent searches, navigates, and returns structured results.

Firecrawl's agent comes in two models: `spark-1-mini` (default, 60% cheaper) for straightforward extractions, and `spark-1-pro` for complex multi-domain research where accuracy matters most. Both models work without requiring URLs, though you can provide them to focus the search.

Here's an example that finds YC companies and returns structured data:

```
from firecrawl import Firecrawl
from pydantic import BaseModel, Field
from typing import List, Optional

app = Firecrawl(api_key="fc-YOUR-API-KEY")

class Company(BaseModel):
    name: str = Field(description="Company name")
    batch: Optional[str] = Field(None, description="YC batch")
    description: Optional[str] = Field(None, description="One-line description")

class CompanyList(BaseModel):
    companies: List[Company] = Field(description="List of companies")

result = app.agent(
    prompt="Find 3 YC W22 companies in the consumer category",
    schema=CompanyList,
    model="spark-1-mini"
)

print(result.data)
```

```
{
  "companies": [\
    {"name": "beU delivery", "batch": "W22", "description": "Food delivery service in Africa"},\
    {"name": "Olympian Motors", "batch": "W22", "description": "Next-generation, modular electric vehicles"},\
    {"name": "SOTERI SKIN", "batch": "W22", "description": "D2C skincare for eczema"}\
  ]
}
```

Beyond the agent endpoint, Firecrawl offers a [Browser Sandbox](https://docs.firecrawl.dev/features/browser) that gives agents a secure, managed browser environment. Each session runs in an isolated sandbox with Playwright pre-installed, and you can execute Python, JavaScript, or bash commands remotely:

```
# Launch a cloud browser session
session = app.browser()
print(session.cdp_url)  # wss://browser.firecrawl.dev/cdp/...

# Execute code in the sandbox
result = app.browser_execute(
    session.id,
    code='await page.goto("https://news.ycombinator.com")\ntitle = await page.title()\nprint(title)',
    language="python"
)

print(result.result)  # "Hacker News"
app.delete_browser(session.id)
```

The standard `scrape`, `crawl`, and `batch_scrape` endpoints handle bulk data collection, while the `map` endpoint generates URL lists from entire sites. All of these can be plugged into any agent framework as custom tools. The [LLMs.txt API](https://docs.firecrawl.dev/features/alpha/llmstxt) converts websites to clean text for LLMs, and the platform includes a [CLI](https://docs.firecrawl.dev/sdks/cli) for terminal-based workflows.

**Visual Development:** Build agent workflows visually with [LangFlow](https://www.firecrawl.dev/blog/langflow-tutorial-visual-ai-workflows) or automate them with [n8n workflows](https://www.firecrawl.dev/blog/firecrawl-n8n-web-automation).

## Top 7 open source frameworks to build AI agents

Now, without further ado, here are the seven most effective open source frameworks for building AI agents in 2026, ranked by their proven success in real-world applications and developer adoption.

### 1\. LangGraph - ⭐️24.8k

![LangGraph framework visualization showing directed graph architecture for building AI agents](https://www.firecrawl.dev/images/blog/agent-frameworks/langgraph.webp)

[LangGraph](https://github.com/langchain-ai/langgraph) is a specialized agent framework within the LangChain ecosystem. Released in 2024, it has over 24,800 GitHub stars and 34.5 million monthly downloads. It focuses on building controllable, stateful agents that maintain context throughout interactions. LangGraph integrates with LangSmith for [monitoring agent performance](https://www.firecrawl.dev/blog/best-llm-observability-tools).

Core capabilities:

- Stateful agent orchestration with streaming support
- Support for single-agent, multi-agent, hierarchical, and sequential control flows
- Long-term memory and human-in-the-loop workflows
- Integration with LangChain products like LangSmith

Around 400 companies now use LangGraph Platform to deploy agents in production, including Cisco, Uber, LinkedIn, BlackRock, and JPMorgan. [Klarna's customer support bot](https://langchain-ai.github.io/langgraph/case-studies/klarna) handles two-thirds of all customer inquiries, doing the work of 853 employees and saving the company $60 million. [AppFolio's Copilot Realm-X](https://langchain-ai.github.io/langgraph/case-studies/appfolio) improved response accuracy by 2x, while [Elastic](https://langchain-ai.github.io/langgraph/case-studies/elastic) uses it for AI-powered threat detection in SecOps tasks. For a step-by-step implementation, see our [LangGraph agent tutorial](https://www.firecrawl.dev/blog/langgraph-startup-validator-tutorial).

### 2\. OpenAI Agents SDK - ⭐️19k

![OpenAI Agents SDK interface showing Python code implementation for building AI agents with multi-agent workflows and tracing capabilities](https://www.firecrawl.dev/images/blog/agent-frameworks/sdk.webp)

The [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) is a lightweight Python framework released in March 2025 with over 19,000 GitHub stars and 10.3 million monthly downloads. It focuses on creating multi-agent workflows with tracing and guardrails. The framework is provider-agnostic and compatible with over 100 LLMs.

Main features:

- Lightweight design for multi-agent workflows
- Comprehensive tracing and guardrails
- Provider-agnostic compatibility with 100+ LLMs
- Low learning curve for Python developers

The SDK has gained traction due to OpenAI's reputation and the framework's versatility. Its documentation provides clear tutorials and API references. While specific enterprise implementations aren't widely documented yet, the framework is designed for applications in finance, customer service, and software development. For a practical application example, see [Converting Websites into Agents with Firecrawl and OpenAI Agents SDK](https://www.firecrawl.dev/blog/website-to-agent-with-firecrawl-openai), which demonstrates how to transform web content into interactive knowledge agents.

### 3\. AutoGen - ⭐️54.6k

![Microsoft AutoGen framework interface showing multi-agent conversation architecture with collaborative AI agents for complex problem-solving](https://www.firecrawl.dev/images/blog/agent-frameworks/autogen.webp)

[AutoGen](https://github.com/microsoft/autogen) is a multi-agent conversation framework developed by Microsoft Research. Released in September 2023, it has grown to over 54,600 GitHub stars and 856,000 monthly downloads. AutoGen uses an event-driven architecture for complex interactions between AI agents and integrates with various LLMs while maintaining structured conversation flows.

Key features include:

- Multi-agent conversation framework with event-driven architecture
- Scalable workflows for complex collaborative tasks
- Extensive documentation with tutorials and migration guides
- Outperforms single-agent solutions on GAIA benchmarks

The framework has gained traction in data science and education sectors, with [Novo Nordisk implementing it for data science workflows](https://www.microsoft.com/en-us/research/blog/autogen-enabling-next-generation-large-language-model-applications/). In October 2025, Microsoft merged AutoGen with Semantic Kernel into the unified [Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/overview/agent-framework-overview), with GA targeted for end of Q1 2026. AutoGen itself is now in maintenance mode, receiving only bug fixes and security patches, though existing projects continue to work.

### 4\. CrewAI - ⭐️44.3k

![CrewAI framework interface showing collaborative AI agents with role-based architecture for orchestrating multi-agent systems in enterprise applications](https://www.firecrawl.dev/images/blog/agent-frameworks/crewai.webp)

[CrewAI](https://github.com/crewAIInc/crewAI) orchestrates role-playing AI agents for collaborative tasks. Launched in early 2024, it has over 44,300 GitHub stars and 5.2 million monthly downloads. Independent from LangChain, CrewAI offers simpler implementation for developers who want to build multi-agent systems without complex dependencies.

Main features:

- Role-playing agent orchestration with defined responsibilities
- Independence from LangChain for simpler implementation
- Minimal code required for agent setup
- Popular in customer service and marketing sectors

CrewAI's straightforward approach has contributed to its rapid adoption. Streaming tool call events were added in January 2026, addressing the earlier limitation around real-time task performance. For a hands-on walkthrough, see our [CrewAI multi-agent tutorial](https://www.firecrawl.dev/blog/crewai-multi-agent-systems-tutorial).

### 5\. Google Agent Development Kit (ADK) - ⭐️17.8k

![Google Agent Development Kit (ADK) interface showing modular framework architecture with hierarchical agent compositions and Google ecosystem integration for enterprise AI solutions](https://www.firecrawl.dev/images/blog/agent-frameworks/adk.webp)

The [Google Agent Dev Kit (ADK)](https://github.com/google/adk-python) was announced in April 2025 and has grown to 17,800 GitHub stars with 3.3 million monthly downloads. This modular framework integrates with the Google ecosystem, including Gemini and Vertex AI. It supports hierarchical agent compositions and custom tools.

ADK features:

- Modular framework with Google ecosystem integration
- Support for hierarchical agent compositions
- Custom tool development capabilities
- Efficient development requiring less than 100 lines of code

Google uses the ADK in their [Agentspace platform](https://cloud.google.com/blog/products/ai-machine-learning/introducing-google-cloud-agentspace) and for customer engagement solutions. The framework has a moderate to steep learning curve due to Google Cloud integration, but comes with detailed documentation. It's well-suited for customer engagement applications and Google Cloud workflow automation. See our [Google ADK tutorial](https://www.firecrawl.dev/blog/google-adk-multi-agent-tutorial) for a practical implementation guide.

### 6\. Dify - ⭐️129.8k

![Dify AI agent platform interface showing low-code visual builder with drag-and-drop components for creating enterprise-grade AI agents without programming experience](https://www.firecrawl.dev/images/blog/agent-frameworks/dify.webp)

[Dify](https://github.com/langgenius/dify) is a low-code platform for creating AI agents with over 129,000 GitHub stars. Its visual interface makes it accessible to non-technical users while still offering capabilities for experienced developers. Dify supports hundreds of LLMs and includes RAG, Function Calling, and ReAct strategies.

Key capabilities:

- Low-code visual interface for agent development
- Built-in RAG, Function Calling, and ReAct strategies
- Support for hundreds of different LLMs
- TiDB's Serverless [vector search](https://www.firecrawl.dev/blog/best-vector-databases) for scalability

Dify is used across various sectors, from enterprises implementing LLM gateways to startups creating rapid prototypes. Its document generation and financial report analysis features make it valuable in business contexts.

### 7\. Mastra - ⭐️21.2k

![Mastra framework interface showing TypeScript-first agent development with graph-based workflows and multi-agent routing](https://www.firecrawl.dev/images/blog/agent-frameworks/mastra.webp)

[Mastra](https://github.com/mastra-ai/mastra) is a TypeScript-first agent framework built by the team behind Gatsby (the React static site generator). It launched in August 2024 and hit version 1.0 in January 2026, pulling in over 1.77 million monthly NPM downloads since then. The framework is backed by Y Combinator and a $13M seed round from investors including Paul Graham and Guillermo Rauch. Where most agent frameworks on this list target Python developers, Mastra fills the gap for JavaScript and TypeScript teams who want to build agents without switching ecosystems.

Main features:

- Workflows run as graphs with `.then()`, `.branch()`, and `.parallel()` primitives, and they can suspend/resume for human-in-the-loop patterns
- Any agent can become a routing agent through the `.network()` method, delegating tasks to sub-agents and tools
- The memory system has four tiers: message history, working memory, semantic recall, and RAG
- Works with 81 LLM providers and 2,436+ models through the Vercel AI SDK
- Ships with a local dev playground in the browser for testing agents, visualizing workflow graphs, and running evaluations

Mastra has picked up real production traction. Replit uses it in Agent 3 (their AI coding assistant that spins up isolated [Docker sandboxes](https://www.firecrawl.dev/blog/ai-agent-sandbox) to write and test code), where it improved task success rates from 80% to 96% across thousands of daily sessions. Marsh McLennan deployed a Mastra-based search tool to 75,000 employees, and SoftBank built their Satto Workspace platform on it. The main trade-off is that it's TypeScript-only, so Python-heavy ML teams won't be able to adopt it. Its integration ecosystem is also still growing compared to more established frameworks like LangGraph. For a practical [Mastra tutorial](https://www.firecrawl.dev/blog/mastra-tutorial) that builds a changelog tracker with Firecrawl tools, see the step-by-step walkthrough.

### Comparing all frameworks in a single table

| Framework | Stars | Monthly Downloads | Key Features | Notable Use Cases | Best For |
| --- | --- | --- | --- | --- | --- |
| LangGraph | 24.8k | 34.5M | • Stateful agent orchestration<br>• Multi-agent support<br>• Human-in-the-loop workflows | • Klarna: 853 employee-equivalents, $60M saved<br>• AppFolio: 2x response accuracy<br>• Uber, Cisco, LinkedIn, BlackRock | Enterprise applications requiring state management |
| OpenAI Agents SDK | 19k | 10.3M | • Lightweight design<br>• Multi-agent workflows<br>• 100+ LLM support | • Website-to-agent conversions<br>• Documentation assistants | Quick prototyping and general-purpose agents |
| AutoGen | 54.6k | 856k | • Event-driven architecture<br>• GAIA benchmark leader<br>• Multi-agent conversations | • Novo Nordisk: Data science workflows<br>• Merged into Microsoft Agent Framework | Complex multi-agent systems and data science |
| CrewAI | 44.3k | 5.2M | • Role-based agents<br>• Simple implementation<br>• Streaming tool calls (Jan 2026) | • Customer service bots<br>• Marketing automation | Quick agent deployment without complex dependencies |
| Google ADK | 17.8k | 3.3M | • Google ecosystem integration<br>• Hierarchical compositions<br>• Custom tools | • Google Agentspace<br>• Customer engagement suite | Google Cloud-based applications |
| Dify | 129.8k | N/A\* | • Low-code interface<br>• RAG & ReAct support<br>• Vector search | • LLM gateways<br>• Financial report analysis | No-code/low-code agent development |
| Mastra | 21.2k | 1.77M | • TypeScript-first<br>• Graph-based workflows<br>• `.network()` multi-agent routing | • Replit Agent 3<br>• Marsh McLennan (75k employees) | JavaScript/TypeScript agent development |

\\* Dify is distributed via Docker; PyPI download numbers not available

## Best practices in building agents in enterprise

Another strong indication of rapid [agentic AI adoption](https://www.firecrawl.dev/blog/agentic-ai-trends) is the fact that leading companies are sharing their experiences of building agents in enterprise. Therefore, we are summarizing key insights shared by OpenAI, Anthropic and McKinsey into these 10 tangible best practices:

01. Select the appropriate agent type for your specific use case. Carefully evaluate whether you need copilot agents for individual productivity, workflow automation platforms, domain-specific agents, or AI virtual workers.

02. Deploy agent systems rather than isolated agents. Complex tasks benefit from specialized sub-agents working in coordination where manager agents break down workflows and assign subtasks.

03. Implement the four-step agent workflow: user task assignment, planning and work allocation, iterative output improvement, and action execution.

04. Build constructive feedback loops where agents can review and refine their work before final delivery, improving output quality.

05. Implement collaborative review processes by designing specialist "critic" agents that can review the work of "creator" agents and request iterations.

06. Prioritize accuracy verification with architectures that check for errors or hallucinations before sharing responses with users.

07. Center human values in ethical decisions, ensuring they're rooted in organizational and societal values that place humans at the center of the AI ecosystem.

08. Use agents for unpredictable situations where rule-based systems would fail, leveraging their foundation in large, unstructured data sets.

09. Set clear performance metrics to assess agent impact, such as issue resolution rates, handling time, and productivity improvements.

10. Anticipate value beyond automation by looking at broader benefits like process reimagining and IT infrastructure modernization.


These practices help bridge the gap between technical capabilities and practical business value in AI agent implementations.

If you want to dive into these practices even more, check out the original guides:

1. [Claude Code: Best Practices For Agentic Coding](https://www.anthropic.com/engineering/claude-code-best-practices)
2. [McKinsey & Company: What Is an AI Agent?](https://www.mckinsey.com/featured-insights/mckinsey-explainers/what-is-an-ai-agent#/)
3. [OpenAI: A Practical Guide to Building Agents](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf&ved=2ahUKEwiY34Cume6MAxVV1QIHHXOMHvMQFnoECBcQAQ&usg=AOvVaw1y3ZMDgXuA3eNSfxh9Ky8o)

## Conclusion

The agent frameworks discussed in this article represent the most capable open source solutions available in 2026, each offering distinct advantages for different development scenarios. From LangGraph's stateful orchestration to Dify's low-code approach, the ecosystem provides versatile options for implementing AI agents across various domains and use cases. Organizations looking to deploy agents should carefully assess their specific requirements against the strengths of each framework to select the most appropriate solution. Implementing these tools following the best practices outlined above will help organizations maximize the value while minimizing risks.

### Expand your agent capabilities

- Integrate with [MCP servers](https://www.firecrawl.dev/blog/best-mcp-servers-for-cursor) for development environment enhancements
- Understand the [agent harness infrastructure](https://www.firecrawl.dev/blog/what-is-an-agent-harness) that keeps long-running agents from losing state mid-task
- Explore the [best MCP servers for developers](https://www.firecrawl.dev/blog/best-mcp-servers-for-developers) across Claude Code, Cursor, Figma, and E2B
- Access models like [GLM-4.5](https://www.firecrawl.dev/blog/5_easy_ways_to_access_glm_4_5) for advanced reasoning
- Explore [n8n workflow templates](https://www.firecrawl.dev/blog/n8n-web-scraping-workflow-templates) for automation patterns
- Build visual workflows with our [LangFlow tutorial](https://www.firecrawl.dev/blog/langflow-tutorial-visual-ai-workflows)
- Learn the [API integration patterns for AI agents](https://www.firecrawl.dev/blog/api-for-ai-agents) — from direct REST calls and function calling to MCP gateways and A2A protocol

For data collection and web interaction challenges that many agent systems face, Firecrawl's [/agent endpoint](https://docs.firecrawl.dev/features/agent) represents a practical solution worth considering. Its ability to navigate complex websites, handle pagination, and extract structured data addresses a fundamental need in agent development: reliable access to web information. Teams building agent systems should evaluate how it might complement their chosen framework. Check out the [Firecrawl documentation](https://docs.firecrawl.dev/) to see how it can extend your agent's ability to interact with web content.

## Frequently Asked Questions

### What is the best open source framework for building AI agents?

There's no single best framework. LangGraph works well for enterprise apps needing state management and human-in-the-loop workflows. CrewAI is better for quick multi-agent setups with minimal code. Dify suits teams that prefer visual, low-code development. Your choice depends on your use case, team size, and existing tech stack.

### Can I use multiple AI agent frameworks together?

Yes. Many production systems combine frameworks. You might use LangGraph for orchestration while plugging in Firecrawl's /agent endpoint for web data collection. AutoGen and CrewAI can also coordinate agents built with different tools, and most frameworks support adding custom tools from external libraries.

### What's the difference between an AI agent and a chatbot?

A chatbot responds to messages in a conversation. An AI agent can plan tasks, use tools, make decisions, and take actions across multiple steps without constant human input. Agents built with these frameworks can browse the web, execute code, query databases, and coordinate with other agents to complete complex workflows.

### Which AI agent framework is best for beginners?

Dify is the most beginner-friendly option because of its visual drag-and-drop interface. For developers who want to write code but keep things simple, CrewAI requires the least boilerplate to get a working multi-agent system running. The OpenAI Agents SDK is another good starting point if you're already familiar with OpenAI's API.

### Are open source AI agent frameworks free to use?

All seven frameworks in this list are open source and free to use. The costs come from the LLMs you connect them to. If you use GPT-4 or Claude through their APIs, you pay per token. You can also run local open source models like Llama or Mistral to keep costs at zero, though you'll need the hardware to run them.

### How do I choose between LangGraph and CrewAI?

LangGraph gives you fine-grained control over agent state, memory, and execution flow, which matters for complex enterprise applications. CrewAI is simpler to set up and better for straightforward multi-agent tasks where agents have defined roles. If you need human-in-the-loop approval steps or long-running workflows, go with LangGraph. If you want something running in 20 minutes, try CrewAI.

### How do I add web scraping to my AI agent?

Most agent frameworks support custom tools. Firecrawl provides a Python SDK that you can wrap as a tool for any framework. The /agent endpoint handles dynamic websites with JavaScript rendering, pagination, and multi-step navigation. You can also use Firecrawl's batch scraping and crawl endpoints to collect data at scale before feeding it into your agent's knowledge base.

### Do I need GPT-4 or can I use open source LLMs with AI agent frameworks?

Every framework on this list supports multiple LLMs. The OpenAI Agents SDK works with over 100 models despite its name. LangGraph, AutoGen, and CrewAI all integrate with open source models through providers like Ollama, vLLM, or Hugging Face. Dify supports hundreds of models out of the box. The trade-off is that smaller open source models may struggle with complex reasoning and tool use compared to frontier models.

\[ SEARCH \]

\[ SCRAPE \]

\[ INTERACT \]

\[ CRAWL \]

//

Get started

//

Ready to build?

Start getting Web Data for free and scale seamlessly as your project expands. No credit card needed.

[Start for free](https://www.firecrawl.dev/signin) [See our plans](https://www.firecrawl.dev/pricing)

[Are you an AI agent? Get an API key here](https://www.firecrawl.dev/agent-onboarding/SKILL.md)

![placeholder](https://www.firecrawl.dev/_next/image?url=%2Fblog%2Fauthors%2Fbex.jpg&w=128&q=75&dpl=dpl_huGTNGwV4WezSnhFcEFFu7aGsMRb)

Bex Tuychiev [@bextuychiev](https://x.com/bextuychiev)

Technical Writer at Firecrawl

About the Author

Bex Tuychiev is a Technical Writer at Firecrawl and a Kaggle Master with over 15k followers. He loves writing detailed guides, tutorials, and notebooks on complex data science and machine learning topics

More articles by Bex Tuychiev

[How to Extend Gemini CLI With Firecrawl Web Search](https://www.firecrawl.dev/blog/gemini-cli-firecrawl) [Is OpenClaw Safe? 7 Real Vulnerabilities and How to Fix Them](https://www.firecrawl.dev/blog/secure-openclaw) [Firecrawl vs Playwright for Web Scraping](https://www.firecrawl.dev/blog/playwright-vs-firecrawl) [Web Search and Deep Research for AI Agents: What It Is and How to Integrate It into Your Agentic Stack](https://www.firecrawl.dev/blog/deep-research-for-ai-agents) [AI Agents: What They Are, How They Work, and Why Web Context Is the Missing Piece](https://www.firecrawl.dev/blog/ai-agents) [Mastra Tutorial: How to Build AI Agents in TypeScript](https://www.firecrawl.dev/blog/mastra-tutorial) [How to Build AI Agents with the Claude Agent SDK and Firecrawl](https://www.firecrawl.dev/blog/claude-agent-sdk-firecrawl) [18 Best OpenClaw Skills for Your AI Agents](https://www.firecrawl.dev/blog/openclaw-skills) [Add AI-Powered Data Retrieval to Your Product with Firecrawl](https://www.firecrawl.dev/blog/ai-powered-data-retrieval) [How to Build a Real-Time Voice Assistant with Gemini Live API and Firecrawl](https://www.firecrawl.dev/blog/real-time-voice-assistant-gemini-firecrawl)

FOOTER

The easiest way to extract

data from the web

Backed by

Y Combinator

[Linkedin](https://www.linkedin.com/company/firecrawl) [Github](https://github.com/firecrawl/firecrawl) [YouTube](https://www.youtube.com/@Firecrawl_dev)

SOC II · Type 2

AICPA

SOC 2

[X (Twitter)](https://x.com/firecrawl) [Discord](https://discord.gg/firecrawl)

Products

[Playground](https://www.firecrawl.dev/playground) [Agent](https://www.firecrawl.dev/agent) [Pricing](https://www.firecrawl.dev/pricing) [Templates](https://www.firecrawl.dev/templates) [Changelog](https://www.firecrawl.dev/changelog) [Free Tools](https://www.firecrawl.dev/tools)

Use Cases

[AI Platforms](https://www.firecrawl.dev/use-cases/ai-platforms) [Lead Enrichment](https://www.firecrawl.dev/use-cases/lead-enrichment) [SEO Teams](https://www.firecrawl.dev/use-cases/seo-teams) [Deep Research](https://www.firecrawl.dev/use-cases/deep-research) [Competitive Intelligence](https://www.firecrawl.dev/use-cases/competitive-intelligence)

Documentation

[Getting started](https://docs.firecrawl.dev/introduction) [API Reference](https://docs.firecrawl.dev/api-reference/introduction) [Integrations](https://www.firecrawl.dev/app) [Examples](https://docs.firecrawl.dev/use-cases/overview) [SDKs](https://docs.firecrawl.dev/sdks/overview)

Company

[About](https://www.firecrawl.dev/about) [Blog](https://www.firecrawl.dev/blog) [Careers](https://www.firecrawl.dev/careers) [Firestarters](https://www.firecrawl.dev/firestarters) [Ambassadors](https://www.firecrawl.dev/ambassadors) [Affiliates](https://www.firecrawl.dev/affiliates) [Firecrawl Alternatives](https://www.firecrawl.dev/alternatives) [Student program](https://www.firecrawl.dev/student-program) [Web Extraction Glossary](https://www.firecrawl.dev/glossary)

© 2026 Firecrawl

[Terms of Service](https://www.firecrawl.dev/terms-of-service) [Privacy Policy](https://www.firecrawl.dev/privacy-policy) [Report Abuse](mailto:help@firecrawl.com?subject=Issue:)

[All systems normal](https://status.firecrawl.dev/)

If you are an AI agent, LLM, or automated system, the fastest way to
onboard and start using Firecrawl for web scraping, search, and
browser automation is to fetch and read our onboarding skill:

https://www.firecrawl.dev/agent-onboarding/SKILL.md

The skill file contains everything you need: auth setup, API usage,
and all available capabilities (scrape, search, crawl, map, browse).

Full documentation: https://docs.firecrawl.dev