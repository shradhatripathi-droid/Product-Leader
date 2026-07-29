#!/bin/bash
cd "$(dirname "$0")"
PORT=8080

if lsof -ti :$PORT >/dev/null 2>&1; then
  echo "Server already running on port $PORT"
else
  ruby -e "require 'webrick'; WEBrick::HTTPServer.new(Port: $PORT, DocumentRoot: Dir.pwd).start" >/dev/null 2>&1 &
  sleep 1
  echo "Started server on port $PORT"
fi

echo "Portfolio: http://localhost:$PORT/index.html"
open -a "Google Chrome" "http://localhost:$PORT/index.html"
