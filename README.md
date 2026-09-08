# Agentic AI Learning Lab (GitHub Codespaces)

A ready-to-use cloud dev environment for learning and building Agentic AI /
AI agent workflows. Includes Linux, Docker-in-Docker, Node.js, Python 3.11
with the core agentic AI stack, and the Claude Code CLI.

## First-time setup (after the Codespace finishes building)

1. Authenticate Claude Code:
   ```
   claude
   ```
   Follow the browser login prompt on first run.

2. Set your API keys as environment variables (or use a `.env` file — see
   `.env.example`):
   ```
   export ANTHROPIC_API_KEY="your-key-here"
   export OPENAI_API_KEY="your-key-here"   # optional, only if using OpenAI models
   ```

3. Verify everything works:
   ```
   python3 -c "import langchain, langgraph, anthropic; print('All good!')"
   claude --version
   docker ps
   ```

## Example: your first agent script

```python
# hello_agent.py
import anthropic

client = anthropic.Anthropic()  # reads ANTHROPIC_API_KEY from env

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=200,
    messages=[{"role": "user", "content": "Explain agentic AI in one sentence."}]
)
print(response.content[0].text)
```
Run it with: `python3 hello_agent.py`

## Where to go next
- Try building a simple LangGraph agent loop
- Experiment with an MCP server using the `mcp` package
- Ask Claude Code to scaffold a project: `claude "create a simple ReAct agent using langgraph"`
