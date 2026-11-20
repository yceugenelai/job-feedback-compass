# Workflow: import past positions (from recruiters, or found by the user)

**Triggers**: "Import past positions", "I filled in past_positions", "A recruiter sent me this: …", 「過去の求人を取り込んで」, etc.

The user fills in `workspace/profile/past_positions.md` by hand (or pastes into the conversation). The agent converts it into the standard format:

1. Read the rows in `workspace/profile/past_positions.md` whose `imported` column is empty.
2. For each:
   - Duplicate check (`rules/03_records_and_dedup.md`). If it already exists, only append the feedback to the existing card.
   - id `user-NNNN`, `found_by` = `user`, `source` = `agency:<name>` for recruiters/agencies or `self` for the user's own finds (or the site code if known).
   - Create a card; the user's impressions go into the feedback section (quote + interpretation + tags), dated when the user saw it (or the import date, noted as such).
   - If there is an outcome (not applied, rejected at document screening, withdrew, …), set the matching `status` and note it on the card.
   - Append to `positions.tsv`.
3. Fill the `imported` column of `past_positions.md` with the id so it is not imported twice.
4. Incomplete information (no URL, only a company name) is fine; use `?` for missing values. **These are mainly feedback data and need not be complete.**
5. If enough feedback has accumulated, offer an analysis (`feedback.md`), e.g. "what recruiters suggested vs what the user actually wants".
6. Run `rules/00_session_flow.md` C (end).
