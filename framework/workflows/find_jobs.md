# Workflow: find positions

**Triggers**: "Start searching", "Find jobs for me", 「探して」「求人を探し始めて」, etc.

1. Run `rules/00_session_flow.md` A (start).
2. Check `status` in `workspace/shared/requirements_clarified.md`:
   - `confirmed` → go to step 3.
   - Otherwise → tell the user the requirements are not confirmed yet and offer to clarify (`rules/01_clarification.md`). Skip only if the user says "just search", and note it in the summary.
3. Confirm the scope in one line (defaults apply if the user has no opinion): area, number of recommendations, any direction to focus on.
4. Read "To verify" and "Search hints" in `preference_model.md` and the latest lines of `search_runs.tsv` → pick 2 or more methods.
5. Search → filter → reliability check → dedup → create cards (`rules/02_search.md`, `rules/03_records_and_dedup.md`).
6. Write `workspace/agents/<agent-id>/recommendations/YYYY-MM-DD.md` (with an empty "Your feedback" block per position) and briefly introduce each position in the conversation (job information in its original language).
7. Tell the user the file path and that they can either write feedback there and say "I wrote my feedback", or just reply in the conversation → `feedback.md` workflow.
8. Run `rules/00_session_flow.md` C (end).
