#!/bin/sh
# bmsk dotfiles installer
# Usage: curl -fsSL https://raw.githubusercontent.com/seokbeomyi/dotfiles/main/install.sh | sh

set -e

DOTFILES_DIR="$HOME/.bmsk"
ZSHRC="$HOME/.zshrc"
REPO="https://github.com/seokbeomyi/dotfiles.git"
SOURCE_LINE="source ~/.bmsk/bmsk.zsh"

echo ""
echo "  bmsk dotfiles installer"
echo "  ──────────────────────────────────"

# 이미 설치된 경우 업데이트
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "  이미 설치되어 있습니다. 업데이트합니다..."
  git -C "$DOTFILES_DIR" pull
  echo "  ✓ 업데이트 완료"
  echo ""
  exit 0
fi

# clone
echo "  dotfiles 다운로드 중..."
git clone "$REPO" "$DOTFILES_DIR"

# ~/.zshrc에 source 라인 추가
if grep -qF "$SOURCE_LINE" "$ZSHRC" 2>/dev/null; then
  echo "  ~/.zshrc 이미 설정되어 있습니다"
else
  echo "" >> "$ZSHRC"
  echo "# bmsk dotfiles" >> "$ZSHRC"
  echo "$SOURCE_LINE" >> "$ZSHRC"
  echo "  ✓ ~/.zshrc 업데이트 완료"
fi

echo ""
echo "  ✓ 설치 완료!"
echo ""
echo "  다음 명령어로 시크릿(API키 등) 설치:"
echo "  source ~/.zshrc && bmsk setup-secrets"
echo ""
