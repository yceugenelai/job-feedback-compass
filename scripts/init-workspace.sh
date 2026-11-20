#!/usr/bin/env bash
# Create workspace/ (personal data, ignored by git). Optional: agents can also do this themselves.
# workspace/（個人データ、git 管理外）を作成します。任意：エージェントに作成させることもできます。
# Never overwrites existing files. Safe to run repeatedly. / 既存ファイルは上書きしません。
#
# Usage / 使い方:
#   bash scripts/init-workspace.sh
#   bash scripts/init-workspace.sh --agents claude,codex

set -euo pipefail

AGENTS=claude,codex,copilot,gemini
while [[ $# -gt 0 ]]; do
  case "$1" in
    --agents) AGENTS="$2"; shift 2 ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
done

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TPL="$ROOT/framework/templates"
WS="$ROOT/workspace"

new_dir() { [[ -d "$1" ]] || { mkdir -p "$1"; echo "  + dir  $1"; }; }
copy_if_missing() {
  if [[ -e "$2" ]]; then echo "  = keep $2"; else cp "$1" "$2"; echo "  + file $2"; fi
}

echo "Initializing $WS"

new_dir "$WS/profile"
for f in profile.md requirements.md situation.md past_positions.md used_sites.md; do
  copy_if_missing "$TPL/profile/$f" "$WS/profile/$f"
done

S="$WS/shared"
for d in sessions positions analysis analysis/log index; do new_dir "$S/$d"; done
copy_if_missing "$TPL/shared/requirements_clarified.md" "$S/requirements_clarified.md"
copy_if_missing "$TPL/shared/open_questions.md"         "$S/open_questions.md"
copy_if_missing "$TPL/shared/preference_model.md"       "$S/analysis/preference_model.md"
for f in positions.tsv companies.tsv search_runs.tsv; do
  copy_if_missing "$TPL/shared/index/$f" "$S/index/$f"
done

IFS=',' read -ra AGENT_LIST <<< "$AGENTS"
for a in "${AGENT_LIST[@]}"; do
  a="$(echo "$a" | tr -d '[:space:]')"
  [[ -n "$a" ]] || continue
  new_dir "$WS/agents/$a/searches"
  new_dir "$WS/agents/$a/recommendations"
  copy_if_missing "$TPL/agent/notes.md" "$WS/agents/$a/notes.md"
done

echo
echo "Done. Next: fill in workspace/profile/, then talk to an agent."
echo "完了。次は workspace/profile/ に記入して、エージェントと話し始めてください。"
