#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

PORT=8090
PDF="Shradha-Tripathi-Senior-Director-Program-Management.pdf"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
URL="http://127.0.0.1:${PORT}/index.html"

if [[ ! -x "$CHROME" ]]; then
  echo "Google Chrome not found at: $CHROME" >&2
  exit 1
fi

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

if lsof -ti :"$PORT" >/dev/null 2>&1; then
  echo "Using existing server on port $PORT"
else
  ruby -e "require 'webrick'; WEBrick::HTTPServer.new(Port: $PORT, DocumentRoot: Dir.pwd).start" >/dev/null 2>&1 &
  SERVER_PID=$!
  sleep 1
  echo "Started temporary server on port $PORT"
fi

rm -f "$PDF"

"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --run-all-compositor-stages-before-draw \
  --virtual-time-budget=30000 \
  --print-to-pdf="$PWD/$PDF" \
  "$URL"

if [[ ! -f "$PDF" ]]; then
  echo "PDF generation failed." >&2
  exit 1
fi

BYTES=$(wc -c < "$PDF" | tr -d ' ')
if [[ "$BYTES" -lt 50000 ]]; then
  echo "Warning: PDF looks unusually small (${BYTES} bytes). Charts may not have rendered." >&2
fi

echo "Created: $PWD/$PDF"
open "$PDF" 2>/dev/null || true
