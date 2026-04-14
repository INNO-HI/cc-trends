# CC Trends

Claude Code 에이전트 · 하네스 · 스킬 트렌드 모니터링 사이트.

## 실행
```
# 파이프라인 실행 (에이전트 팀)
# Claude Code에서: /cc-trends  또는 "cc-trends 업데이트해줘"

# 사이트 로컬 프리뷰
python3 -m http.server 8000 --directory site
# → http://localhost:8000
```

## 구조
- `.claude/agents/` — 5명의 전문 에이전트 (github-scout, community-scout, trend-analyzer, content-curator, site-builder)
- `.claude/skills/` — github-scan, community-scan, trend-scoring, trend-site-build, cc-trends(오케스트레이터)
- `site/` — 정적 웹사이트 (HTML/CSS/JS + public/data/latest.json)
- `data/archive/` — 주간 스냅샷
- `_workspace/` — 파이프라인 중간 산출물

## 주간 자동 갱신
`schedule` 스킬로 cron 등록 권장.
