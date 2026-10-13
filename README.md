# pc-dev-setup-start

비공개 개발환경 키트(`evanlab9987/pc-dev-setup`)를 새 PC에 받는 첫 단계입니다.
이 저장소에는 Git 설치와 키트 받기 스크립트만 있고, 설정·목록은 들어 있지 않습니다.

## 사용: Claude 또는 Codex에게 이렇게 요청

```
명령:셋팅
PC 개발자 셋팅해줘. github.com/evanlab9987/pc-dev-setup-start 의 README 지침대로 진행해줘.
```

## 직접 하려면 (PowerShell)

```
irm https://raw.githubusercontent.com/evanlab9987/pc-dev-setup-start/main/bootstrap.ps1 -OutFile $env:TEMP\bootstrap.ps1; powershell -NoProfile -ExecutionPolicy Bypass -File $env:TEMP\bootstrap.ps1 -Install
```

---

## AI 작업 지침: "명령:셋팅"

대상은 Windows 10/11 새 PC다. 답변은 간결한 한국어로 한다.

1. Windows인지 확인한다. 아니면 중단하고 알린다.
2. 사용자에게 먼저 알린다: "Git 설치 중 관리자 권한 확인 창이 뜨면 '예', 이어서 GitHub 로그인 창이 뜨면 'Sign in with your browser'를 눌러 로그인해 주세요."
3. 이 저장소의 `bootstrap.ps1` 을 임시 폴더에 받아 실행한다 (`-Install` 없이):
   ```
   irm https://raw.githubusercontent.com/evanlab9987/pc-dev-setup-start/main/bootstrap.ps1 -OutFile $env:TEMP\bootstrap.ps1
   powershell -NoProfile -ExecutionPolicy Bypass -File $env:TEMP\bootstrap.ps1
   ```
   - Git이 없으면 winget으로 설치하고, 키트를 `%USERPROFILE%\pc-dev-setup` 에 받는다.
   - 로그인은 Git 로그인 창(Git Credential Manager)에서 사용자가 직접 한다. AI는 로그인 정보를 입력하지 않는다.
   - 로그인 창을 기다리는 동안 명령이 멈춰 있을 수 있다. 시간 제한을 넉넉히(10분) 두고 실행한다.
   - 실패하면 사용자에게 GitHub 웹에서 ZIP으로 받아 압축을 풀고 그 경로를 알려 달라고 요청한다.
4. 받은 뒤 `%USERPROFILE%\pc-dev-setup\SETUP_FOR_AI.md` 를 읽고, 그 문서의 **2단계(설치 실행)부터** 따른다.
