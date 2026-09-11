# Hello World Agent

A minimal ReAct-pattern agent built with LangGraph, demonstrating the
reasoning -> tool call -> observation -> final answer loop.

## Run it
1. Copy `.env.example` to `.env` and add your ANTHROPIC_API_KEY
2. `pip install -r requirements.txt` (uses the shared devcontainer environment)
3. `python3 agent.py`

## What it does
Given an applicant's income and debt, the agent calls a DTI (debt-to-income)
calculator tool and returns a risk tier - the same logic from our original
loan-underwriting Skill, now implemented as a LangGraph tool call.