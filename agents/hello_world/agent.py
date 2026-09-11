"""
Hello World Agent - a minimal ReAct pattern agent built with LangGraph.

ReAct = Reasoning + Acting: the agent thinks about what to do, calls a tool
if needed, observes the result, and repeats until it can answer.
"""
import os
from dotenv import load_dotenv
from langchain_anthropic import ChatAnthropic
from langgraph.prebuilt import create_react_agent

load_dotenv()  # reads ANTHROPIC_API_KEY from .env in this folder

# --- Define one real tool the agent can call ---
def get_dti_risk(monthly_income: float, monthly_debt: float) -> str:
    """Calculate debt-to-income ratio and return a risk tier.
    Use this whenever asked to assess loan risk given income and debt figures."""
    dti = round((monthly_debt / monthly_income) * 100, 2)
    if dti <= 36:
        tier = "Low risk"
    elif dti <= 43:
        tier = "Medium risk - manual review required"
    else:
        tier = "High risk - likely decline per policy"
    return f"DTI is {dti}% -> {tier}"

# --- Build the model and the agent ---
model = ChatAnthropic(model="claude-sonnet-5")  # check Anthropic docs for the latest model name if this errors

agent = create_react_agent(model, tools=[get_dti_risk])

# --- Run it ---
if __name__ == "__main__":
    result = agent.invoke({
        "messages": [("user", "An applicant has $8000 monthly income and $3600 in monthly debt. What's their risk tier?")]
    })
    # Print just the final answer, not the full message history
    print(result["messages"][-1].content)