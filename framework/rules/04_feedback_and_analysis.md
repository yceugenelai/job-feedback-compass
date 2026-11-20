# 04 — Feedback and preference analysis

What people say they want (stated preference) and how they actually react (revealed preference) often differ. Feedback is the most valuable data in this framework.

## Collecting feedback

Feedback arrives in two ways:
- **Written in files**: the user writes under "Your feedback" in a recommendation file (`workspace/agents/<agent-id>/recommendations/*.md`). Blocks marked `<!-- status: pending -->` that contain text are unprocessed. After recording, change the marker to `<!-- status: processed YYYY-MM-DD agent-id -->`. Check **all agents'** recommendation files, not only your own (reading is allowed; changing the status marker is the only edit you make there).
- **In conversation**: the user simply talks about a position.

If the feedback is short or vague, ask 1–2 follow-up questions, for example:
- Overall: 1–5, or "want to apply / maybe / no"
- **First reaction** (often the real reason)
- What they liked, what bothered them
- "Would you change your mind if X were different?" (finds the deciding factor)

Record:
1. In the card's **user feedback** section: the user's **own words**, your interpretation, and tags.
2. `status` and `rating` in `positions.tsv`.
3. Reactions to the company itself → `companies.tsv`.

## Feedback tags

- Dictionary: `framework/feedback_tags.md` (committed; generic definitions only, no personal data).
- **Agents may add tags**: check that no similar tag exists, then append a row with date and agent-id.
- Tag counts and examples (personal) → "Tag statistics" in `workspace/shared/analysis/preference_model.md`.

## Analysis

### preference_model.md (`workspace/shared/analysis/`, a living document maintained by all agents)

- **Summary for you** (top of the file): short, plain-language conclusions for the user. **Rewrite it after every analysis** — this is where the user looks for the results.
- **Stated vs revealed**: what the user said vs what feedback shows; list conflicts.
- **Hypotheses**: e.g. "remote work matters more than salary", with **evidence** (position ids + quotes) and **confidence** (low / mid / high).
- **Estimated weights** of each factor.
- **To verify**: what the next search or conversation should test.
- **Search hints**: which methods / sources worked, for the next searching agent.

### When to update

- After **5 or more new pieces of feedback**, when a clear contradiction appears, or when the user asks.
- Write the process to `workspace/shared/analysis/log/YYYY-MM-DD_<agent-id>.md` (template `framework/templates/shared/analysis_log.md`), then update `preference_model.md`.
- When you revise another agent's hypothesis, keep the original and add "[date agent-id] revised: … because …".

### Light cross-review (part of the analysis, no separate process)

The purpose is to **improve the next search**, not to score agents. Add a small table to the analysis log:

| Origin (found_by / method) | Recommended | interested or better | One-line observation |
|---|---|---|---|

Put conclusions into "Search hints" or "To verify" in `preference_model.md`.

### Sharing with the user

- **Confirm** findings with the user: "I noticed …, is that right?" Do not state them as facts.
- Inferences the user agrees with can be promoted to `requirements_clarified.md` (source `inferred→confirmed`).

## Principles

- Do not over-infer: 3 or fewer pieces of evidence = low confidence.
- Different agents may hold different views. Listing them side by side ("View A / View B") is better than forcing agreement.
