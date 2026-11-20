# ワークフロー：フィードバックと分析

> 日本語訳です。正本は `framework/workflows/feedback.md`（英語）です。

**トリガー**：「フィードバックを書いたので確認して」「フィードバックします」「○○社について…」「分析して」「結論を見せて」"I wrote my feedback" など。

## フィードバック

1. 未処理のフィードバックを集める：
   - **ファイルへの記入**：全エージェントの `workspace/agents/*/recommendations/*.md` のうち、`<!-- status: pending -->` で記入済みのブロック。
   - **会話**：対象の求人を特定（id、会社名、URL）し、`positions.tsv` からカードを探す（grep / Select-String）。
2. `rules/04_feedback_and_analysis.md` に従って記録：カードのフィードバック欄（引用＋解釈＋タグ）、`positions.tsv` の `status` / `rating`、必要なら `companies.tsv`。ファイルのブロックは `<!-- status: processed YYYY-MM-DD agent-id -->` に変更。
3. 各フィードバックをどう解釈したかを簡潔に伝え、曖昧な点や過去の反応と矛盾しそうな点だけ 1〜2 問質問する。問い詰めない。

## 分析（新しいフィードバックが 5 件以上、矛盾がある、または依頼があったとき）

1. 前回の分析以降のフィードバックを集める（`preference_model.md` の「最終更新」を確認し、`positions.tsv` で評価済みの行を探す）。
2. `workspace/shared/analysis/log/YYYY-MM-DD_<agent-id>.md` を書く（簡易クロスレビュー表を含む）。
3. `preference_model.md` を更新し、冒頭の**「あなたへのまとめ」を書き直す**。
4. 主な発見をユーザーに確認（「…のように見えますが、合っていますか？」）。確認できたものは `requirements_clarified.md` に昇格。
5. `rules/00_session_flow.md` の C（終了時）を実行。

## 「結論を見せて」

`preference_model.md` の「あなたへのまとめ」と、確度付きの未確定の仮説を見せる。「最終更新」以降に新しいフィードバックがあれば、先に分析することを提案する。
