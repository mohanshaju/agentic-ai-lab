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

echo "Setup complete! Next steps:"
echo "1. Run 'claude' in the terminal and authenticate with your Anthropic account"
echo "2. Activate the Python environment is already global - just run 'python3'"
echo "3. See README.md for example commands to get started"
