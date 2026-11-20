# 00 — Session flow (follow in every session)

## A. At the start

1. **Make sure the workspace exists**
   - If `workspace/` does not exist, create it from `framework/templates/` using the mapping below (or ask the user to run `scripts/init-workspace.ps1` / `scripts/init-workspace.sh`).
   - If `workspace/agents/<your agent-id>/` does not exist, create it (`searches/`, `recommendations/`, `notes.md`).
   - Never overwrite an existing file.

   | Template | Destination |
   |---|---|
   | `framework/templates/profile/*.md` | `workspace/profile/` |
   | `framework/templates/shared/requirements_clarified.md` | `workspace/shared/` |
   | `framework/templates/shared/open_questions.md` | `workspace/shared/` |
   | `framework/templates/shared/preference_model.md` | `workspace/shared/analysis/` |
   | `framework/templates/shared/index/*.tsv` | `workspace/shared/index/` |
   | `framework/templates/agent/notes.md` | `workspace/agents/<agent-id>/` |
   | (empty folders) | `workspace/shared/{sessions,positions,analysis/log}`, `workspace/agents/<agent-id>/{searches,recommendations}` |

2. **Read the user's files** (all of them)
   - `workspace/profile/profile.md` — background and skills
   - `workspace/profile/requirements.md` — what the user thinks they want
   - `workspace/profile/situation.md` — current situation (timeline, housing, finances, visa, family…)
   - `workspace/profile/used_sites.md` — job sites / agencies the user has used (read closely before searching)
   - If a file is still the untouched template (contains `<!-- SAMPLE -->` or is mostly empty), ask the user to fill it in, or fill it together through conversation.
3. **Read the shared context**
   - `workspace/shared/requirements_clarified.md`
   - `workspace/shared/analysis/preference_model.md`
   - The **latest 3–5** files in `workspace/shared/sessions/` (from any agent)
   - `workspace/shared/open_questions.md`
4. **Report briefly to the user**: where things stand, open questions, and what you suggest doing now (clarify / search / feedback / analysis). Let the user decide.

## B. During the session

- Clarifying → `01_clarification.md`
- Searching → `02_search.md` + `03_records_and_dedup.md`
- User reactions to positions → `04_feedback_and_analysis.md`
- **Write important decisions and facts as soon as they happen.** Sessions can be interrupted.

## C. At the end (or when the user says "that's all for now")

1. Add a summary to `workspace/shared/sessions/` named `YYYY-MM-DD_<agent-id>_<short-topic>.md`, using `framework/templates/shared/session_summary.md`.
2. Update `workspace/shared/open_questions.md` (add new ones, check off resolved ones).
3. If requirements changed → update the change log in `requirements_clarified.md`.
4. If there was new feedback → make sure it is in the position cards and `positions.tsv`; update `preference_model.md` if appropriate.
5. Tell the user which files you created or changed.

## Writing principles

- Shared files are **append-only** and tagged `[YYYY-MM-DD agent-id]`. When you revise another agent's conclusion, keep the original and add a note.
- Always use absolute dates (YYYY-MM-DD), never "last week" or "tomorrow".
- The user's own words matter: quote them when recording feedback, then add your interpretation.
