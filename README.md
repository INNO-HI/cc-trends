<div align="center">

# 위클렌드 <sub>· Weeklaude</sub>

**Claude Code 생태계, 이번 주 뭐가 뜨고 뭐가 자리잡았나.**

매주 월요일 자동 갱신되는 Claude Code · 에이전트 · 스킬 · 하네스 · MCP 큐레이션 인덱스.

[🌐 **사이트 바로가기**](https://inno-hi.github.io/weeklaude/) ·
[📡 **RSS 구독**](https://inno-hi.github.io/weeklaude/feed.xml) ·
[⭐ **Star**](https://github.com/INNO-HI/weeklaude)

![Built with Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-D97757?style=flat-square)
![Auto Updated](https://img.shields.io/badge/Updated-Weekly%20·%20Mon%2009%3A00%20KST-22c55e?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-0e0e0e?style=flat-square)

</div>

---

## 이게 뭔가요

Claude Code가 터진 이후로 에이전트 · 스킬 · 하네스가 매일 수십 개씩 올라옵니다.
매번 awesome-list 훑고 트위터 뒤지고 HN 보는 거 피곤하죠.

한 페이지에서 **이번 주 뜨는 거 + 이미 검증된 거**를 보고 싶어서 만들었습니다.

- **🔥 Rising** — 최근 30일 급상승 + 커뮤니티 회자되는 것
- **⭐ Classic** — 이미 자리잡은 필수 레퍼런스
- **매주 월요일 09:00 (KST)** — 자동으로 다시 계산, RSS·커밋 푸시까지

## 뭐가 다른가요

| | 일반 awesome-list | **위클렌드** |
|---|---|---|
| 갱신 주기 | PR 받을 때마다 (비정기) | **매주 월요일 자동** |
| 수집 범위 | GitHub 링크만 | GitHub + HN + Reddit + dev.to + GeekNews + velog |
| 정렬 기준 | 시간순 또는 카테고리 | **4축 가중 점수** (velocity · buzz · quality · recency) |
| 한국어 | 보통 영문 | **한글 한 줄 요약 + 캐치프레이즈** 각 카드마다 |
| 편향 | 영어권 중심 | 한국어 커뮤니티 가산점으로 보정 |
| 중복 제거 | 수동 | **fork·미러·owner 변형 자동 컷** |

## 어떻게 만들어지나

5명의 Claude Code 서브에이전트가 매주 자동으로 굴립니다.

```
┌─────────────┐  ┌───────────────┐
│github-scout │  │community-scout│   ← 수집
└──────┬──────┘  └──────┬────────┘
       └────────┬───────┘
                ▼
        ┌──────────────┐
        │trend-analyzer│              ← 분류 + 점수 + dedup
        └──────┬───────┘
               ▼
        ┌───────────────┐
        │content-curator│             ← 한글화 + 5단계 자체 검수
        └──────┬────────┘
               ▼
         ┌────────────┐
         │site-builder│               ← JSON → 정적 사이트
         └────────────┘
```

| 에이전트 | 하는 일 | 사용 스킬 |
|---|---|---|
| `github-scout` | GitHub 트렌딩 · `.claude/agents` 경로 · awesome-list 스캔 | `github-scan` |
| `community-scout` | HN · Reddit · dev.to · GeekNews · velog · X 크롤링 | `community-scan` |
| `trend-analyzer` | Rising/Classic 분류 · 점수 계산 · 중복 제거 | `trend-scoring` |
| `content-curator` | 한글 요약 · 캐치프레이즈 · 자체 검수 | (프롬프트 기반) |
| `site-builder` | `latest.json` 갱신 · 정적 빌드 | `trend-site-build` |

오케스트레이터 스킬 `cc-trends` 하나가 위 5명을 순차 호출합니다.

## 점수 공식

```
score = 0.4 × velocity + 0.3 × buzz + 0.2 × quality + 0.1 × recency
```

- **velocity** — GitHub 7일 stars 증가 속도 (신상 보정 포함)
- **buzz** — 커뮤니티 언급의 로그 가중 합 + 다중 플랫폼 가산점
- **quality** — README 깊이 · 라이선스 · 테스트 · CI · 문서화
- **recency** — 최근 커밋이 얼마나 따끈한지

자세한 산식은 [`/.claude/skills/trend-scoring/skill.md`](.claude/skills/trend-scoring/skill.md) 참고.

## 카테고리별 정원제

각 주차에 강제로 12개 채우지 않고, **자연 공급량**을 따릅니다.

| 카테고리 | rising 상한 | classic 상한 |
|---|---|---|
| `skill` | 8 | 6 |
| `mcp` | 6 | 4 |
| `agent` | 4 | 4 |
| `harness` | 2 | 2 |

임계치 미달이면 정원이 비어도 강제로 채우지 않습니다 (예: 한 주에 harness 0개일 수 있음).

## 실행

### 사이트 로컬 프리뷰
```bash
python3 -m http.server 8000 --directory site
# → http://localhost:8000
```

### 파이프라인 직접 실행
```
# Claude Code 슬래시 커맨드
/cc-trends

# 또는 자연어
"cc-trends 업데이트해줘"
```

### 자동 주간 갱신
macOS launchd로 매주 월요일 09:00 KST 실행 중.
스크립트: [`scripts/weekly.sh`](scripts/weekly.sh)

```bash
launchctl load ~/Library/LaunchAgents/com.flareon.cc-trends.weekly.plist
```

## 폴더 구조

```
weeklaude/
├── .claude/
│   ├── agents/          # 5명의 전문 서브에이전트
│   └── skills/          # 6개 스킬 (수집·분석·큐레이션·빌드·오케스트레이터)
├── site/                # 정적 웹사이트 (HTML/CSS/JS)
│   └── public/data/
│       ├── latest.json  # 이번 주 데이터
│       └── archive/     # 주차별 스냅샷
├── data/archive/        # 원본 백업 (Pages 미노출)
├── scripts/             # weekly.sh, build-archive-index.js, generate-rss.js
└── _workspace/          # 파이프라인 중간 산출물 (gitignored)
```

## 데이터 형식

`site/public/data/latest.json`
```json
{
  "generated_at": "2026-04-27T15:00:00Z",
  "version": "2026-W18",
  "rising":  [ /* 카드 객체 배열 */ ],
  "classic": [ /* 카드 객체 배열 */ ]
}
```

각 카드 객체:
```json
{
  "id": "owner/repo",
  "category": "skill",
  "title_ko": "한글 제목",
  "catchphrase": "한 줄 훅",
  "summary_ko": "3~5줄 요약",
  "key_features": ["...", "...", "..."],
  "use_case": "이럴 때 쓰면 좋아요",
  "install_hint": "npx ... 또는 git clone ...",
  "tags": ["..."],
  "trend_score": 87,
  "sources": ["github", "hn", "reddit"],
  "evidence": [{ "source": "hn", "url": "...", "label": "HN 1위" }],
  "stars": 24115,
  "official_url": "https://github.com/owner/repo",
  "thumbnail_url": "https://github.com/owner.png",
  "badges": ["🔥 Rising", "🆕 신상"]
}
```

과거 주차 스냅샷은 `site/public/data/archive/YYYY-MM-DD.json`에 보존되며, 사이트 우상단 **"지난 주차"** 드롭다운에서 탐색 가능합니다.

## 구독

- **🌐 웹**: https://inno-hi.github.io/weeklaude/ — 매주 월요일 갱신
- **📡 RSS**: https://inno-hi.github.io/weeklaude/feed.xml — Feedly · Inoreader · NetNewsWire 등에서 구독
- **⭐ Star**: 이 repo 별 누르면 업데이트 notification 받음

## 기여

- 좋은 리포가 누락됐다면 [Issue](https://github.com/INNO-HI/weeklaude/issues) 열어주세요
- 점수 공식 개선 아이디어, 새 수집 소스 제안 환영
- 한글 카피가 어색하다 싶으면 지적 대환영

## 만든 곳

[INNO-HI](https://github.com/INNO-HI) · 인노하이

Built with [Claude Code](https://claude.com/claude-code) · 모든 에이전트 · 스킬 프롬프트는 [`.claude/`](.claude/) 아래 공개되어 있습니다. 그대로 가져다 쓰셔도 됩니다.

## 라이선스

MIT
