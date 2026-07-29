#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/shradhatripathi-droid/Product-Leader.git"
ROOT="$(cd "$(dirname "$0")" && pwd)"

cd "$ROOT"

if ! command -v git >/dev/null 2>&1; then
  echo "Git is not installed. Install Xcode Command Line Tools:"
  echo "  xcode-select --install"
  exit 1
fi

if [ ! -d .git ]; then
  git init
  git branch -M main
  git remote add origin "$REPO_URL"
fi

git add index.html README.md .nojekyll
git commit -m "Add interactive product leader portfolio site" || true
git push -u origin main

echo ""
echo "Done. Enable GitHub Pages:"
echo "  https://github.com/shradhatripathi-droid/Product-Leader/settings/pages"
echo "  Source: Deploy from branch ? main ? / (root)"
echo ""
echo "Live site:"
echo "  https://shradhatripathi-droid.github.io/Product-Leader/"
