# 새 PC 첫 단계: Git 설치 → 비공개 키트 저장소 받기 (Windows PowerShell 5.1 호환)
# 사용:
#   powershell -NoProfile -ExecutionPolicy Bypass -File bootstrap.ps1            # 받기만 (AI가 이후 진행)
#   powershell -NoProfile -ExecutionPolicy Bypass -File bootstrap.ps1 -Install   # 받은 뒤 설치까지
# 저장소를 처음 받을 때 GitHub 로그인 창이 뜬다. "Sign in with your browser" 를 누르면 된다.
param(
    [switch]$Install,
    [string]$Dest = (Join-Path $env:USERPROFILE 'pc-dev-setup')
)

$ErrorActionPreference = 'Stop'
$Repo = 'https://github.com/evanlab9987/pc-dev-setup.git'

function Step($msg) { Write-Host "`n=== $msg ===" -ForegroundColor Cyan }

function Find-Git {
    $cmd = Get-Command git -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    foreach ($p in "$env:ProgramFiles\Git\cmd\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe") {
        if (Test-Path $p) { return $p }
    }
    return $null
}

Step '1. Git 확인'
$git = Find-Git
if (-not $git) {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host 'winget이 없습니다. Microsoft Store에서 "앱 설치 관리자(App Installer)"를 설치한 뒤 다시 실행하세요.' -ForegroundColor Red
        exit 1
    }
    Write-Host '  Git 설치 중 (관리자 권한 확인 창이 뜨면 "예")'
    winget install --id Git.Git -e --silent --accept-package-agreements --accept-source-agreements
    $git = Find-Git
    if (-not $git) { Write-Host '  [실패] Git 설치를 확인하지 못했습니다.' -ForegroundColor Red; exit 1 }
}
$env:Path = (Split-Path $git) + ';' + $env:Path
Write-Host "  $(& $git --version)"

Step '2. 키트 저장소 받기'
if (Test-Path (Join-Path $Dest '.git')) {
    Write-Host "  이미 있음: $Dest (최신으로 받기)"
    & $git -C $Dest pull --ff-only
} else {
    Write-Host '  GitHub 로그인 창이 뜨면 "Sign in with your browser" 를 눌러 로그인하세요.'
    & $git clone $Repo $Dest
}
if ($LASTEXITCODE -ne 0) {
    Write-Host '  [실패] 저장소를 받지 못했습니다. 로그인 창에서 로그인을 마쳤는지 확인하고 다시 실행하세요.' -ForegroundColor Red
    exit 1
}
Write-Host "  완료: $Dest" -ForegroundColor Green

if ($Install) {
    Step '3. 설치 실행'
    & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Dest 'install.ps1')
} else {
    Write-Host "`n다음: $Dest\SETUP_FOR_AI.md 지침대로 진행 (직접 하려면 설치.bat 실행)" -ForegroundColor Cyan
}
