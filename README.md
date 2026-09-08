# Agentic AI Learning Lab (GitHub Codespaces)

A ready-to-use cloud dev environment for learning and building Agentic AI /
AI agent workflows. Includes Linux, Docker-in-Docker, Node.js 20, Python 3.11
with the core agentic AI stack, and the Claude Code CLI - auto-configured to
route through OpenRouter if you've set up the secret below.

See `agentic_ai_stack_cheatsheet.pdf` in this repo for a full breakdown of
every package installed here and what it's for.

## First-time setup (after the Codespace finishes building)

### 1. Claude Code authentication

If you've set up the `OPENROUTER_API_KEY` Codespaces secret (see below),
Claude Code is **already configured automatically** by `post-create.sh` -
no login needed. Just run:
```
claude
```
and check `/status` inside the session to confirm it's routing through
`https://openrouter.ai/api`.

If you have **not** set up the OpenRouter secret, running `claude` will
prompt you to log in with your Anthropic account directly instead.

### 2. Set your API keys

Copy the template and fill in the keys you actually plan to use:
```
cp .env.example .env
```
Then edit `.env`:
```
ANTHROPIC_API_KEY=your-key-here      # only needed if NOT using OpenRouter
OPENAI_API_KEY=your-key-here         # optional, for OpenAI models
GOOGLE_API_KEY=your-gemini-api-key   # optional, for Gemini models via google-genai or google-adk
```
`.env` is already excluded via `.gitignore` - it will never be committed.

### 3. (Optional) Set up OpenRouter routing for Claude Code

To route Claude Code through OpenRouter instead of Anthropic directly:
1. Go to **GitHub Settings → Codespaces → Secrets** and add a secret named
   `OPENROUTER_API_KEY` with your real OpenRouter key, scoped to this repo.
2. Rebuild or recreate the Codespace (secrets only apply to newly created
   containers).
3. `post-create.sh` will automatically write `~/.claude/settings.json` with
   the correct `ANTHROPIC_BASE_URL` / `ANTHROPIC_AUTH_TOKEN` config - nothing
   further to do.

### 4. Verify everything works

```bash
node --version && npm --version
python3 --version && pip --version
docker --version && docker ps
claude --version
pip list | grep -iE 'langchain|langgraph|crewai|google-adk|google-genai|anthropic|openai|mcp|llama-index|chromadb'
python3 -c "import langchain, langgraph, anthropic; print('Core packages import OK')"
```

## Example: your first agent script

**Using Claude (Anthropic SDK):**
```python
import anthropic

client = anthropic.Anthropic()  # reads ANTHROPIC_API_KEY from env
# or, if routed through OpenRouter, this is handled automatically for Claude Code -
# for direct SDK calls like this, OpenRouter needs its own client setup (see OpenRouter docs)

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=200,
    messages=[{"role": "user", "content": "Explain agentic AI in one sentence."}]
)
print(response.content[0].text)
```

**Using Gemini (google-genai SDK):**
```python
from google import genai

client = genai.Client(api_key="your-gemini-api-key")  # or set GOOGLE_API_KEY env var
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Explain agentic AI in one sentence."
)
print(response.text)
```

Run either with: `python3 hello_agent.py`

## Where to go next
- Try building a simple LangGraph agent loop, then the same agent in Google ADK, and compare
- Experiment with a minimal MCP server using the `mcp` package
- Ask Claude Code to scaffold a project: `claude "create a simple ReAct agent using langgraph"`
- Try a basic RAG lookup with `llama-index` + `chromadb` against a few of your own text files

## Managing this Codespace
- **Stop** it when done for the day (github.com/codespaces → ⋯ → Stop codespace) to avoid burning
  free compute hours on idle time.
- **Restart** the same Codespace to resume exactly where you left off - same hostname, same
  installed packages, same config files.
- Only **delete and recreate** (or "Rebuild Container") if you change `devcontainer.json` or
  `post-create.sh` in a way that needs a fresh build.
