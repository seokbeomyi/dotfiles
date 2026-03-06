# ──────────────────────────────────────────
# bmsk dotfiles
# https://github.com/seokbeomyi/dotfiles
# ──────────────────────────────────────────

# PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/depot_tools:$PATH"
[[ -d "$HOME/.antigravity" ]] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Java / Android
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# SSL (certifi가 설치된 경우에만)
_ssl=$(python3 -c 'import certifi; print(certifi.where())' 2>/dev/null)
[[ -n "$_ssl" ]] && export SSL_CERT_FILE="$_ssl"
unset _ssl

# Secrets (로컬 전용)
[[ -f ~/.bmsk-secrets/secrets.zsh ]] && source ~/.bmsk-secrets/secrets.zsh

# ──────────────────────────────────────────
# bmsk 커스텀 명령어
# ──────────────────────────────────────────

bmsk() {
  case "$1" in
    update)
      echo "dotfiles 업데이트 중..."
      git -C ~/.bmsk pull && echo "✓ dotfiles 최신화 완료"
      ;;
    update-secrets)
      if [[ -d ~/.bmsk-secrets/.git ]]; then
        echo "secrets 업데이트 중..."
        git -C ~/.bmsk-secrets pull && echo "✓ secrets 최신화 완료"
      else
        echo "✗ secrets 미설치. 'bmsk setup-secrets' 먼저 실행하세요"
      fi
      ;;
    setup-secrets)
      if [[ -d ~/.bmsk-secrets/.git ]]; then
        echo "이미 설치되어 있습니다. 업데이트하려면 'bmsk update-secrets'"
      else
        git clone git@github.com:seokbeomyi/dotfiles-secrets.git ~/.bmsk-secrets \
          && echo "✓ secrets 설치 완료. 새 터미널을 열어주세요" \
          || echo "✗ 실패 - SSH 키가 GitHub에 등록되어 있는지 확인하세요"
      fi
      ;;
    *)
      echo ""
      echo "  bmsk 커스텀 명령어 목록"
      echo "  ─────────────────────────────────────────────"
      echo "  ghswitch work          GitHub 회사 계정으로 전환"
      echo "  ghswitch personal      GitHub 개인 계정으로 전환"
      echo "  ghswitch               현재 GitHub 계정 확인"
      echo "  ─────────────────────────────────────────────"
      echo "  bmsk update            dotfiles 최신화"
      echo "  bmsk update-secrets    secrets 최신화"
      echo "  bmsk setup-secrets     secrets 레포 최초 설치"
      echo "  ─────────────────────────────────────────────"
      echo ""
      ;;
  esac
}

# GitHub 계정 전환
ghswitch() {
  case "$1" in
    work)
      git config --global user.name "yibeomseok"
      git config --global user.email "${GH_WORK_EMAIL}"
      sed -i '' 's|IdentityFile ~/.ssh/id_ed25519_github|IdentityFile ~/.ssh/id_ed25519|' ~/.ssh/config
      echo "✓ GitHub: work (${GH_WORK_EMAIL})"
      ;;
    personal)
      git config --global user.name "yibeomseok"
      git config --global user.email "${GH_PERSONAL_EMAIL}"
      sed -i '' 's|IdentityFile ~/.ssh/id_ed25519$|IdentityFile ~/.ssh/id_ed25519_github|' ~/.ssh/config
      echo "✓ GitHub: personal (${GH_PERSONAL_EMAIL})"
      ;;
    *)
      echo "Current: $(git config --global user.email)"
      echo "Usage: ghswitch [work|personal]"
      ;;
  esac
}
