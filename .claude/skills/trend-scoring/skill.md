---
name: trend-scoring
description: "Claude Code 리포·게시글의 트렌드 점수를 계산하는 공식. Rising vs Classic 분류, 다중 출처 교차검증 가산점, 편향 방지. trend-analyzer 에이전트 전용."
---

# Trend Scoring — 점수 공식

## 최종 점수 (0~100)
```
score = 0.4 * velocity + 0.3 * community_buzz + 0.2 * quality + 0.1 * recency
```

## 1) Velocity (0~100)
GitHub 기준:
- `v_7d = stars_gained_7d`
- `velocity = min(100, v_7d * 3)` — 하루 평균 10 stars면 100점 근접

신상(생성 30일 내)인데 stars가 낮을 때:
- `velocity = min(100, stars_total * 2)` 로 보정 (연령 짧은 리포 페널티 방지)

## 2) Community Buzz (0~100)
- 커뮤니티 언급 건수 × 각 게시글 engagement의 로그 가중 합
```
buzz = min(100, sum(log(upvotes + comments + 1)) * 10)
```
- **다중 플랫폼 가산**: 3개 이상 플랫폼에서 언급되면 +15
- HN/Reddit 프론트페이지(점수 100+)는 +10

## 3) Quality (0~100)
- README 존재 + 500자 이상: +25
- 라이선스 명시: +10
- 최근 30일 내 커밋: +25
- 테스트/예제 디렉토리: +15
- CI 설정: +10
- 문서화(docs 폴더 또는 README에 섹션 많음): +15

## 4) Recency (0~100)
- 최근 커밋 n일 전: `100 * max(0, 1 - n/60)` (60일 이상 방치면 0)

## Rising vs Classic 분기

**Rising 조건 (OR):**
- `created_at` ≤ 30일 이전
- `velocity_score` ≥ 60 AND 최근 14일 커뮤니티 언급 3건 이상
- HN/Reddit 프론트페이지 최근 7일 내 도달

**Classic 조건 (AND):**
- stars ≥ 500
- created_at ≥ 60일 이전
- 최근 30일 내 커밋 존재

둘 다 해당하면 → Rising (신선도 우선)
둘 다 아니면 → 후보 대기열 (`pending`)

## 편향 방지
- 한국어 README/블로그는 buzz 가중 +10 (영어 커뮤니티 규모 차 보정)
- Anthropic 공식/임직원 프로젝트는 별도 `official` 태그, 점수는 동일하게 매김

## 최종 정렬
- Rising 상위 12개, Classic 상위 12개를 기본 선별
- 동점 시 `updated_at` 최신순

## 출력
```json
{
  "rising": [ {...item with score, why_trending}, ... ],
  "classic": [ ... ],
  "pending": [ ... ],
  "meta": { "total_candidates": N, "generated_at": "..." }
}
```
