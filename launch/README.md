# 위클렌드 런칭 키트

사람들 유입을 위한 모든 자료. 순서대로 진행하면 1주일 안에 첫 트래픽 폭.

## 📦 포함된 자료

| 파일 | 용도 | 본인 액션 |
|---|---|---|
| `01-show-hn.md` | Show HN 영문 포스트 | 화~목 22시 KST에 ycombinator.com/submit |
| `02-geeknews.md` | GeekNews 한글 포스트 | 화~수 아침 09시에 news.hada.io/submit |
| `03-velog-launch.md` | Velog 런칭 시리즈 1편 | 위 두 게시 다음 날 velog.io/write |
| `04-awesome-list-prs.md` | awesome-list 5개 PR 가이드 | 3일 간격으로 1개씩 PR |

## 🤖 자동화된 것

이미 매주 월요일 09:00 KST에 자동 실행:

| 자동화 | 동작 | 효과 |
|---|---|---|
| **OG 이미지 생성** | `scripts/generate-og.js` — Top 3 카드로 1200×630 PNG | X·카톡 공유 시 미리보기 |
| **GitHub Release 발행** | `scripts/auto-release.sh` — 주차별 태그 + 릴리스 노트 | 깃허브 리포 방문자에 가시화 |
| **RSS 갱신** | `scripts/generate-rss.js` | 리더 구독자 자동 알림 |

## 📅 1주차 런칭 캘린더 (예시)

```
월 (W24 갱신 직후) - 데이터 확인, 사이트 정상 동작 점검
화 22시 - Show HN 게시 (영문)
수 09시 - GeekNews 게시 (한글)
수 22시 - Velog 게시 + r/ClaudeAI 크로스포스트
목 - 첫 awesome-list PR (P0 #1)
토 - 두 번째 awesome-list PR (P0 #2)
```

## 🎯 첫 1주 목표

- **일일 방문자 100+ 유지** (현재 0~10)
- **GitHub Stars 50+** (현재 0~몇 개)
- **RSS 구독자 20+** (관측 어려움)
- **HN 댓글 5+** (대화 시작)

## 📈 효과 측정

- GA4 실시간 보고서로 유입 채널 추적
- counter.dev 대시보드로 일일/주간 트렌드 확인
- GitHub Insights → Traffic으로 referrer 확인

## 💡 첫 발의 트래픽 폭 후

다음 단계 후보:
- 주간 트위터 봇 (Top 3 자동 게시)
- 뉴스레터 (Buttondown 무료 티어)
- 커스텀 도메인 (weeklaude.io / weeklaude.dev)
- Discord 커뮤니티
- 영어 블로그 채널 (dev.to)

먼저 위 4개 채널 효과 측정한 후 결정.

---

**핵심 원칙**: 채널마다 톤을 다르게. 같은 글 복붙 금지.
- HN/Reddit: 솔직 + 기술 디테일 + 한계 인정
- GeekNews: 정보 밀도 + 한국어 자연스러움
- Velog: 스토리텔링 + 만든 이의 시점
- awesome-list PR: 정중 + 가치 명확 + 짧게
