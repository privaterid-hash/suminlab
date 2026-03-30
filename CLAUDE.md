# suminlab.app

GitHub Pages 정적 사이트. Jimin Kim이 개발하는 앱들의 랜딩 페이지와 개인정보 처리방침을 호스팅한다.

- **도메인**: suminlab.app
- **호스팅**: GitHub Pages (main 브랜치)
- **기술 스택**: 순수 HTML/CSS (빌드 도구 없음)

## 프로젝트 구조

```
/
├── index.html                  # 수민랩 메인 페이지
├── CNAME                       # 커스텀 도메인 설정
├── apps/
│   ├── _template/              # 새 앱 추가 시 복사하는 템플릿
│   │   ├── index.html          # 앱 랜딩 페이지 템플릿
│   │   └── privacy/index.html  # 개인정보 처리방침 템플릿
│   ├── malteam/                # 말트임 (MaltEam)
│   │   ├── index.html
│   │   └── privacy/index.html
│   └── assetfuse/              # AssetFuse
│       ├── index.html
│       ├── privacy/index.html  # Privacy Policy (EN)
│       └── privacy/ko.html     # 개인정보 처리방침 (KO)
```

## 규칙

### 새 앱 추가

1. `apps/_template/`를 복사하여 `apps/{앱이름}/`으로 생성 (소문자, 하이픈 없음)
2. 앱 정보 소스가 Notion URL로 주어지면 `notion-fetch` MCP 도구로 내용을 읽는다
3. 템플릿의 `{{플레이스홀더}}`를 실제 값으로 교체
4. 개인정보 처리방침이 영문/한글 두 버전이면:
   - `privacy/index.html` → 영문 (기본)
   - `privacy/ko.html` → 한글
5. 개인정보 처리방침이 한글만 있으면 `privacy/index.html`에 한글로 작성

### HTML/CSS 컨벤션

- 외부 라이브러리 사용 금지 — 순수 HTML + 인라인 `<style>` 만 사용
- 폰트: 시스템 폰트 스택 (`-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif`)
- 배경: `#fafafa`, 텍스트: `#333`, 보조 텍스트: `#888`/`#999`
- 최대 너비: 랜딩 페이지 `480px`, 문서 페이지 `640px`
- 푸터: `© Jimin Kim` (연도 없이 쓰거나 `© 2026 Jimin Kim` 형태)
- 연락처 이메일: 항상 `ebbelwoi@kakao.com` 사용 (템플릿 포함)
- 메인 페이지에서 개별 앱 페이지로의 링크 없음 — 의도적 스텔스 모드

### 커밋

- 한글 커밋 메시지 사용
- 앱 추가: `Add {앱이름} 앱 페이지`
- 수정: `Update {앱이름} 개인정보 처리방침`

## 에이전트 협업

**기본 모드: 에이전트 협업 실행.** 사용자가 별도로 지시하지 않아도, 단순 오타 수정이나 한 줄 변경 같은 사소한 작업이 아닌 이상 AGENTS.md에 정의된 협업 패턴에 따라 에이전트를 활용하여 작업한다. 구체적으로:

- 파일 생성이나 내용 변경이 수반되는 작업 → 해당 역할의 에이전트를 병렬/순차 실행
- 작업 완료 후 reviewer 에이전트로 검증 (단, 한 줄 수정 등 사소한 변경은 생략 가능)
- 사용자가 "직접 해줘", "에이전트 없이" 등 명시적으로 요청하면 단독 실행

역할 정의와 협업 패턴은 [AGENTS.md](AGENTS.md) 참조.
