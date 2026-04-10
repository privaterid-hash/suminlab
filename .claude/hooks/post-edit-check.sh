#!/bin/bash
# Post-edit harness checks for suminlab

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

BASENAME=$(basename "$FILE_PATH")
WARNINGS=""

# --- 위험 패턴 ---
DANGEROUS_PATTERNS=(
  "html|ebbelwoi@kakao.com.*mailto:|이메일 링크 확인 — mailto: 프로토콜이 올바른지 확인"
)

# --- 문서 동기화 ---
DOC_SYNC_MAP=(
  "_template|CLAUDE.md HTML/CSS 컨벤션 섹션"
)

for pattern_def in "${DANGEROUS_PATTERNS[@]}"; do
  IFS='|' read -r ext grep_pat message <<< "$pattern_def"
  if [[ "$FILE_PATH" == *."$ext" ]] && [ -f "$FILE_PATH" ]; then
    if grep -qn "$grep_pat" "$FILE_PATH" 2>/dev/null; then
      LINES=$(grep -n "$grep_pat" "$FILE_PATH" | head -3)
      WARNINGS+="⚠️ $message:"$'\n'"$LINES"$'\n'
    fi
  fi
done

for sync_def in "${DOC_SYNC_MAP[@]}"; do
  IFS='|' read -r file_pattern doc_path <<< "$sync_def"
  if echo "$BASENAME" | grep -qE "$file_pattern" || echo "$FILE_PATH" | grep -qE "$file_pattern"; then
    WARNINGS+="⚠️ ${file_pattern} 관련 파일 변경됨 — ${doc_path} 업데이트 필요"$'\n'
  fi
done

if [ -n "$WARNINGS" ]; then
  printf '%s' "$WARNINGS"
fi

exit 0
