---
name: cc-trends
description: "Claude Code 에이전트/하네스/스킬 트렌드 모니터링 사이트 자동 업데이트 파이프라인. GitHub + 개발 커뮤니티에서 '최신 화제'와 '이미 유명한 것'을 수집→분석→큐레이션→정적 사이트로 배포. 5명 에이전트 팀 오케스트레이션. 트리거: cc-trends, 트렌드 업데이트, 클로드 코드 홈페이지 갱신, 주간 업데이트."
---

# CC Trends — Claude Code 트렌드 모니터링 오케스트레이터

Claude Code 에이전트·하네스·스킬 트렌드 홈페이지를 자동 갱신한다. **에이전트 팀 모드**로 실행.

## 팀 구성
| 에이전트 | 역할 |
|---------|------|
| `github-scout` | GitHub 리포 수집 |
| `community-scout` | Reddit/HN/X/dev.to/GeekNews 수집 |
| `trend-analyzer` | Rising vs Classic 분류 + 카테고리 태깅 + 점수 |
| `content-curator` | 한글 요약·캐치프레이즈·배지·썸네일 |
| `site-builder` | 정적 사이트 빌드·배포·롤백 |

## 실행 흐름

### Phase 1: 수집 (병렬)
`TeamCreate`로 팀 구성 후 `TaskCreate`로 github-scout, community-scout에 동시 할당.
- github-scout → `_workspace/01_github_raw.json`
- community-scout → `_workspace/02_community_raw.json`

둘은 `SendMessage`로 상호 교차 힌트 교환 (예: community가 발견한 repo URL을 github에 전달).

### Phase 2: 분석
수집 완료 후 trend-analyzer 작업 시작.
- 입력: `01_*.json` + `02_*.json`
- 스킬: `trend-scoring`
- 출력: `_workspace/03_analysis.json` (Rising 12 + Classic 12)

### Phase 3: 큐레이션
content-curator가 각 아이템에 WebFetch로 README 확인 후 한글 콘텐츠 작성.
- 출력: `_workspace/04_curated.json`

### Phase 4: 빌드·배포
site-builder가 latest.json 교체, 빌드 검증, 변경 요약 보고.

### Phase 5: 종합 보고
오케스트레이터(리더)가 최종 요약:
- 수집/분석/큐레이션 건수
- 추가/제거/순위 변동 Top 5
- 실패·보류 항목

## 데이터 전달 프로토콜
- **파일 기반**: `_workspace/NN_*.json` 순차 체인
- **메시지 기반**: 팀원 간 실시간 힌트/요청 (SendMessage)
- **태스크 기반**: TaskCreate로 의존성 명시 (`depends_on: [prev_task_id]`)

## 에러 핸들링
| 상황 | 처리 |
|-----|-----|
| github-scout 실패 | community-scout 결과만으로 진행, 보고서에 "GitHub 데이터 누락" 명시 |
| WebFetch 차단 | 해당 아이템 `needs_review: true`로 표기, 사이트에는 최소 정보만 노출 |
| site 빌드 실패 | archive에서 직전 latest.json 복원, 오케스트레이터에 재시도 제안 |
| 데이터 0건 | 파이프라인 중단, 사용자 개입 요청 |

## 팀 크기 및 조율
- 5명 팀 — 중규모 (10~20 작업)
- 조율 오버헤드 관리: 리더는 Phase 경계에서만 개입, Phase 내에서는 팀원 자체 조율

## 테스트 시나리오

### 정상 흐름
1. 사용자: "cc-trends 업데이트해줘"
2. 팀 생성 → Phase 1~4 실행 → 5~10분 내 사이트 갱신
3. 리더가 "Rising 12건(신규 3), Classic 12건 업데이트 완료" 보고

### 에러 흐름
1. community-scout가 Reddit 차단으로 0건 수집
2. github-scout 결과만으로 trend-analyzer 진행
3. 최종 보고서에 "⚠️ 커뮤니티 데이터 누락" 경고 포함

## 실행 빈도 권장
- 주간 1회 (매주 월요일)
- `schedule` 스킬로 cron 등록 가능

## 산출물
- `site/public/data/latest.json` — 사이트 라이브 데이터
- `data/archive/YYYY-MM-DD.json` — 주간 스냅샷
- `_workspace/` — 중간 산출물 (감사 추적용 보존)

## 사이트 초기 설정
최초 실행 시 `site/` 디렉토리에 `index.html`, `styles.css`, `app.js`가 없으면 site-builder가 기본 스캐폴딩을 생성한다.
