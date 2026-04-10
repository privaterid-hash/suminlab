# Agents

이 프로젝트에서 사용하는 에이전트 역할 정의.
각 에이전트는 독립적으로 작업하거나 협업할 수 있다.

## 운영 모드

- 에이전트 협업이 **기본 실행 모드**다
- 파일 생성/수정이 수반되는 작업은 관련 에이전트를 조합하여 실행
- 모든 변경은 reviewer가 마무리
- 단순 오타 수정이나 한 줄 변경은 단독 실행 허용

---

## content-writer

**역할**: 앱 페이지와 개인정보 처리방침 작성

**담당 영역**:
- `apps/*/index.html` — 앱 랜딩 페이지
- `apps/*/privacy/` — 개인정보 처리방침 (EN/KO)

**도구**:
- `notion-fetch` — Notion 페이지에서 원본 콘텐츠 수집
- `Read`, `Write`, `Edit` — 파일 생성/수정

**작업 절차**:
1. Notion URL → `notion-fetch`로 페이지 구조 파악
2. 하위 페이지 각각 읽기
3. `apps/_template/` 기반으로 HTML 생성
4. CLAUDE.md의 HTML/CSS 컨벤션 준수

**책임**:
- Notion 페이지에서 원본 콘텐츠 수집 (notion-fetch MCP)
- apps/_template/ 기반으로 HTML 페이지 생성
- 영문/한글 이중 버전 관리 (privacy/index.html, privacy/ko.html)
- CLAUDE.md HTML/CSS 컨벤션 준수

**판단 기준**:
- Notion 원본의 내용을 빠짐없이 반영했는가
- 기존 앱 페이지와 스타일이 일관되는가
- 링크가 올바르게 연결되는가

**과거 교훈**:
- 프로젝트 초기 — 앱 추가 시 발견된 교훈을 여기에 추가할 것

---

## designer

**역할**: 페이지 디자인 개선 및 비주얼 작업

**담당 영역**:
- `index.html` — 수민랩 메인 페이지
- `apps/*/index.html` — 앱 랜딩 페이지
- `apps/_template/` — 템플릿 디자인 개선

**원칙**:
- 외부 라이브러리 없이 순수 CSS로 구현
- 현재 디자인 톤 유지: 미니멀, 화이트 배경, 시스템 폰트
- 모바일 우선 반응형
- 앱 아이콘, 스크린샷, 배지 등 비주얼 요소 추가 가능
- 다크 모드 지원 시 `prefers-color-scheme` 미디어 쿼리 사용

**책임**:
- 페이지 CSS 스타일링 및 비주얼 개선
- 모바일 우선 반응형 레이아웃 검증
- 다크 모드 지원 (prefers-color-scheme)
- 앱 간 디자인 톤 일관성 유지

**확장 가능 작업**:
- 앱별 브랜드 컬러 적용
- App Store / Google Play 배지 링크 추가
- OG 메타 태그 및 파비콘 설정
- 앱 스크린샷 갤러리

**과거 교훈**:
- 프로젝트 초기 — 디자인 작업 시 발견된 교훈을 여기에 추가할 것

---

## reviewer

**역할**: 생성된 페이지 검증

**검증 항목**:
- HTML 유효성 (닫히지 않은 태그, 깨진 엔티티)
- 링크 정합성 (상대 경로가 실제 파일을 가리키는지)
- 한글/영문 내용 일치 여부 (양쪽 버전이 있는 경우)
- CLAUDE.md 컨벤션 준수 여부
- 민감 정보 누출 없음 (API 키, 개인 연락처 등)

---

## 요청 → 에이전트 매핑

| 요청 유형 | 1차 담당 | 협업 대상 |
|----------|---------|----------|
| 새 앱 페이지 추가 | content-writer | reviewer |
| 디자인 포함 앱 추가 | content-writer | designer, reviewer |
| 디자인 리뉴얼 | designer | reviewer |
| 개인정보 처리방침 수정 | content-writer | reviewer |
| 템플릿 개선 | designer | content-writer, reviewer |

## 워크플로우 (협업 패턴)

### 새 앱 추가 (기본)

```
사용자 → content-writer → reviewer
```

content-writer가 Notion에서 읽어 페이지를 생성하고, reviewer가 검증.

### 새 앱 추가 (디자인 포함)

```
사용자 → content-writer → designer → reviewer
```

콘텐츠 생성 후 designer가 랜딩 페이지 비주얼을 개선.

### 디자인 리뉴얼

```
사용자 → designer → reviewer
```

기존 페이지의 디자인만 변경할 때.

## 변경 후 체크리스트

- [ ] HTML 유효성 (닫히지 않은 태그, 깨진 엔티티)
- [ ] 링크 정합성 (상대 경로가 실제 파일 가리키는지)
- [ ] CLAUDE.md 컨벤션 준수 (폰트, 색상, 최대 너비 등)
- [ ] 민감 정보 누출 없음
- [ ] 양쪽 언어 버전 있으면 내용 일치 확인
