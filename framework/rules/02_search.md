# 02 — Searching for positions

## Before searching

1. Requirements are `confirmed`, or the user explicitly asked to search anyway (note "searched before requirements were confirmed" in the summary).
2. You have checked the indexes (see 03): `positions.tsv`, `companies.tsv`, recent lines of `search_runs.tsv`.
3. You have read `workspace/shared/analysis/preference_model.md`, especially "To verify" and "Search hints".
4. **If the target area is unclear, ask.** Never assume a region. If the situation file mentions a move, confirm whether to search around the current or the future location.

## How many

- Default: **recommend 5–10 positions per session**. Look at as many as needed, but log everything in `search_runs.tsv`.
- The user's setting in `requirements.md` ("Search settings") overrides this.
- Fewer and accurate beats many and noisy.

## Use diverse methods

Use **at least 2 different methods** per session, preferring methods / sources used less recently (check `search_runs.tsv`).

| Code | Method | Description |
|---|---|---|
| M1 | Job board keyword search | job type × skills × area |
| M2 | Skill-first reverse search | find companies that need the user's skills, then check their careers page |
| M3 | Company discovery | industry maps, listed companies, funding news → careers page |
| M4 | ATS direct search | `site:` searches on public ATS pages (HERP, Greenhouse, Lever, …) |
| M5 | Similar expansion | from highly rated positions: competitors, same industry, same investors |
| M6 | Community & events | company tech/business blogs, event sponsors, industry communities |
| M7 | English-environment boards | boards specialized in English-speaking roles in Japan |
| M8 | Probe (relaxed condition) | deliberately relax one non-hard condition to find the user's real boundary. Max per session: user setting (default 1–2). Always label it as a probe and state which condition was relaxed |

## Choosing sources

- Use **only Tier A / B sources** in `framework/sources/job_sources_japan.md`, mainly Tier A. Ask the user before using anything else.
- Read `workspace/profile/used_sites.md` and respect the user's opinions of each site.
- Check `search_runs.tsv` to avoid using the same source every time.

## Reliability checks (for every candidate)

Exclude, or clearly flag concerns on the card, when:
- **Anonymous postings** (company name hidden, e.g. 「大手メーカー」 posted by a recruitment agency) → follow the user's setting in `requirements.md`; if unset, ask.
- Posting date unknown or older than 3 months → confirm on the company's own site / ATS that it is still open; otherwise mark "validity unknown".
- Aggregator results (Tier B) → find the original posting and use its URL.
- Unrealistically wide salary range, vague duties, hype-only wording.
- Dispatch (派遣) / SES / client-site work → only if the user's requirements allow it.
- Unfamiliar small company → confirm it exists (company website, 国税庁 法人番号公表サイト).

## Filtering and evaluating

1. **Does not meet a hard condition → exclude.** Count it as `excluded` in `search_runs.tsv` (no card needed).
2. Duplicate check (03). Do not recommend a known position again unless it changed materially (salary, conditions) and that is worth telling.
3. Company marked `avoid` in `companies.tsv` → exclude.
4. Score the rest against `preference_model.md`. Write **reasons** and **concerns** honestly, including mismatches.
5. Confirm the posting is still open where possible; otherwise say so.

## Output

- Search process (queries, what you saw, why you excluded) → `workspace/agents/<agent-id>/searches/YYYY-MM-DD_NN.md`
- Recommendation list → `workspace/agents/<agent-id>/recommendations/YYYY-MM-DD.md` (template `framework/templates/agent/recommendation.md`; include an empty "Your feedback" block for each position and tell the user where the file is)
- Each recommended position → a card in `workspace/shared/positions/` and a row in `positions.tsv` (03)
- Each search action → a row in `search_runs.tsv`

## Language

- Job information (company, title, description, conditions) **stays in the original language**.
- Your reasons, concerns and analysis use the user's conversation language.

## Limits

- **`05_privacy_and_safety.md` takes precedence.** In short:
  - **Never log in. Only use pages visible without logging in.** If a login wall appears, skip it and note "login required, skipped" in the log.
  - **No personal data in queries.** Abstract the background into generic terms first.
  - Never submit forms.
- Respect each site's terms of use. No high-frequency bulk fetching.
- Unknown information (actual salary, turnover) is written as "unknown". Never make it up.
