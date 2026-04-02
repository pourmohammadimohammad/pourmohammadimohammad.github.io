#!/bin/bash
# update-cv.sh — Update the CV on your GitHub Pages site
#
# Usage:
#   ./update-cv.sh /path/to/your/cv.pdf
#
# Example (after downloading from Overleaf):
#   ./update-cv.sh ~/Downloads/main.pdf

set -e

if [ -z "$1" ]; then
  echo "Usage: ./update-cv.sh /path/to/cv.pdf"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: file not found: $1"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$1" "$SCRIPT_DIR/assets/cv.pdf"
echo "Copied CV to assets/cv.pdf"

cd "$SCRIPT_DIR"
git add assets/cv.pdf
git commit -m "Update CV ($(date '+%Y-%m-%d'))"
git push

echo ""
echo "Done! Your CV is live at https://pourmohammadimohammad.github.io/cv.html"
