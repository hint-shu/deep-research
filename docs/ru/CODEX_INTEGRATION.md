# Codex CLI Integration (опциональная)

Как использовать OpenAI Codex CLI как **опциональный cross-model research-канал** для L2+ ступеней.

> 🌐 [English version](../CODEX_INTEGRATION.md)

---

## Зачем вообще Codex?

Claude отлично ищет, но у каждой модели есть слепые зоны — training cutoff, какой кусок веба индексируется, как взвешиваются источники. Добавление второй независимой модели эту дыру закрывает.

Codex CLI запускает **GPT-5.4 с agentic web search** (`-c 'web_search="live"'`). Что это даёт:

- Другой search index чем у Anthropic
- Другие biases (GPT vs Claude family)
- Нативный agentic reasoning для multi-hop browsing
- 89.3% на BrowseComp (state of the art на 2026)

Когда L2+ параллельно прогоняет Claude-based и Codex-based поиски, **несогласия между двумя каналами видны сразу** и флагаются в `contradictions.md`.

---

## Нужен ли он мне?

| Ступень | Роль Codex | Обязателен? |
|---------|-----------|-------------|
| L0 | Не используется | Нет |
| L1 | Не используется | Нет |
| L2 | 1 параллельный gap-filler | Нет — L2 работает без него |
| L3 | Neutral-angle + cross-model critic (2 вызова) | Нет — fallback на single-model |
| L4 | Researcher C в команде агентов | Нет — команда работает без C |
| L5 | Researcher C + fact-checker в каждой итерации | Нет — остаётся single-model |

**Короткий ответ:** нет. Лестница работает без Codex. Просто становится single-model на L2+, что значит слабее contradiction-detection.

Если у тебя уже есть подписка ChatGPT Pro ($200/мес за GPT-5.4), добавление Codex ничего не стоит сверху.

---

## Установка

### 1. Установить Codex CLI

**macOS:**

```bash
brew install openai/tap/codex
```

