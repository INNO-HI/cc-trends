---
name: github-scan
description: "GitHub에서 Claude Code 에이전트/하네스/스킬/MCP 리포지터리를 체계적으로 스캔. 검색 쿼리 팩, 코드 검색(.claude/agents path), topic 필터, velocity 계산, awesome-list 파싱. github-scout 에이전트 전용."
---

# GitHub Scan — Claude Code 리포 스캔

## 검색 쿼리 팩

### 1) 리포지터리 검색 (GitHub search API / WebFetch)
```
https://github.com/search?q=claude-code&type=repositories&s=updated
https://github.com/search?q=claude-agent&type=repositories
https://github.com/search?q=claude-skills&type=repositories
https://github.com/search?q=awesome-claude-code&type=repositories
https://github.com/search?q=anthropic+skill&type=repositories
```

### 2) Topic 기반
```
https://github.com/topics/claude-code
https://github.com/topics/claude
https://github.com/topics/anthropic
https://github.com/topics/mcp-server
```

### 3) 코드 경로 검색 (실제 .claude 폴더 보유 리포)
```
https://github.com/search?q=path%3A.claude%2Fagents&type=code
https://github.com/search?q=path%3A.claude%2Fskills&type=code
https://github.com/search?q=%22subagent_type%22&type=code
```

### 4) Awesome 리스트 파싱
우선 크롤링 대상:
- `hesreallyhim/awesome-claude-code`
- `davila7/claude-code-templates`
- `zebbern/claude-code-guide`
- `wshobson/agents`

이들 README의 링크를 추출해 seed 리스트로 활용.

## 수집 필드 스키마
`agents/github-scout.md`의 수집 필드 참조.

## Velocity 계산
```
velocity_7d = (stars_now - stars_7_days_ago) / 7
velocity_score = min(100, velocity_7d * 5)
```

GitHub API로 직접 히스토리를 얻기 어려우면:
- star-history.com 페이지를 WebFetch
- 혹은 created_at과 현재 stars로 일평균 approx 계산

## 카테고리 힌트 규칙 (README 기반)
| 키워드 | category_hint |
|-------|--------------|
| "subagent", "agent definition", ".claude/agents/" | agent |
| "skill", ".claude/skills/", "SKILL.md" | skill |
| "harness", "orchestrator", "agent team" | harness |
| "mcp server", "Model Context Protocol" | mcp |
| "awesome-list", "curated list" | awesome-list |

둘 이상 해당되면 가장 많이 언급된 키워드 1개로 결정.

## 노이즈 필터
제외 조건 (단, 최근 7일 내 생성 리포는 예외):
- stars < 3 AND 최근 커밋 3개월 이전
- 개인 dotfiles, fork (원본이 더 active할 때)
- README 없음 또는 10줄 미만

## 출력
`_workspace/01_github_raw.json` — JSON 배열, 최소 30개 목표
