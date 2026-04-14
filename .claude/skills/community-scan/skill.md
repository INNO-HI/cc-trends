---
name: community-scan
description: "개발자 커뮤니티에서 Claude Code 관련 화제 게시글을 수집. Reddit, HackerNews, X, dev.to, GeekNews, velog, OKKY 등 영문+국문 동시 커버. community-scout 에이전트 전용."
---

# Community Scan — 커뮤니티 크롤링 가이드

## 소스별 접근법

### Reddit
- `r/ClaudeAI/search?q=agent+OR+skill+OR+harness&restrict_sr=on&sort=top&t=month`
- `r/ClaudeCode/top/?t=week`
- `r/LocalLLaMA` — "claude code" 검색
- JSON 접미사: URL 끝에 `.json` 붙이면 구조화 데이터 획득 가능

### HackerNews
- `https://hn.algolia.com/?q=claude+code&dateRange=pastMonth&sort=byPopularity`
- `https://hn.algolia.com/?q=anthropic+skill`
- 댓글 수와 점수 모두 기록

### X (Twitter)
- WebFetch는 X에 제한적. 대안:
  - nitter 인스턴스 (가용한 경우)
  - 검색 엔진에서 `site:x.com claude code skill` 쿼리
- @AnthropicAI, @alexalbert__, 주요 개발자 인용문 찾기

### dev.to
- `https://dev.to/t/claudecode`
- `https://dev.to/search?q=claude+code`

### GeekNews (한국)
- `https://news.hada.io/search?q=claude`
- `https://news.hada.io/search?q=앤트로픽`
- 댓글·추천 수 기록

### velog / tistory
- Google 검색: `site:velog.io "claude code"`, `site:tistory.com "클로드 코드"`
- 최근 2주 내 글 우선

### OKKY, 클리앙, 디스콰이엇
- Google 검색으로 우회. 직접 API 없음.

## 수집 규칙
- **14일 내** 글 우선, 30일 초과는 engagement 매우 높을 때만
- `mentioned_repos` 추출 필수 (github.com URL 정규식)
- 원문 언어 보존 (번역은 curator 담당)

## 출력
`_workspace/02_community_raw.json` — 배열, 소스별 최소 5건 목표
