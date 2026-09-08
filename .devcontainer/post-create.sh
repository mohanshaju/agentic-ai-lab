#!/usr/bin/env bash
set -e

echo "===================================================="
echo "Setting up Agentic AI Learning Lab..."
echo "===================================================="

# --- 1. Install Claude Code CLI (via npm, official method) ---
echo "Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code

# --- 2. Upgrade pip and install core Python agentic AI stack ---
echo "Installing Python packages for agentic AI development..."
python3 -m pip install --upgrade pip
python3 -m pip install -r .devcontainer/requirements.txt

# --- 3. Verify installations ---
echo "===================================================="
echo "Verifying installed tools:"
echo "----------------------------------------------------"
echo "Node version:   $(node --version)"
echo "npm version:    $(npm --version)"
echo "Python version: $(python3 --version)"
echo "Docker version: $(docker --version || echo 'Docker starting up, check after full boot')"
echo "Claude Code:    $(claude --version || echo 'Run: claude auth login to finish setup')"
echo "===================================================="

# --- 4. Configure Claude Code to route through OpenRouter (if secret is present) ---
echo "Configuring Claude Code..."
mkdir -p ~/.claude

if [ -n "$OPENROUTER_API_KEY" ]; then
  # OPENROUTER_API_KEY is injected securely by GitHub Codespaces Secrets -
  # it is NEVER written into this script or committed to the repo.
  cat > ~/.claude/settings.json << EOF
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://openrouter.ai/api",
    "ANTHROPIC_AUTH_TOKEN": "$OPENROUTER_API_KEY",
    "ANTHROPIC_API_KEY": ""
  }
}
EOF
  echo "Claude Code configured to route through OpenRouter."
else
  echo "No OPENROUTER_API_KEY secret found - skipping OpenRouter setup."
  echo "Add it under GitHub Settings > Codespaces > Secrets, then rebuild the container."
  echo "Falling back to standard Anthropic login (run 'claude' to authenticate directly)."
fi

echo "===================================================="
echo "Setup complete! Next steps:"
echo "1. Run 'claude' in the terminal - it will use OpenRouter automatically if configured above"
echo "2. Activate the Python environment is already global - just run 'python3'"
echo "3. See README.md for example commands to get started"
