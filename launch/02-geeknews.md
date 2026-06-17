# GeekNews 게시글 (한글)

## 게시 방법
1. https://news.hada.io/submit
2. 로그인 후 폼 입력
3. URL + 제목 + 본문(GN+ 전용 가능)

## 게시 타이밍
- **요일**: 화요일 또는 수요일 아침
- **시각**: 09:30~10:30 KST (출근 직후 GeekNews 보는 시간)

---

## 제목 (1개 선택)

A) `위클렌드 — Claude Code 에이전트·스킬·MCP 주간 트렌드 인덱스`
B) `Claude Code 도구 자동 큐레이션 — 매주 월요일 갱신되는 위클렌드`
C) `5명의 Claude 서브에이전트가 매주 굴리는 Claude Code 트렌드 사이트`

→ **추천: A** (한국 개발자 검색에 잘 잡힘)

## URL
```
https://inno-hi.github.io/weeklaude/
```

## 본문 (GN+ 전용 공간)

```
Claude Code가 터지면서 에이전트·스킬·MCP·하네스가 매일 수십 개씩 쏟아집니다.
인스타·트위터에서 본 도구가 일주일 지나면 어디 갔는지 기억이 안 나죠.

그래서 만들었습니다. 위클렌드(Weeklaude).

## 뭐가 다른가
- 매주 월요일 09:00 KST 자동 갱신 (수동 PR 안 받음)
- GitHub + HN + Reddit + dev.to + GeekNews + velog 6개 소스 동시 수집
- 4축 점수(velocity·buzz·quality·recency)로 자동 정렬
- 카드마다 한글 요약 + 캐치프레이즈 + 사용 예시
- Rising(이번 주 뜨는) vs Classic(이미 자리잡은) 분리

## 자동화 구조
5명의 Claude Code 서브에이전트가 매주 자동 실행:
- github-scout: GitHub 스캔
- community-scout: 6개 커뮤니티 크롤링 + 후보 리포 역방향 검색
- trend-analyzer: 분류·점수·중복 제거
- content-curator: 한글 큐레이션 + gh api 강제 검증
- site-builder: 정적 사이트 빌드 + GitHub Pages 배포

전체 프롬프트는 .claude/ 아래 공개. 비슷한 도메인(HuggingFace 논문, Rust 크레이트 등)
큐레이션 사이트 만들고 싶은 분은 그대로 포크해서 쓸 수 있습니다.

## 품질 관리
- gh api 강제 검증으로 stars 환각 차단
- 단일 출처 항목 자동 강등 (다중 출처 교차 검증 강제)
- fork·미러·archived 리포 자동 컷
- 한글 번역 5단계 자체 검수

## 차별점
일반 awesome-list와 달리, 매주 자동으로 다시 점수 계산해서 신선도 유지.
GeekNews/velog 등 한국 커뮤니티 가산점 +10으로 영어권 편향 보정.

- 사이트: https://inno-hi.github.io/weeklaude/
- RSS: https://inno-hi.github.io/weeklaude/feed.xml
- 소스: https://github.com/INNO-HI/weeklaude

피드백·제안 환영합니다. 누락된 좋은 도구 있으면 댓글로 알려주세요.
```

## 댓글 응대 가이드

- **"점수 공식이 너무 단순한 거 아닌가요?"** → 답변: "현재는 4축이지만 다음 분기에 사용자 평점 반영 예정. 단순함이 오히려 투명성에 유리하다고 봤습니다."
- **"한국 커뮤니티 +10이 편향 아닌가요?"** → 답변: "영어권 규모가 훨씬 커서 boost 없이는 한국 콘텐츠가 묻힙니다. 정량 보정의 일종."
- **"내 리포가 빠졌어요"** → 답변: "Issue로 알려주시면 다음 주 갱신에 반영"
