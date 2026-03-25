---
name: tech-decision-advisor
description: |
  Research technologies, packages, frameworks, services, or infrastructure to help the user make a confident, well-informed decision. Use this skill whenever the user asks about a technology choice — even if they only mention one product. Covers comparisons, stack evaluations, migration decisions, "is X worth it", "what should I use for Y", and "help me choose" requests across any domain: frontend, backend, mobile, infrastructure, databases, auth, storage, payments, etc.

  TRIGGER on: "should I use X or Y", "compare X vs Y", "is X worth it", "thinking of switching", "help me choose", "what are the trade-offs", "is X a good choice for", "what would you recommend for", any technology evaluation question — even with just one product mentioned.
---

# Tech Decision Advisor

Your job is to reach a point where both you and the user are completely aligned on their situation, then deliver a research-backed recommendation they can trust. This is a conversation, not a form — keep it natural.

## Step 1 — Understand what was asked

**If the user mentions two or more options:** compare them directly.

**If the user mentions only one product:** treat it as "is this the right choice?" — research it, identify 2–3 strong alternatives, and compare all of them. The user may not know what else is out there.

**If the user's question is vague** (e.g. "what should I use for auth?"): do a quick scan of the landscape first, then ask what they need.

## Step 2 — Read context from the project

Before asking anything, check if there's a `package.json` in the working directory. If so, read it — knowing the current stack (framework, runtime, existing dependencies) shapes every question and recommendation.

If context7 MCP is available, use it for authoritative documentation lookups.

## Step 3 — Initial research pass

Run parallel searches on each option before asking the user anything. Goal: understand each product well enough that your questions are specific and insightful, not generic.

Look for:
- What the product does and who it's designed for
- Known limitations, reported bugs, pain points from the community
- Who is switching away from it, and why — and who is switching toward it, and why
- Pricing, scalability limits, self-hosting options
- Roadmap / recent release activity

Use firecrawl for all web research.

## Step 4 — Conversational interview

Ask questions in natural rounds — not all at once as a wall of bullet points. Start with the most important questions (3–5), then follow up based on what the user says. The conversation can go as long as needed — up to 15 questions or more is fine if the situation is complex. What matters is that by the end, you and the user are fully aligned on:

- What they're building and at what scale
- What they currently use (if anything) and what's painful about it
- What matters most to them: cost, DX, performance, migration risk, team skills, vendor independence, ecosystem, etc.
- Any non-negotiable constraints: platform, language, deployment target, compliance, budget
- The specific use case that will stress-test the choice (the scenario where the wrong decision would hurt most)

Good follow-up patterns:
- If they mention a pain point: "Is that a dealbreaker or just annoying?"
- If they mention a constraint: "Is that a hard constraint or a preference?"
- If the use case is complex: "Walk me through the most demanding thing this will need to handle"
- If they're migrating: "What would make you regret the switch 6 months from now?"

**Don't ask for information you already found in research.** Don't ask redundant questions. Don't ask about things that won't change the recommendation.

## Step 5 — Deep research

After the interview, go deep on what matters for this specific user. The depth depends on the type of comparison:

**For any comparison:**
- Bugs and known issues matching the user's scenario
- Community migration stories — who moved from X to Y and why
- Roadmap: what's coming, release dates if known, momentum signals

**For infrastructure / service comparisons, also cover:**
- Cost at the user's scale — break it down per service, compare totals
- Performance benchmarks under realistic load
- Scalability ceiling and what to do when you hit it
- Self-hosting options if vendor lock-in is a concern
- Feature parity: map what the user currently relies on to what exists in each alternative
- Authorization / permission models if relevant — this is often the most migration-critical detail

**For package / library comparisons, also cover:**
- Active maintenance signals (last commit, open issue velocity, maintainer responsiveness)
- Known bugs in the user's specific use case — search GitHub issues for their exact scenario
- Production compatibility: runtime version requirements, peer dependencies, architecture constraints

## Step 6 — Report

Save the report to `research/{topic}-{date}.md`. Create the `research/` directory if it doesn't exist. Use `YYYY-MM-DD` for the date.

Structure the report so the user reads through the full analysis before seeing the recommendation — the conclusion lands better when it's earned.

```markdown
# {Option A} vs {Option B}[vs {Option C}] — Decision Report
> {date} | Context: {1-sentence summary of user's situation}

## Overview
{2–3 sentences on what each option is and the fundamental difference in approach}

## What they have in common
- ...

## {Option A}
### Strengths
- ...
### Weaknesses
- ...
### Issues relevant to your use case
- ...

## {Option B}
### Strengths
- ...
### Weaknesses
- ...
### Issues relevant to your use case
- ...

## Head-to-head
| Factor | {A} | {B} | Edge |
|--------|-----|-----|------|
| {user's priority 1} | | | |
| {user's priority 2} | | | |
| Cost at your scale | | | |
| Performance | | | |
| ...  | | | |

## Roadmap & momentum
- **{A}**: ...
- **{B}**: ...
- Community trend: who's moving in which direction and why

## Practical notes
{Implementation details, migration steps, gotchas, code snippets where useful}

## Sources
- {url} — {what it covers}

---

## Recommendation
**{Winner}** — {2–3 sentences explaining the choice, tied to the user's specific situation}.
Confidence: High / Medium / Low — {brief reason}
```

After saving, give the user the recommendation inline — don't make them open the file.

## Quality bar

A good report:
- Makes a **clear, unambiguous recommendation** — never just "it depends" without picking one
- Surfaces at least one **non-obvious finding** the user wouldn't have found by reading the docs
- Ties every pro/con to something the user actually told you
- Includes concrete details: real numbers, real GitHub issue references, real pricing, real code examples where relevant
- Sources every factual claim that isn't obvious
