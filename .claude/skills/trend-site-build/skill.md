---
name: trend-site-build
description: "cc-trends 웹사이트 빌드·업데이트. 큐레이션된 JSON을 사이트에 주입하고, 정적 HTML 또는 Next.js 빌드를 실행. 아카이브 백업, 롤백 처리. site-builder 에이전트 전용."
---

# Trend Site Build — 사이트 빌드

## 사이트 구조

최초 MVP는 **정적 HTML + Vanilla JS + JSON 데이터**로 시작 (배포 의존성 최소화).
향후 Next.js로 승격 고려.

```
cc-trends/site/
├── index.html
├── styles.css
├── app.js
└── public/data/
    └── latest.json
cc-trends/data/archive/
└── YYYY-MM-DD.json
```

## 업데이트 절차
1. 현재 `site/public/data/latest.json`을 `data/archive/$(date +%F).json`으로 복사
2. `_workspace/04_curated.json`을 `site/public/data/latest.json`으로 덮어쓰기
3. JSON 유효성 검증 (`python3 -m json.tool` 또는 jq)
4. 정적 사이트면 검증 완료로 간주, Next.js면 `npm run build` 실행
5. 로컬 프리뷰: `python3 -m http.server 8000 --directory site` (정적) 또는 `npm run dev`
6. 변경 요약 계산:
   - 신규 아이템 수 (이전 latest에 없던 id)
   - 제거된 아이템 수
   - 순위 변동 Top 5

## 변경 요약 출력
```json
{
  "updated_at": "2026-04-13T10:30:00Z",
  "added": ["owner/new-repo", ...],
  "removed": ["owner/old-repo", ...],
  "rank_changes": [
    {"id": "...", "before": 5, "after": 1, "delta": "+4"}
  ]
}
```

## 롤백
빌드 실패 또는 JSON 검증 실패 시:
```bash
cp data/archive/$(ls data/archive | tail -1) site/public/data/latest.json
```
그리고 오케스트레이터에 실패 사유 보고.

## 프론트엔드 요구사항 (index.html / app.js)
- Rising / Classic 섹션 분리
- 카드: 제목, 캐치프레이즈, 배지, 카테고리, stars, 링크
- 필터: 카테고리(agent/skill/harness/mcp), 배지(Rising/Classic/한국어/신상)
- 검색창 (클라이언트 사이드 즉시 필터링)
- 반응형 (모바일 1열, 태블릿 2열, 데스크탑 3열)
- 다크모드 prefers-color-scheme 대응

## 검증 체크리스트
- [ ] latest.json이 올바른 JSON
- [ ] 백업 파일 생성됨
- [ ] 로컬 프리뷰에서 카드 렌더링 확인
- [ ] 모든 링크 `target="_blank" rel="noopener"`
- [ ] 변경 요약이 오케스트레이터에 보고됨
