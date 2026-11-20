# Job sources in Japan / 日本の求人ソース一覧

The `code` column is used in the `source` column of `positions.tsv` / `search_runs.tsv`.
`code` 列は `positions.tsv` / `search_runs.tsv` の `source` 列で使います。

## Principles / 方針

1. **Only pages viewable without logging in** (`rules/05_privacy_and_safety.md`), from sites with a clear operator and trustworthy content. Even on Tier A/B sites, skip any page that requires login.
   ログイン不要で閲覧できるページのみ使用。運営元が明確で信頼できるサイトに限る。Tier A/B でもログインが必要なページはスキップ。
2. **The most reliable postings are those published by the company itself** (careers page, company-managed ATS). Verify board postings on the company's own site when possible.
   最も信頼できるのは企業自身が掲載した求人（採用ページ・ATS）。求人サイトの情報は可能な限り企業サイトで確認する。
3. **Do not use sites not on this list without asking the user.** If the user agrees, append the site here with date and agent-id.
   リストにないサイトはユーザーに確認してから使う。了承を得たら日付と agent-id を付けて追記する。
4. The user's own experience with sites is in `workspace/profile/used_sites.md` (personal). Read it and respect it.
   ユーザー自身のサイト利用経験は `workspace/profile/used_sites.md` に記録。検索前に読み、尊重する。

## Tier A — primary (public, reliable) / 主要（公開・信頼性高）

### Posted by the company itself / 企業の直接掲載（最も信頼性が高い）

| code | Name | How to search |
|---|---|---|
| official | Company careers page / 企業の採用ページ | 「<会社名> 採用」 / "<company> careers" |
| herp | HERP Hire | `site:herp.careers <職種> <勤務地>` |
| hrmos | HRMOS 採用 | `site:hrmos.co <職種>` |
| talentio | Talentio | `site:open.talentio.com <職種>` |
| greenhouse | Greenhouse | `site:boards.greenhouse.io <role> Japan` / `site:job-boards.greenhouse.io` |
| lever | Lever | `site:jobs.lever.co <role> Japan` |
| ashby | Ashby | `site:jobs.ashbyhq.com <role> Japan` |
| workable | Workable | `site:apply.workable.com <role> Japan` |

### Major job boards (public browsing) / 大手求人サイト（公開閲覧可）

| code | Name | Notes |
|---|---|---|
| doda | doda | All industries, large volume / 全業種・求人数が多い |
| rikunabi | リクナビNEXT | All industries, large volume / 全業種・求人数が多い |
| mynavi | マイナビ転職 | All industries / 全業種 |
| en | エン転職 | All industries, with reviews / 全業種・口コミあり |
| type | type | Strong in the Tokyo area, IT / sales / 首都圏・IT・営業に強い |
| green | Green | IT / web / startups / IT・Web・スタートアップ |
| forkwell | Forkwell Jobs | Software engineers / エンジニア向け |
| tokyodev | TokyoDev | English-speaking developer roles / 英語環境の開発職 |
| japandev | Japan Dev | English-speaking developer roles with salary / 英語環境の開発職・年収表記あり |

## Tier B — supplementary (verify carefully) / 補助（要確認）

| code | Name | Caution / 注意 |
|---|---|---|
| indeed | Indeed Japan | Aggregator: stale and agency-anonymous postings are common → **verify at the original posting** / 集約型：古い求人・紹介会社の匿名求人が混在 → 元の掲載元で確認必須 |
| stanby | 求人ボックス / スタンバイ | Same as above / 同上 |
| linkedin | LinkedIn Jobs | Public job pages only; skip when asked to log in / ログイン不要の公開ページのみ |
| wantedly | Wantedly | Often no salary or conditions → mark "conditions unknown" / 年収・条件の記載がないことが多い |
| daijob | Daijob | Bilingual roles, many agency postings / バイリンガル向け・紹介会社経由が多い |
| careercross | CareerCross | Same as above / 同上 |
| hellowork | ハローワークインターネットサービス | Public employment service; wide range, check quality / 公的機関・幅広いが内容を要確認 |

## Tier C — not used by agents (login or scout-based) / エージェントは使用しない（ログイン必須・スカウト型）

ビズリーチ, AMBI, JAC Recruitment, Findy, LAPRAS, paiza, 転職ドラフト, レバテックキャリア, Offers, YOUTRUST, Meety, etc.
If the user uses them, they can paste positions or use the import workflow (`found_by` = `user`).
ユーザー自身が使っている場合は、求人を貼り付けるか取り込みワークフローで登録する。

## Company discovery (find companies, then check Tier A pages) / 企業探索（企業を見つけてから Tier A で求人を確認）

- Funding and business news / 資金調達・企業ニュース: PR TIMES, 日本経済新聞, THE BRIDGE
- Company blogs, event sponsors, industry communities / 企業ブログ・イベント協賛企業・業界コミュニティ
- Listed companies / 上場企業一覧（東証）
- Similar companies to highly rated positions (method M5) / 高評価の求人の同業・競合

## Supplementary information (not job sources) / 補足情報（求人ソースではない）

- Company reviews / 口コミ: OpenWork, エン転職 口コミ
- Company existence / 企業の実在確認: 国税庁 法人番号公表サイト, IR / 有価証券報告書
