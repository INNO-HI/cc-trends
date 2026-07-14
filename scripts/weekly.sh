#!/bin/zsh
# cc-trends weekly pipeline runner (macOS launchd)
set -euo pipefail

# Ensure $HOME-based paths even when run by launchd
export HOME="/Users/flareon078"
export PATH="$HOME/.nvm/versions/node/v22.21.0/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

# Wait indefinitely for background agents to complete (was killing pipeline at 10min ceiling)
export CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS=0

PROJECT_DIR="$HOME/cc-trends"
SITE_DIR="$PROJECT_DIR/site"
LOG_DIR="$PROJECT_DIR/logs"
TS="$(date +%Y-%m-%d_%H%M%S)"
LOG_FILE="$LOG_DIR/weekly_${TS}.log"

exec > "$LOG_FILE" 2>&1

echo "=== cc-trends weekly run · $(date) ==="

# Snapshot the version so we can detect a real update after the pipeline.
BEFORE_VERSION="$(node -p "try { JSON.parse(require('fs').readFileSync('$SITE_DIR/public/data/latest.json','utf8')).version || '' } catch { '' }" 2>/dev/null || echo "")"
echo "Version before run: $BEFORE_VERSION"

cd "$PROJECT_DIR"

# Run the Claude Code pipeline headlessly (auto-accept edits, no interaction).
# The cc-trends skill orchestrates the 5-agent team and writes site/public/data/latest.json.
claude \
  --dangerously-skip-permissions \
  -p "cc-trends 주간 파이프라인을 끝까지 실행해줘. 절대 중간에 return하지 말 것.

필수 완료 조건:
1. github-scout 완료
2. community-scout Phase A + Phase B 둘 다 완료
3. trend-analyzer가 03_analysis.json 파일 실제 작성 완료
4. content-curator가 04_curated.json 실제 작성 완료
5. site-builder가 site/public/data/latest.json의 'version' 필드를 오늘 주차(v$(date +%Y.%m.%d))로 실제 갱신 완료

각 단계가 실제로 파일 시스템에 반영됐는지 확인한 뒤에만 다음 단계로 진행.
백그라운드 태스크 미완료 상태에서 성공 보고 절대 금지.
완료 후 site/public/data/latest.json의 version과 생성 항목 개수를 반드시 보고할 것."

# Verify the pipeline actually updated the data — fail loudly if not
AFTER_VERSION="$(node -p "try { JSON.parse(require('fs').readFileSync('$SITE_DIR/public/data/latest.json','utf8')).version || '' } catch { '' }" 2>/dev/null || echo "")"
echo "Version after run: $AFTER_VERSION"
if [[ "$AFTER_VERSION" == "$BEFORE_VERSION" ]]; then
  echo "❌ Pipeline finished but latest.json version did NOT change ($BEFORE_VERSION)."
  echo "❌ Something is wrong — skipping downstream steps and exiting with non-zero."
  exit 1
fi

echo "--- Pipeline finished. Regenerating RSS feed ---"
node "$PROJECT_DIR/scripts/generate-rss.js" || echo "⚠ RSS generation failed (continuing)"

echo "--- Mirroring archive snapshots into site/ ---"
mkdir -p "$SITE_DIR/public/data/archive"
cp -n "$PROJECT_DIR"/data/archive/2026-*.json "$SITE_DIR/public/data/archive/" 2>/dev/null || true
node "$PROJECT_DIR/scripts/build-archive-index.js" || echo "⚠ archive index gen failed (continuing)"

echo "--- Generating OG image (Top 3 cards) ---"
node "$PROJECT_DIR/scripts/generate-og.js" || echo "⚠ OG generation failed (continuing)"

echo "--- Publishing weekly GitHub Release ---"
bash "$PROJECT_DIR/scripts/auto-release.sh" || echo "⚠ release failed (continuing)"

echo "--- Checking for data changes ---"
cd "$SITE_DIR"
git add public/data/latest.json public/data/archive feed.xml og.svg og.png
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
