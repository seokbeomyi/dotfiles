# bmsk dotfiles

개인 맥 환경 설정 및 커스텀 명령어 모음

---

## 설치

새 맥북에서 터미널에 아래 명령어 한 줄만 입력하면 됩니다.

```bash
curl -fsSL https://raw.githubusercontent.com/seokbeomyi/dotfiles/main/install.sh | sh
```

설치 후 새 터미널을 열면 바로 사용 가능합니다.

---

## 시크릿 설정 (API 키, 비밀번호 등)

민감한 환경 변수는 별도 private 레포로 관리됩니다.
SSH 키를 GitHub에 등록한 뒤 아래 명령어를 실행하세요.

```bash
bmsk setup-secrets
```

> SSH 키 등록 방법: [GitHub Docs - SSH 키 추가](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

---

## 사용법

```
bmsk                   커스텀 명령어 목록 보기

ghswitch work          GitHub 회사 계정으로 전환
ghswitch personal      GitHub 개인 계정으로 전환
ghswitch               현재 GitHub 계정 확인

bmsk update            dotfiles 최신화
bmsk update-secrets    secrets 최신화
bmsk setup-secrets     secrets 최초 설치
```

---

## 업데이트

`bmsk.zsh`를 수정한 뒤 아래 명령어로 반영하세요.

```bash
cd ~/.bmsk
git add .
git commit -m "your message"
git push
```

다른 맥에서 최신화:

```bash
bmsk update
source ~/.zshrc
```
