# 03 — Records and deduplication

All agents share the same indexes, so a position recommended by another agent must not be recommended again.
No database is used: the indexes are TSV files searched with `grep` (bash) or `Select-String` (PowerShell).

## Index files (`workspace/shared/index/`, UTF-8, tab-separated, header on line 1)

### positions.tsv — every position that got a card

| Column | Description |
|---|---|
| id | `<creator>-NNNN`, e.g. `claude-0001`, `codex-0003`, `user-0001`. Take the largest number with your own prefix +1, so agents never collide |
| dedup_key | `normalized-company|normalized-title` (rules below) |
| company | company name (original) |
| title | job title (original) |
| location | work location |
| remote | `full` / `hybrid` / `onsite` / `unknown` |
| salary | annual salary range in 万円, e.g. `600-900`; `?` if unknown |
| url | posting URL without tracking parameters |
| source | source code (see the source list) |
| found_by | agent-id or `user` |
| found_date | YYYY-MM-DD |
| status | see below |
| rating | user rating 1–5, blank if not rated |
| card | card path, e.g. `positions/claude-0001.md` |

**status**: `new` → `recommended` → `reviewed` → `interested` / `rejected_by_user` → `applied` → `interviewing` → `offer` / `rejected_by_company` / `withdrawn`; or `closed` (posting removed).

### companies.tsv — company-level decisions

| Column | Description |
|---|---|
| company_key | normalized company name |
| company | original name |
| verdict | `interested` / `neutral` / `avoid` |
| reason | short reason (quote the user if possible) |
| updated | `YYYY-MM-DD agent-id` |

When the user says "not this company", record `avoid`; every agent will skip it from then on.

### search_runs.tsv — every search action

| Column | Description |
|---|---|
| run_id | `YYYYMMDD-<agent-id>-NN` |
| date | YYYY-MM-DD |
| agent | agent-id |
| method | M1–M8 (see 02) |
| source | source code |
| query | the actual query / conditions (a URL is fine) |
| seen | how many you looked at |
| excluded | excluded by hard conditions / avoid / reliability |
| duplicates | already in the index |
| added | new cards created |
| log | path of the detailed log |

Use it to spot exhausted queries (two runs in a row with `added = 0` → change method) and productive sources.

## Deduplication

Before creating a card, check in this order:
1. **URL** — compare after removing tracking parameters (`utm_*` etc.), fragments and trailing slashes. Keep parameters that carry the job id (some sites use `?jid=`, `?jk=` …).
2. **dedup_key** — normalize:
   - Company: remove 株式会社 / (株) / ㈱ / 合同会社 / 有限会社 / Inc. / Co., Ltd. / K.K., convert full-width to half-width, lower-case, remove spaces and symbols.
   - Title: remove promotional text in 【】 or [], convert full-width to half-width, lower-case, remove spaces and symbols.
   - The same position is often posted on several sites; the same dedup_key means the same position.
3. **Company** — `avoid` in companies.tsv → no card.
4. Different positions at the same company get separate cards but should be presented together, with the differences explained.
5. If several agents run at the same time, check again right before appending.

## Searching the indexes (save tokens)

**Never read an entire TSV file into context.** Fetch only the lines you need.

| Purpose | bash | PowerShell |
|---|---|---|
| Duplicate check | `grep -i "<keyword>" workspace/shared/index/positions.tsv` | `Select-String -Path workspace/shared/index/positions.tsv -Pattern "<keyword>"` |
| Your last id | `grep "^claude-" workspace/shared/index/positions.tsv \| tail -1` | `Select-String -Path workspace/shared/index/positions.tsv -Pattern "^claude-" \| Select-Object -Last 1` |
| Avoided companies | `grep -P "\tavoid\t" workspace/shared/index/companies.tsv` | `Select-String -Path workspace/shared/index/companies.tsv -Pattern "\tavoid\t"` |
| Recent runs | `tail -10 workspace/shared/index/search_runs.tsv` | `Get-Content workspace/shared/index/search_runs.tsv -Tail 10` |
| Runs per source | `grep -c "\t<source>\t" workspace/shared/index/search_runs.tsv` | `(Select-String -Path workspace/shared/index/search_runs.tsv -Pattern "\t<source>\t").Count` |

Read the header (`head -1` / `Get-Content -TotalCount 1`) only when you need the column order.

## Writing

- **Append rows only.** Do not reorder or delete. To change status / rating, edit that row's columns.
- Keep tabs as separators; never put tabs or line breaks inside a value.

## Position cards (`workspace/shared/positions/<id>.md`)

Template: `framework/templates/shared/position_card.md`. Contains the summary, reasons and concerns, and an append-only **user feedback** section.
