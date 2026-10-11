# Checks that this computer and this clone are set up for editing the records
# (Windows). Changes nothing; says what is missing and how to fix it.
Set-Location -Path $PSScriptRoot

if (-not (Get-Command safedata -ErrorAction SilentlyContinue)) {
    Write-Host "safedata is not installed on this computer (or not on PATH). Install it with:" -ForegroundColor Red
    Write-Host '  powershell -ExecutionPolicy ByPass -c "irm https://raw.githubusercontent.com/BalzaniEdoardo/safedata/main/install.ps1 | iex"'
    Write-Host "then open a new terminal and run this script again."
    exit 1
}
safedata check
exit $LASTEXITCODE
