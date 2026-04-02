#!/bin/bash
# update-cv.sh — Sync CV from Overleaf (via Dropbox) and trigger a rebuild
#
# Usage:  ./update-cv.sh
#
# What it does:
#   1. Copies the latest .tex source from your Dropbox/Overleaf sync folder
#   2. Commits and pushes to GitHub
#   3. GitHub Actions compiles the .tex → PDF automatically (~2 min)
#   4. The compiled PDF goes live at pourmohammadimohammad.github.io/cv.html

set -e

OVERLEAF_DIR="$HOME/Library/CloudStorage/Dropbox/Apps/Overleaf/My Academic CV"
SITE_DIR="$(cd "$(dirname "$0")" && pwd)"
LATEX_DIR="$SITE_DIR/assets/latex"

echo "Syncing from Overleaf (Dropbox)..."

# Copy source files
cp "$OVERLEAF_DIR/My_CV.tex"    "$LATEX_DIR/My_CV.tex"
cp "$OVERLEAF_DIR/resume.cls"   "$LATEX_DIR/resume.cls"

# Copy photo if it exists
[ -f "$OVERLEAF_DIR/IMG_5434.jpg" ] && cp "$OVERLEAF_DIR/IMG_5434.jpg" "$LATEX_DIR/IMG_5434.jpg"

echo "Pushing to GitHub..."
cd "$SITE_DIR"
git add assets/latex/
git diff --staged --quiet && echo "No changes detected." && exit 0

git commit -m "Update CV source ($(date '+%Y-%m-%d'))"
git push

echo ""
echo "Done! GitHub Actions will compile the PDF in ~2 minutes."
echo "Live at: https://pourmohammadimohammad.github.io/cv.html"
