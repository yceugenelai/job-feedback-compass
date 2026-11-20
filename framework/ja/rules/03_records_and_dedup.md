# 03 — 記録と重複排除

> 日本語訳です。エージェントが従う正本は `framework/rules/03_records_and_dedup.md`（英語）です。

すべてのエージェントが同じインデックスを共有するため、他のエージェントが推薦した求人を再度推薦してはならない。
データベースは使わない：インデックスは TSV ファイルで、`grep`（bash）または `Select-String`（PowerShell）で検索する。

## インデックスファイル（`workspace/shared/index/`、UTF-8、タブ区切り、1行目はヘッダー）

### positions.tsv — カードを作成したすべての求人

| 列 | 説明 |
|---|---|
| id | `<作成者>-NNNN`（例：`claude-0001`、`codex-0003`、`user-0001`）。自分のプレフィックスの最大番号 +1 を使うため、エージェント間で衝突しない |
| dedup_key | `正規化した会社名|正規化した職種名`（ルールは後述） |
| company | 会社名（原文） |
| title | 職種名（原文） |
| location | 勤務地 |
| remote | `full` / `hybrid` / `onsite` / `unknown` |
| salary | 年収レンジ（万円）。例 `600-900`、不明は `?` |
| url | トラッキングパラメータを除いた求人 URL |
| source | ソースコード（ソース一覧参照） |
| found_by | agent-id または `user` |
| found_date | YYYY-MM-DD |
| status | 下記参照 |
| rating | ユーザー評価 1〜5、未評価は空欄 |
| card | カードのパス（例 `positions/claude-0001.md`） |

**status**：`new` → `recommended` → `reviewed` → `interested` / `rejected_by_user` → `applied` → `interviewing` → `offer` / `rejected_by_company` / `withdrawn`、または `closed`（掲載終了）。

### companies.tsv — 企業単位の判断

| 列 | 説明 |
|---|---|
| company_key | 正規化した会社名 |
| company | 会社名（原文） |
| verdict | `interested` / `neutral` / `avoid` |
| reason | 理由（できればユーザーの言葉を引用） |
| updated | `YYYY-MM-DD agent-id` |

ユーザーが「この会社は避けたい」と言ったら `avoid` を記録する。以降すべてのエージェントがスキップする。

### search_runs.tsv — すべての検索アクション

| 列 | 説明 |
|---|---|
| run_id | `YYYYMMDD-<agent-id>-NN` |
| date | YYYY-MM-DD |
| agent | agent-id |
| method | M1〜M8（02 参照） |
| source | ソースコード |
| query | 実際のクエリ・条件（URL でも可） |
| seen | 閲覧件数 |
| excluded | 必須条件・avoid・信頼性で除外した件数 |
| duplicates | 既存と重複した件数 |
| added | 新規カード件数 |
| log | 詳細ログのパス |

出尽くしたクエリ（2回連続で `added = 0` → 手法を変える）や、成果の出るソースの把握に使う。

## 重複チェック

カード作成前に、この順で確認する：
1. **URL** — トラッキングパラメータ（`utm_*` など）、フラグメント、末尾スラッシュを除いて比較。求人 ID を含むパラメータ（`?jid=`、`?jk=` など）は残す。
2. **dedup_key** — 正規化ルール：
   - 会社名：株式会社 / (株) / ㈱ / 合同会社 / 有限会社 / Inc. / Co., Ltd. / K.K. を除去、全角→半角、小文字化、空白・記号を除去。
   - 職種名：【】や [] 内の宣伝文句を除去、全角→半角、小文字化、空白・記号を除去。
   - 同じ求人が複数サイトに掲載されることが多い。dedup_key が同じなら同一求人とみなす。
3. **企業** — companies.tsv で `avoid` → カードを作らない。
4. 同じ企業の別求人はそれぞれカードを作るが、推薦時はまとめて提示し、違いを説明する。
5. 複数のエージェントが同時に動いている場合は、追記直前にもう一度確認する。

## インデックスの検索（トークン節約）

**TSV ファイル全体をコンテキストに読み込まない。** 必要な行だけ取得する。

| 目的 | bash | PowerShell |
|---|---|---|
| 重複チェック | `grep -i "<キーワード>" workspace/shared/index/positions.tsv` | `Select-String -Path workspace/shared/index/positions.tsv -Pattern "<キーワード>"` |
| 自分の最新 id | `grep "^claude-" workspace/shared/index/positions.tsv \| tail -1` | `Select-String -Path workspace/shared/index/positions.tsv -Pattern "^claude-" \| Select-Object -Last 1` |
| avoid の企業 | `grep -P "\tavoid\t" workspace/shared/index/companies.tsv` | `Select-String -Path workspace/shared/index/companies.tsv -Pattern "\tavoid\t"` |
| 直近の検索 | `tail -10 workspace/shared/index/search_runs.tsv` | `Get-Content workspace/shared/index/search_runs.tsv -Tail 10` |
| ソース別の回数 | `grep -c "\t<source>\t" workspace/shared/index/search_runs.tsv` | `(Select-String -Path workspace/shared/index/search_runs.tsv -Pattern "\t<source>\t").Count` |

列の順番が必要なときだけヘッダーを読む（`head -1` / `Get-Content -TotalCount 1`）。

## 書き込み

- **行の追記のみ。** 並べ替え・削除はしない。status / rating の変更は該当行の列を書き換える。
- 区切りはタブ。値の中にタブや改行を入れない。

## 求人カード（`workspace/shared/positions/<id>.md`）

テンプレート：`framework/templates/shared/position_card.md`。概要、推薦理由と懸念、追記式の**ユーザーフィードバック**欄を含む。
