# Agents

이 프로젝트에서 사용하는 에이전트 역할 정의.
각 에이전트는 독립적으로 작업하거나 협업할 수 있다.

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

**판단 기준**:
- Notion 원본의 내용을 빠짐없이 반영했는가
- 기존 앱 페이지와 스타일이 일관되는가
- 링크가 올바르게 연결되는가

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

**확장 가능 작업**:
- 앱별 브랜드 컬러 적용
- App Store / Google Play 배지 링크 추가
- OG 메타 태그 및 파비콘 설정
- 앱 스크린샷 갤러리

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

## 협업 패턴

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
