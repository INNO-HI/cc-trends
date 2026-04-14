#!/bin/zsh
# cc-trends weekly pipeline runner (macOS launchd)
set -euo pipefail

# Ensure $HOME-based paths even when run by launchd
export HOME="/Users/flareon078"
export PATH="$HOME/.nvm/versions/node/v22.21.0/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

PROJECT_DIR="$HOME/cc-trends"
SITE_DIR="$PROJECT_DIR/site"
LOG_DIR="$PROJECT_DIR/logs"
TS="$(date +%Y-%m-%d_%H%M%S)"
LOG_FILE="$LOG_DIR/weekly_${TS}.log"

exec > "$LOG_FILE" 2>&1

echo "=== cc-trends weekly run · $(date) ==="

cd "$PROJECT_DIR"

# Run the Claude Code pipeline headlessly (auto-accept edits, no interaction).
# The cc-trends skill orchestrates the 5-agent team and writes site/public/data/latest.json.
claude \
  --dangerously-skip-permissions \
  -p "cc-trends 주간 파이프라인 실행. 5명 에이전트 팀으로 GitHub과 개발자 커뮤니티에서 이번 주 데이터를 수집·분석·큐레이션하고 site/public/data/latest.json을 업데이트한 뒤 완료 보고만 해."

echo "--- Pipeline finished. Regenerating RSS feed ---"
node "$PROJECT_DIR/scripts/generate-rss.js" || echo "⚠ RSS generation failed (continuing)"

echo "--- Checking for data changes ---"
cd "$SITE_DIR"
git add public/data/latest.json feed.xml
if ! git diff --cached --quiet; then
  git -c user.email="noreply@anthropic.com" -c user.name="cc-trends-bot" \
      commit -m "Weekly update · $(date +%Y-%m-%d)"
  git pull --rebase origin main || true
  git push origin main
  echo "✓ Pushed weekly update."
else
  echo "No data changes — skipping commit."
fi

echo "=== done · $(date) ==="
