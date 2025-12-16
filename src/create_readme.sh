#!/bin/zsh
# Usage: ./create_readme.sh abc436 [output_dir]
# Example: ./create_readme.sh abc436 2025-12-13

CONTEST_ID=${1:-""}
OUTPUT_DIR=${2:-$(date +%Y-%m-%d)}

if [[ -z "$CONTEST_ID" ]]; then
  echo "Usage: $0 <contest_id> [output_dir]"
  echo "Example: $0 abc436 2025-12-13"
  exit 1
fi

CONTEST_URL="https://atcoder.jp/contests/$CONTEST_ID"
TASKS_URL="$CONTEST_URL/tasks"

# コンテスト名を取得
CONTEST_NAME=$(curl -s "$CONTEST_URL" | grep -oP '<title>\K[^<]+' | sed 's/ - AtCoder$//')

# 問題リンクを取得（/tasksページから）
# 問題IDと問題名を取得してペアにする
PROBLEM_LINKS=$(curl -s "$TASKS_URL" |
  grep -oP "<a href=\"/contests/${CONTEST_ID}/tasks/${CONTEST_ID}_[a-z]\">[^<]+</a>" |
  paste - - |
  sed -E "s#<a href=\"([^\"]+)\">([^<]+)</a>\t<a href=\"[^\"]+\">([^<]+)</a>#- [\2 - \3](https://atcoder.jp\1)#")

# README.md を生成
mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/README.md" << EOF
# $CONTEST_NAME

$CONTEST_URL

## INDEX

$PROBLEM_LINKS
EOF

echo "Created $OUTPUT_DIR/README.md"
