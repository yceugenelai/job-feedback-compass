# job-feedback-compass

**English** | [日本語](#日本語)

Find what you **really** want in a job in Japan — from your own natural-language reactions to real job postings.

AI agents (Claude Code, Codex, GitHub Copilot, …) search public postings, read your feedback, and keep a shared model of your true priorities. Markdown and TSV only — no code, no database. Your data stays in `workspace/` (git-ignored). Agents never log in to sites, submit forms, or put personal data into searches.

## Setup

1. Download: **Code → Download ZIP** on GitHub, then unzip (or `git clone`).
2. Open the folder in your agent:
   - **VS Code** (Claude Code / Copilot agent mode): File → Open Folder
   - **CLI**: `cd job-feedback-compass` then `claude` or `codex`
3. The agent needs web search enabled.

## Usage

| # | You do | Where |
|---|---|---|
| 1 | Say **"Set up my workspace"** | creates `workspace/` |
| 2 | Fill in your background, wishes and situation (blanks are fine) | `workspace/profile/profile.md`, `requirements.md`, `situation.md` |
| 3 | Say **"Let's clarify my requirements"** and answer a few questions | — |
| 4 | Say **"Start searching"** | results: `workspace/agents/<agent>/recommendations/YYYY-MM-DD.md` |
| 5 | Write your impressions under **"Your feedback"** for each position — free text, one line is fine | same file |
| 6 | Say **"I wrote my feedback"** — the agent records it and may ask 1–2 follow-ups | — |
| 7 | Say **"Show me the conclusions"** | `workspace/shared/analysis/preference_model.md` → **Summary for you** |

Repeat 4–7. The more you react, the clearer the picture gets. Optional: list positions you got before (e.g. from recruiters) in `workspace/profile/past_positions.md` and say **"Import past positions"**.

Rules for agents: [AGENTS.md](AGENTS.md) · Japanese translation: [framework/ja/](framework/ja/)

---

## 日本語

実際の求人への**自分の言葉での反応**から、日本での転職で**本当に求めている条件**を見つけるためのフレームワークです。

AI エージェント（Claude Code、Codex、GitHub Copilot など）が公開求人を検索し、あなたの感想を読み取り、本当の優先順位を共有モデルとして育てていきます。Markdown と TSV だけで動き、プログラムやデータベースは不要です。個人データは `workspace/`（git 管理外）に保存されます。エージェントはサイトへのログイン、フォーム送信、個人情報を使った検索を行いません。

## 準備

1. GitHub の **Code → Download ZIP** でダウンロードして解凍（または `git clone`）。
2. エージェントでフォルダを開く：
   - **VS Code**（Claude Code / Copilot のエージェントモード）：ファイル → フォルダーを開く
   - **CLI**：`cd job-feedback-compass` → `claude` または `codex`
3. エージェントの Web 検索を有効にしておく。

## 使い方

| # | やること | 場所 |
|---|---|---|
| 1 | 「**ワークスペースを作って**」と言う | `workspace/` が作成される |
| 2 | 経歴・希望・現状を記入（空欄があっても OK） | `workspace/profile/profile.md`、`requirements.md`、`situation.md` |
| 3 | 「**条件を整理したい**」と言い、いくつかの質問に答える | — |
| 4 | 「**探して**」と言う | 結果：`workspace/agents/<エージェント>/recommendations/YYYY-MM-DD.md` |
| 5 | 各求人の「**あなたの感想**」欄に自由に感想を書く（一言でも OK） | 同じファイル |
| 6 | 「**フィードバックを書いたので確認して**」と言う。エージェントが記録し、必要なら 1〜2 問質問する | — |
| 7 | 「**結論を見せて**」と言う | `workspace/shared/analysis/preference_model.md` の「**あなたへのまとめ**」 |

4〜7 を繰り返すほど、本当の条件がはっきりしていきます。任意：過去に紹介された求人などを `workspace/profile/past_positions.md` に書き、「**過去の求人を取り込んで**」と言うと、それもフィードバックとして使われます。

エージェント向けルール：[AGENTS.md](AGENTS.md) ・ 日本語訳：[framework/ja/](framework/ja/)
