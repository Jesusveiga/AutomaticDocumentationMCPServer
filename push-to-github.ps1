#!/usr/bin/env pwsh
param(
    [Parameter(Mandatory=$true)][string]$RepositoryURL,
    [Parameter(Mandatory=$true)][string]$UserName,
    [Parameter(Mandatory=$true)][string]$UserEmail
)

# Helpers de color sencillos
function Write-Success { Write-Host "[OK] $args" -ForegroundColor Green }
function Write-Error { Write-Host "[X] $args" -ForegroundColor Red }
function Write-Info { Write-Host "[i] $args" -ForegroundColor Cyan }

Write-Host "--- Git Automation Starting ---" -ForegroundColor Cyan

# 1. Init si no existe
if (!(Test-Path ".git")) {
    git init
    git config user.name $UserName
    git config user.email $UserEmail
}

# 2. Configurar Usuario
git config user.name $UserName
git config user.email $UserEmail
Write-Success "User configured: $UserName"

# 3. Add y Commit
Write-Info "Staging files..."
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "feat: Initial commit - Power BI Documentation System"
    Write-Success "Commit created"
} else {
    Write-Host "No changes to commit."
}

# 4. Remote
Write-Info "Configuring remote..."
git remote remove origin 2>$null
git remote add origin $RepositoryURL
Write-Success "Remote set to $RepositoryURL"

# 5. Push
$proceed = Read-Host "Proceed with push to GitHub? (y/n)"
if ($proceed -eq "y") {
    Write-Info "Pushing to main branch..."
    # Asegurar que la rama se llame main
    git branch -M main
    git push -u origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "---------------------------------------" -ForegroundColor Green
        Write-Host "   UPLOAD COMPLETE - CHECK GITHUB!     " -ForegroundColor Green
        Write-Host "---------------------------------------" -ForegroundColor Green
    } else {
        Write-Error "Push failed. Check your internet or GitHub Permissions."
    }
} else {
    Write-Host "Upload cancelled."
}