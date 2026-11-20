# 00 — セッションの流れ（毎回必ず実施）

> 日本語訳です。エージェントが従う正本は `framework/rules/00_session_flow.md`（英語）です。

## A. 開始時

1. **ワークスペースの確認**
   - `workspace/` がなければ、下表に従って `framework/templates/` から作成する（またはユーザーに `scripts/init-workspace.ps1` / `scripts/init-workspace.sh` の実行を依頼する）。
   - `workspace/agents/<自分の agent-id>/` がなければ作成する（`searches/`、`recommendations/`、`notes.md`）。
   - 既存ファイルは絶対に上書きしない。

   | テンプレート | 作成先 |
   |---|---|
   | `framework/templates/profile/*.md` | `workspace/profile/` |
   | `framework/templates/shared/requirements_clarified.md` | `workspace/shared/` |
   | `framework/templates/shared/open_questions.md` | `workspace/shared/` |
   | `framework/templates/shared/preference_model.md` | `workspace/shared/analysis/` |
   | `framework/templates/shared/index/*.tsv` | `workspace/shared/index/` |
   | `framework/templates/agent/notes.md` | `workspace/agents/<agent-id>/` |
   | （空フォルダ） | `workspace/shared/{sessions,positions,analysis/log}`、`workspace/agents/<agent-id>/{searches,recommendations}` |

2. **ユーザーのファイルを読む**（すべて）
   - `workspace/profile/profile.md` — 経歴・スキル
   - `workspace/profile/requirements.md` — 本人が考える希望条件
   - `workspace/profile/situation.md` — 現在の状況（スケジュール、住まい、家計、ビザ、家族など）
   - `workspace/profile/used_sites.md` — 利用したサイト・人材紹介（検索前に詳しく読む）
   - テンプレートのまま（`<!-- SAMPLE -->` が残っている、ほぼ空欄）なら、記入を依頼するか、会話しながら一緒に埋める。
3. **共有コンテキストを読む**
   - `workspace/shared/requirements_clarified.md`
   - `workspace/shared/analysis/preference_model.md`
   - `workspace/shared/sessions/` の**最新 3〜5 件**（どのエージェントのものでも）
   - `workspace/shared/open_questions.md`
4. **ユーザーに簡潔に報告**：現状、未解決の質問、今回の提案（条件整理／検索／フィードバック／分析）。決めるのはユーザー。

## B. セッション中

- 条件整理 → `01_clarification.md`
- 検索 → `02_search.md` + `03_records_and_dedup.md`
- 求人への反応 → `04_feedback_and_analysis.md`
- **重要な決定や事実はその場で書く。** セッションは中断されることがある。

## C. 終了時（またはユーザーが「今日はここまで」と言ったとき）

1. `workspace/shared/sessions/` に要約を追加：ファイル名 `YYYY-MM-DD_<agent-id>_<短いトピック>.md`、テンプレート `framework/templates/shared/session_summary.md`。
2. `workspace/shared/open_questions.md` を更新（新しい質問を追加、解決済みにチェック）。
3. 条件が変わった → `requirements_clarified.md` の変更履歴を更新。
4. 新しいフィードバックがあった → カードと `positions.tsv` に反映済みか確認し、必要に応じて `preference_model.md` を更新。
5. 作成・変更したファイルをユーザーに伝える。

## 書き込みの原則

- 共有ファイルは**追記のみ**、`[YYYY-MM-DD agent-id]` を付ける。他のエージェントの結論を修正するときは原文を残して注記する。
- 日付は常に絶対日付（YYYY-MM-DD）。「先週」「明日」は使わない。
- ユーザー自身の言葉が重要：フィードバックは原文を引用し、その後に解釈を書く。
