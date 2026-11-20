# Workflow: feedback and analysis

**Triggers**: "I wrote my feedback", "Here's my feedback", "About <company> …", "Analyze", "Show me the conclusions", 「フィードバックを書いたので確認して」「分析して」「結論を見せて」, etc.

## Feedback

1. Collect unprocessed feedback:
   - **Written in files**: blocks marked `<!-- status: pending -->` with text, in every agent's `workspace/agents/*/recommendations/*.md`.
   - **In conversation**: identify the position (id, company name or URL) and find its card via `positions.tsv` (grep / Select-String).
2. Record according to `rules/04_feedback_and_analysis.md`: the card's feedback section (quote + interpretation + tags), `status` / `rating` in `positions.tsv`, and `companies.tsv` if needed. Mark file blocks as `<!-- status: processed YYYY-MM-DD agent-id -->`.
3. Briefly tell the user how you interpreted each piece of feedback, and ask 1–2 follow-up questions only where it is vague or seems to contradict earlier feedback. Do not interrogate.

## Analysis (5+ new pieces of feedback, a contradiction, or on request)

1. Collect feedback since the last analysis (see "Last updated" in `preference_model.md`; find rated rows in `positions.tsv`).
2. Write `workspace/shared/analysis/log/YYYY-MM-DD_<agent-id>.md` (including the light cross-review table).
3. Update `preference_model.md`, and **rewrite "Summary for you"** at the top.
4. Confirm the main findings with the user ("I noticed …, is that right?"); promote confirmed ones into `requirements_clarified.md`.
5. Run `rules/00_session_flow.md` C (end).

## "Show me the conclusions"

Show "Summary for you" from `preference_model.md`, plus open hypotheses with their confidence. If it is outdated (new feedback since "Last updated"), offer to run the analysis first.
