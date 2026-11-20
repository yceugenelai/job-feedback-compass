# ワークフロー：過去の求人を取り込む（紹介された求人・自分で見つけた求人）

> 日本語訳です。正本は `framework/workflows/import_past_positions.md`（英語）です。

**トリガー**：「過去の求人を取り込んで」「past_positions を書きました」「エージェントからこの求人が来ました：…」"Import past positions" など。

ユーザーが `workspace/profile/past_positions.md` に手で記入する（または会話に貼り付ける）。エージェントが標準形式に変換する：

1. `workspace/profile/past_positions.md` のうち `imported` 列が空の行を読む。
2. 各行について：
   - 重複チェック（`rules/03_records_and_dedup.md`）。既存なら、既存カードにフィードバックを追記するだけ。
   - id は `user-NNNN`、`found_by` = `user`、`source` は人材紹介なら `agency:<名前>`、自分で見つけたものは `self`（サイトがわかればそのコード）。
   - カードを作成し、ユーザーの感想はフィードバック欄へ（引用＋解釈＋タグ）。日付はユーザーが見た日（不明なら取り込み日とし、その旨を記載）。
   - 結果（応募せず、書類落ち、辞退など）があれば対応する `status` にし、カードに記録。
   - `positions.tsv` に追記。
3. `past_positions.md` の `imported` 列に id を記入し、二重取り込みを防ぐ。
4. 情報が不完全（URL なし、会社名だけ）でも取り込む。欠けている値は `?`。**主にフィードバック用のデータなので、完全である必要はない。**
5. フィードバックが十分たまったら分析を提案（`feedback.md`）。例：「紹介された求人と本人が本当に望むものの違い」。
6. `rules/00_session_flow.md` の C（終了時）を実行。
