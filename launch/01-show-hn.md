# Show HN 런칭 포스트 (영문)

## 게시 방법
1. https://news.ycombinator.com/submit
2. **Title** 칸에 아래 제목 (80자 제한)
3. **URL** 칸에 사이트 주소
4. Submit

## 게시 타이밍
- **요일**: 화요일~목요일 (월/금 금지)
- **시각**: KST 22:00~23:00 (PST 06:00~07:00 = HN 골든타임)
- 주간 갱신 직후(월 09시) 데이터로 화요일 밤 게시 → "신상" 효과

---

## Title (1개 선택)

A) `Show HN: Weeklaude – Auto-curated weekly Claude Code trends`
B) `Show HN: A weekly index of Claude Code agents, skills, and MCP servers`
C) `Show HN: We let 5 Claude sub-agents curate Claude Code trends weekly`

→ **추천: A** (clearest USP)

## URL
```
https://inno-hi.github.io/weeklaude/
```

## 첫 댓글 (텍스트, 본인이 글 올린 직후 바로 첫 댓글로 다는 게 매너)

```
Hi HN, maker here.

I built Weeklaude because Claude Code tools are exploding (10-30 new repos/week
across agents, skills, harnesses, MCP servers), but nothing was tracking them
in one place. Awesome-lists are updated whenever someone PRs them, GitHub
trending isn't Claude-specific, and Twitter dies in an hour.

So I built a static site that:
- Auto-updates every Monday 9am KST
- Pulls signals from GitHub + HN + Reddit + dev.to + GeekNews (Korean) + velog (Korean)
- Scores each repo on 4 axes: velocity, community buzz, code quality, recency
- Separates "Rising this week" from "Already classic"
- Korean + English UI

The pipeline itself is 5 Claude Code sub-agents (github-scout, community-scout,
trend-analyzer, content-curator, site-builder) orchestrated by a top-level skill.
All prompts are open at .claude/ in the repo — feel free to fork the harness
for your own niche (Hugging Face papers, Rust crates, whatever).

Quality gates I've layered in:
- gh api existence check (404 → cut)
- stars field synced from gh api (kills hallucination)
- single-source items demoted (forces multi-source verification)
- fork/archived auto-cut

Honest weakness: community-scout sometimes can't reach X without auth, so X
signals are partial. Working on it.

Source: https://github.com/INNO-HI/weeklaude
RSS: https://inno-hi.github.io/weeklaude/feed.xml

Would love feedback — especially on the scoring formula and what categories
I'm missing.
```

## 댓글 응대 가이드

- **"Why not just use GitHub trending?"** → 답변: "GH trending isn't Claude-specific. Weeklaude pre-filters to .claude/agents path + topic + community signals."
- **"Have you considered RSS?"** → 답변: "Already there: /feed.xml"
- **"What about [X tool]?"** → 답변: 검토 약속 + 다음 주 갱신 시 포함되는지 확인하겠다고

## 게시 후 즉시 할 일
1. r/ClaudeAI에 동시 크로스포스트 (HN 링크 인용)
2. Twitter/X 공유 (스크린샷 + HN 링크)
3. 본인이 즐겨찾는 디스코드/슬랙 채널에도 공유
