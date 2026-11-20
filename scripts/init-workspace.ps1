# Create workspace/ (personal data, ignored by git). Optional: agents can also do this themselves.
# workspace/（個人データ、git 管理外）を作成します。任意：エージェントに作成させることもできます。
# Never overwrites existing files. Safe to run repeatedly. / 既存ファイルは上書きしません。
#
# Usage / 使い方:
#   powershell -ExecutionPolicy Bypass -File scripts/init-workspace.ps1
#   powershell -ExecutionPolicy Bypass -File scripts/init-workspace.ps1 -Agents claude,codex

param(
    [string[]]$Agents = @('claude', 'codex', 'copilot', 'gemini')
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$tpl  = Join-Path $root 'framework/templates'
$ws   = Join-Path $root 'workspace'

function New-Dir([string]$path) {
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "  + dir  $path"
    }
}

function Copy-IfMissing([string]$src, [string]$dst) {
    if (-not (Test-Path $dst)) {
        Copy-Item $src $dst
        Write-Host "  + file $dst"
    } else {
        Write-Host "  = keep $dst"
    }
}

Write-Host "Initializing $ws"

New-Dir (Join-Path $ws 'profile')
foreach ($f in 'profile.md', 'requirements.md', 'situation.md', 'past_positions.md', 'used_sites.md') {
    Copy-IfMissing (Join-Path $tpl "profile/$f") (Join-Path $ws "profile/$f")
}

$shared = Join-Path $ws 'shared'
foreach ($d in 'sessions', 'positions', 'analysis', 'analysis/log', 'index') {
    New-Dir (Join-Path $shared $d)
}
Copy-IfMissing (Join-Path $tpl 'shared/requirements_clarified.md') (Join-Path $shared 'requirements_clarified.md')
Copy-IfMissing (Join-Path $tpl 'shared/open_questions.md')         (Join-Path $shared 'open_questions.md')
Copy-IfMissing (Join-Path $tpl 'shared/preference_model.md')       (Join-Path $shared 'analysis/preference_model.md')
foreach ($f in 'positions.tsv', 'companies.tsv', 'search_runs.tsv') {
    Copy-IfMissing (Join-Path $tpl "shared/index/$f") (Join-Path $shared "index/$f")
}

foreach ($a in $Agents) {
    $ad = Join-Path $ws "agents/$a"
    New-Dir (Join-Path $ad 'searches')
    New-Dir (Join-Path $ad 'recommendations')
    Copy-IfMissing (Join-Path $tpl 'agent/notes.md') (Join-Path $ad 'notes.md')
}

Write-Host ""
Write-Host "Done. Next: fill in workspace/profile/, then talk to an agent."
Write-Host "完了。次は workspace/profile/ に記入して、エージェントと話し始めてください。"
