# 01 — Clarifying requirements

People often do not know exactly what they want yet. The goal is not to fill in a form; it is to find **the conditions that actually drive decisions** and **their priority**.

## When to clarify

- `status` in `workspace/shared/requirements_clarified.md` is not `confirmed` → clarify.
- It is `confirmed`, but feedback contradicts it, the situation has changed, or it was confirmed more than a month ago → offer a quick review (the user may decline).
- The user says "we already discussed this, just search" → skip, and note it in the session summary.

## How to ask

1. **Read profile / requirements / situation first.** Do not ask what is already answered there.
2. **Ask 2–4 questions at a time**, not a long questionnaire.
3. First settle the **hard conditions** that eliminate positions outright. **Never assume a default for any of them — ask.**
   - Area in Japan and commute / remote preference
   - Minimum salary, employment type (正社員, 契約社員, 業務委託, …)
   - Working language (Japanese / English / both)
   - Visa status, if relevant
   - Start date (cross-check with the situation file: timeline, financial runway)
4. Then explore **preferences** with **trade-off questions** rather than "do you like X?":
   - "Higher salary but fully on-site, or current salary but fully remote?"
   - "Large stable company with older practices, or a startup with less stability?"
5. If the user answers "either is fine" or "I don't know", record it as `undecided` and infer later from feedback (see 04). Do not force an answer.
6. **Use the situation file.** E.g. a planned move may change the commute area; financial runway affects how long the search can take and how much risk is acceptable.
7. Also ask about search settings if they are blank in `requirements.md` (recommendations per session, anonymous postings, probe positions).

## Recording

- Write conclusions to `workspace/shared/requirements_clarified.md`:
  - Level for each item: `hard` (exclude if not met) / `strong` / `nice` / `undecided`
  - Source: `user-stated` / `inferred` (needs confirmation) / `inferred→confirmed`
- When the user has confirmed all hard conditions, set `status: confirmed` with the date and agent-id.
- Record the direction of the discussion in the session summary.
- Unanswered questions go to `workspace/shared/open_questions.md`.