**Другие платформы:** [developers.openai.com/codex/cli](https://developers.openai.com/codex/cli).

### 2. Авторизоваться

```bash
codex auth login
```

Открывает браузер. Залогинься через ChatGPT Pro аккаунт.

### 3. Проверка

```bash
codex --version
# 0.120.0 или выше

codex exec -c 'web_search="live"' --sandbox read-only \
  --skip-git-repo-check --ephemeral \
  "Какая сейчас LTS-версия Node.js?"
```

Если вернулся осмысленный ответ через 60-90 сек — Codex готов.

---

## Как скиллы используют Codex

### Через helper-скрипт

v0.2 использует единый обёртку `~/.claude/scripts/codex-research.sh` (устанавливается автоматически через `install.sh`).

Скиллы вызывают его так:

```bash
bash "$HOME/.claude/scripts/codex-research.sh" \
    180 \
    ".firecrawl/research/$SLUG/L2/codex-gap.md" \
    "Research prompt here"
```

Параметры: `<timeout_secs> <output_file> <prompt>`.

### Коды выхода

Хелпер fault-tolerant — обрабатывает все известные отказы Codex:

| Exit | Значение | Что дальше |
|------|----------|------------|
| 0 | Успех | Файл записан |
| 124 | Timeout | Превышен лимит времени |
| 125 | Отключено через env | `DEEP_RESEARCH_DISABLE_CODEX=1` |
| 126 | Codex не установлен | Установи или игнорируй |
| 127 | Auth expired | `codex auth login` |
| 128 | Rate limit | Подожди, попробуй позже |

Скиллы проверяют `.status` файл рядом с output — там одна строка объясняющая исход.

### Использование по ступеням

**L2 — single gap-filler (параллельно с основной L2 рефлексией):**

Вывод: `L2/codex-gap.md`
Промпт: «заполни пробелы из gap-analysis.md, верни 5-10 фактов с URL»

**L3 — neutral-angle + cross-model critic (два вызова):**

Выводы: `L3/codex-neutral.md`, `L3/codex-critic.md`
Запускаются параллельно с Claude critic agent.

**L4 — Researcher C в команде:**

Вывод: `L4/crew/researcher-c-output.md`
Параллельно с Researcher A (веб) и Researcher B (академ).

**L5 — per-iteration Researcher C + fact-checker:**

Вывод: `L5/iterations/iter-N/codex-{researcher-c,factcheck}.md`
Запускается в каждой итерации до достижения saturation.

---

## Известные ограничения

### Latency

| Задача | Типичное время |
|--------|----------------|
| Один вопрос с web search | 60-90 сек |
| Multi-faceted research prompt | 2-5 мин |

Codex **не на критическом пути** — работает параллельно с собственным research Claude. Если Codex тормозит, Claude финиширует и без него.

### Нет `timeout` на macOS

Macos по умолчанию не имеет `timeout` binary. Хелпер использует `perl -e 'alarm'` как универсальный fallback (perl всегда есть на macOS/Linux).

Альтернатива: `brew install coreutils` даст `gtimeout`.

### Token/quota overhead

Каждый вызов Codex ест ~100K GPT-5.4 токенов внутри. На подписке ChatGPT Pro бесплатно, но считается к weekly usage caps. Heavy L5 использование может упереться в rate limit.

**Митигация:** скиллы деградируют gracefully. Если `codex exec` возвращает не-ноль или тайм-аутит — скилл логирует отказ и продолжает без Codex.

### `resume --last` наследование конфига

Если хочешь продолжить предыдущую сессию через `codex exec resume --last`, помни что **флаги наследуются от первого вызова**. Не можешь сменить `web_search` или `--sandbox` после первого invoke. Выставляй правильно сразу.

### Строгие значения web_search

Только три валидных значения для `-c 'web_search="..."'`:

- `live` — реальный web search (что нам нужно)
- `cached` — предпроиндексированный OpenAI индекс (устаревший, не используй)
- `disabled` — без поиска

Любое другое крашит Codex с exit 1.

---

## Отключение Codex

Если хочешь использовать скиллы *без* Codex:

**Вариант 1 — не устанавливай его.** Скиллы чекают наличие Codex при вызове; если нет — пропускают.

**Вариант 2 — форсно через env:**

```bash
export DEEP_RESEARCH_DISABLE_CODEX=1
```

Любой L2+ скилл будет пропускать Codex вызовы даже если он установлен.

---

## Траблшутинг Codex

| Симптом | Вероятная причина | Фикс |
|---------|--------------------|------|
| `codex: command not found` | Не установлен или PATH не обновлён | `brew install openai/tap/codex`; перезапусти терминал |
| `AUTH_FAILED` в status файле | Токен истёк | `codex auth login` |
| Долгие висы без вывода | Hit weekly rate limit | Временно отключи (env); подожди reset |
| Codex возвращает ерунду | `web_search` стоит на `cached` | Убедись что `-c 'web_search="live"'` |
| `TIMEOUT` в status файле | Codex не успел за лимит | Увеличь timeout в скилле, или подожди и ретрай |

---

## Безопасность

Codex работает с `--sandbox read-only` во всех research вызовах. Он НЕ МОЖЕТ:

- Писать файлы вне `-o` output path
- Выполнять произвольные shell-команды
- Модифицировать твою кодовую базу
- Читать env переменные или credentials которые ему не даны

Output-файл через `-o` — единственное что Codex пишет. Claude читает этот файл чтобы подтянуть findings обратно в синтез.

---

## Когда НЕ использовать Codex

- **Чувствительные/proprietary research темы** — Codex запросы уходят на серверы OpenAI. Если запрос содержит конфиденциал, используй Claude-only режим.
- **Air-gapped или offline среды** — Codex требует интернет + ChatGPT auth.
- **Очень high-volume автоматизация** — упрёшься в rate limits.

---

## Планы на будущее

- **Streaming output** — сейчас ждём полный `-o` файл; streaming позволит Claude начинать синтез раньше
- **MCP-based интеграция** — обернуть Codex как MCP-сервер чтобы скиллы могли звать его через structured tool calls вместо Bash-shell-out
- **Cost telemetry** — трекать per-research Codex usage для бюджетирования

См. [CONTRIBUTING.md](../../CONTRIBUTING.md) если хочешь помочь с чем-то из этого.
