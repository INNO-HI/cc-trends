# Velog 런칭 포스트 (한글)

## 게시 방법
1. https://velog.io/write
2. 제목 + 본문 입력
3. 우상단 "출간하기" → 시리즈 추가 + 태그 입력 + 발행

## 게시 타이밍
- HN/GeekNews 게시 다음 날(수~목)
- 한국 개발자 RSS 구독자 + Google 검색 유입 노림

---

## 제목

**"Claude Code 도구 너무 많아서, 자동 큐레이션 사이트 만들었습니다 — 위클렌드(Weeklaude)"**

## 짧은 소개 (description, 155자 이내)

> 매주 월요일 자동 갱신되는 Claude Code 에이전트·스킬·MCP 주간 인덱스. 5명의 서브에이전트가 GitHub와 개발자 커뮤니티를 훑어 자동 큐레이션합니다.

## 태그
`claude-code` `ai` `에이전트` `자동화` `개발도구`

## 시리즈
"Claude Code 실전" (새 시리즈로)

---

## 본문 (그대로 복붙)

```markdown
> 인스타에 매일 쏟아지는 Claude Code 에이전트·스킬·MCP, 이제 주 1회 한 페이지에서 봅니다.
> 에이전트 5명이 GitHub와 개발자 커뮤니티를 훑어 자동 큐레이션하는 사이트 "위클렌드(Weeklaude)" 를 만든 이야기.

![위클렌드 메인](https://inno-hi.github.io/weeklaude/og.png)

---

## "어제 본 그 에이전트 뭐였지?" 에 답하는 사이트

Claude Code 도구는 매일 수십 개씩 쏟아진다.
인스타·트위터에서 "이거 대박" 보고 일주일 지나면 어디 갔는지 모른다.

- 인스타 릴스는 스크롤하면 끝
- X 타임라인은 한 시간이면 묻힘
- GitHub 트렌딩은 Claude Code 전용 아님
- Reddit, HN, GeekNews는 채널마다 말투가 다름

"지금 이번 주에 뭐가 떴고, 뭐가 이미 자리잡았는지" 를 3분 안에 훑을 수 있는 곳이 없었다.
그래서 만들었다.

👉 **[위클렌드 — Claude Code 주간 인덱스](https://inno-hi.github.io/weeklaude/)**

---

## 만들 때 신경 쓴 4가지

### ① "일간 아닌 주간" — 신호 대 잡음비의 최적점

- **일간**: star 30개짜리도 올라옴. 노이즈 지옥.
- **월간**: 3주 전 뜬 건 이미 지나감.
- **주간**: star velocity 측정에 딱 맞는 윈도우.

매주 월요일 09시 KST, 딱 한 번만 갱신한다.

### ② Rising과 Classic을 섞지 않았다

섞어놓으면 **star 10만짜리 레거시가 이번 주 핫한 것처럼** 보인다.
그래서 점수 공식에 **최근 7일 증가율**을 따로 넣고, 한 커뮤니티에만 도배되는 건 **감점**시켰다.

> 편향된 화제는 화제가 아니라 마케팅이다.

### ③ 3초 판단 가능한 포맷으로 통일

정보가 많은 게 문제가 아니라 형식이 제각각인 게 문제다.

모든 도구를 같은 포맷에 강제로 넣었다:
- 한글 요약 3줄
- 핵심 기능 3줄
- 설치 힌트 한 줄
- "이럴 때 쓴다" 한 줄

포맷이 통일되면 "내 상황이랑 안 맞네" 를 **10초 안에** 버릴 수 있다.

### ④ 큐레이션을 사람이 하지 않는다

매주 직접 큐레이션하면 3주차에 그만둘 게 뻔했다.
그래서 Claude Code 서브에이전트 5명에게 전부 맡겼다.

| 에이전트 | 하는 일 |
|---|---|
| `github-scout` | GitHub 트렌딩·.claude/agents 경로·awesome-list 스캔 |
| `community-scout` | HN·Reddit·dev.to·GeekNews·velog 크롤링 + **후보 리포 역방향 검색** |
| `trend-analyzer` | Rising/Classic 분류·점수·dedup·단일출처 강등 |
| `content-curator` | 한글 요약·`gh api` 강제 검증·5단계 자체 검수 |
| `site-builder` | `latest.json` 갱신·publish gate·정적 빌드 |

Claude Code에서 `/cc-trends` 한 번 치면 자동으로 끝난다.

---

## 품질 관리에 진심

처음 만들 때 가장 신경 쓴 게 "환각 차단" 이었다. LLM이 stars 숫자 같은 거 그럴듯하게 지어내면 사이트 신뢰도가 0이 된다.

그래서 **4겹 게이트**를 직렬로 박았다:

1. **존재 검증** — `gh api` 호출해서 404면 즉시 컷
2. **stars 강제 동기화** — analyzer 추정치 무시, `gh api`의 `stargazers_count` 값으로 덮어쓰기
3. **단일출처 강등** — sources 1개 + score<70인 항목은 발행 안 함
4. **Publish Gate** — `needs_review` 플래그 달린 항목 강제 필터링

특히 두 번째 — **stars 강제 동기화**가 핵심이다. 사람이 봐도 "이 숫자 진짜야?" 의심 안 들게 만드는 게 큐레이션 사이트의 신뢰도다.

---

## 첫 주차에 발견한 도구 3개

이번 W24 데이터에서 개인적으로 건진 것들:

1. **[Last30Days](https://inno-hi.github.io/weeklaude/)** — Reddit·HN·X·YouTube를 30일치로 훑는 멀티 리서치 스킬
2. **[Agent Skills](https://inno-hi.github.io/weeklaude/)** — spec→ship까지 시니어 엔지니어 품질 게이트 24종
3. **[Matt Pocock Skills](https://inno-hi.github.io/weeklaude/)** — `/grill-me`, `/tdd` 등 실전 TDD 강제

리포트 형식 통일이 되어 있어서 **10초 안에 거를지 말지 판단** 가능. 이게 인스타에서 안 되던 거다.

---

## 기술 스택

- **사이트**: Vanilla HTML + CSS + JS, GitHub Pages
- **데이터**: `site/public/data/latest.json` 단 하나
- **아카이브**: 주차별 스냅샷 (사이트 우상단 "지난 주차" 드롭다운에서 탐색)
- **RSS**: `/feed.xml` 제공
- **자동화**: macOS launchd로 매주 월요일 09:00 KST 실행
- **분석**: GA4 + counter.dev

SPA 프레임워크 의도적으로 안 썼다. 정적 HTML + JSON 하나가 가장 안 부서진다.

---

## 써보기

👉 **사이트**: https://inno-hi.github.io/weeklaude/
👉 **RSS 구독**: https://inno-hi.github.io/weeklaude/feed.xml
👉 **소스**: https://github.com/INNO-HI/weeklaude

매주 월요일 오전 갱신. 북마크 추천.

---

## 닫는 말

정보가 부족한 시대가 아니다. **아카이브가 안 되는** 시대다.
"지난주에 그거 뭐였지" 를 더는 안 하고 싶어서 만들었다.

에이전트 프롬프트는 전부 [`.claude/`](https://github.com/INNO-HI/weeklaude/tree/main/.claude) 아래 오픈. 비슷한 큐레이션 사이트(HuggingFace 논문, Rust 크레이트 등) 만들고 싶은 분은 그대로 포크해서 쓰셔도 됩니다.

다음 편에서는 **"서브에이전트 5명 팀 설계할 때 빠지기 쉬운 함정 3가지"** 를 풀어볼 예정.

👉 질문/피드백 있으면 댓글로. 한글 카피 어색하면 지적 대환영.
```
