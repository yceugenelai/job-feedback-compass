# ワークフロー：求人を探す

> 日本語訳です。正本は `framework/workflows/find_jobs.md`（英語）です。

**トリガー**：「探して」「求人を探し始めて」"Start searching" など。

1. `rules/00_session_flow.md` の A（開始時）を実行。
2. `workspace/shared/requirements_clarified.md` の `status` を確認：
   - `confirmed` → 手順 3 へ。
   - それ以外 → 条件が未確定であることを伝え、整理を提案（`rules/01_clarification.md`）。ユーザーが「そのまま検索して」と言った場合のみスキップし、要約に記録。
3. 範囲を一言で確認（特に希望がなければ既定値）：エリア、推薦件数、重点を置きたい方向。
4. `preference_model.md` の「要検証」「検索のヒント」と `search_runs.tsv` の直近の行を読む → 2種類以上の手法を選ぶ。
5. 検索 → 絞り込み → 信頼性チェック → 重複排除 → カード作成（`rules/02_search.md`、`rules/03_records_and_dedup.md`）。
6. `workspace/agents/<agent-id>/recommendations/YYYY-MM-DD.md` を書き（求人ごとに空の「あなたの感想」欄）、会話で各求人を簡潔に紹介（求人情報は原文のまま）。
7. ファイルの場所を伝え、そこに感想を書いて「フィードバックを書いたので確認して」と言うか、会話でそのまま返答できることを案内 → `feedback.md` ワークフローへ。
8. `rules/00_session_flow.md` の C（終了時）を実行。
