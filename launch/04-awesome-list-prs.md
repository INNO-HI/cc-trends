# Awesome-list PR 가이드

위클렌드를 awesome-claude-code 계열 큐레이션 리스트에 등록하는 PR.
**예의 + 가치 명확 + 자연스러운 영문** 이 핵심.

## 타겟 리포 우선순위

### 🥇 P0 (가장 큰 임팩트, 영향력)

#### 1. `hesreallyhim/awesome-claude-code`
- URL: https://github.com/hesreallyhim/awesome-claude-code
- stars: 10K+
- 추가 위치: **"Tools and Utilities"** 또는 **"Community Resources"** 섹션
- PR Title: `Add Weeklaude — auto-curated weekly Claude Code trends index`

#### 2. `VoltAgent/awesome-agent-skills`
- URL: https://github.com/VoltAgent/awesome-agent-skills
- stars: 20K+
- 추가 위치: **"Skill Discovery"** 또는 **"Curated Lists"** 섹션
- PR Title: `Add Weeklaude — weekly auto-updated index of Claude skills/agents/MCP`

### 🥈 P1 (중간 임팩트)

#### 3. `ComposioHQ/awesome-claude-skills`
- URL: https://github.com/ComposioHQ/awesome-claude-skills
- stars: 60K+
- 추가 위치: **"Resources"** 섹션
- PR Title: `Add Weeklaude — weekly Claude Code ecosystem index`

#### 4. `ai-boost/awesome-harness-engineering`
- URL: https://github.com/ai-boost/awesome-harness-engineering
- 추가 위치: **"Resources"** 또는 **"Production Cases"**
- PR Title: `Add Weeklaude as a real-world auto-curation harness example`
- 특이점: 위클렌드 자체가 harness engineering 사례라 더 잘 받아들여질 듯

### 🥉 P2 (시도 가치)

#### 5. `VoltAgent/awesome-claude-code-subagents`
- URL: https://github.com/VoltAgent/awesome-claude-code-subagents
- 본 리포의 .claude/agents/ 5개를 예시로도 추가 가능

---

## 추가할 마크다운 (그대로 복붙)

### 영문 버전 (대부분 리포)

```markdown
- **[Weeklaude](https://inno-hi.github.io/weeklaude/)** — Auto-updated weekly index of Claude Code agents, skills, harnesses, and MCP servers. Aggregates signals from GitHub + HN + Reddit + dev.to + GeekNews + velog, scores on 4 axes (velocity·buzz·quality·recency), separates "Rising this week" from "Already classic". Korean + English UI. All curation prompts open at [.claude/](https://github.com/INNO-HI/weeklaude/tree/main/.claude). ([Source](https://github.com/INNO-HI/weeklaude))
```

### 더 짧은 버전 (간결한 리포)

```markdown
- [Weeklaude](https://inno-hi.github.io/weeklaude/) — Auto-curated weekly index of Claude Code trends (agents/skills/harnesses/MCP). Updates every Monday via a 5-subagent pipeline. ([repo](https://github.com/INNO-HI/weeklaude))
```

---

## PR Description 템플릿

```markdown
## What this adds

Adds **Weeklaude** — an auto-curated weekly index of Claude Code agents,
skills, harnesses, and MCP servers.

## Why it fits this list

This list focuses on [discovering/curating] Claude Code resources. Weeklaude
provides a complementary angle: a **time-series snapshot** of what's rising
this week vs. what's already classic, refreshed every Monday automatically.

Unlike static awesome-lists (which become stale between PRs), Weeklaude:
- Re-scores every Monday via a 5-subagent pipeline
- Pulls signals from 6 communities (GitHub + HN + Reddit + dev.to + GeekNews + velog)
- Separates Rising vs Classic with strict thresholds + dedup
- Provides Korean translations for the Korean dev community
- Open-sources the entire curation harness at `.claude/`

The site itself archives every week's snapshot, so it complements (not
replaces) static awesome-lists as a "what changed this week" view.

## Site
- https://inno-hi.github.io/weeklaude/

## Source
- https://github.com/INNO-HI/weeklaude
- All curation prompts open under `.claude/`

I built this myself and maintain it (4+ weeks of auto-updates so far).
Happy to remove if you feel it doesn't fit. Thanks!
```

---

## PR 보내는 순서

1. **하나씩 보내기** — 같은 날 5개 한 번에 보내면 봇으로 의심받음
2. 권장 간격: **3일 1개**
3. P0 두 개 먼저, 반응 보고 P1·P2 진행

## 거절 받을 가능성과 대처

- "Not maintained list" — 다른 리스트로 이동
- "Doesn't fit" — 받아들이고, 정중히 감사 인사
- 무응답 - 2주 뒤 정중한 nudge 코멘트 1회만 (그 이상은 spam)

## 보너스: GitHub Discussions

awesome-list에 Discussion 탭이 열려있으면 거기 먼저 소개하는 게 더 자연스러움.
"Hey, built something that might fit here — what do you think?" 식으로.

---

## 직접 보내실 때 체크리스트

- [ ] hesreallyhim/awesome-claude-code 포크 → PR
- [ ] VoltAgent/awesome-agent-skills 포크 → PR (3일 뒤)
- [ ] ComposioHQ/awesome-claude-skills 포크 → PR (6일 뒤)
- [ ] ai-boost/awesome-harness-engineering 포크 → PR (9일 뒤)
- [ ] VoltAgent/awesome-claude-code-subagents 포크 → PR (12일 뒤)
