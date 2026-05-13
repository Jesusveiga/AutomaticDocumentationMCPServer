#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Cleanup and Organization Script for Power BI Docs Generator Repository
    
.DESCRIPTION
    This script:
    1. Moves templates to /templates
    2. Moves examples to /examples
    3. Moves helper scripts to /scripts
    4. Deletes unnecessary files
    5. Prepares for GitHub upload
    
.NOTES
    Run from the project root directory
#>

Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        Power BI Docs Generator - Cleanup Script             ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

function Write-Success { Write-Host "[✓] $args" -ForegroundColor Green }
function Write-Info { Write-Host "[i] $args" -ForegroundColor Cyan }
function Write-Warning { Write-Host "[!] $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "[✗] $args" -ForegroundColor Red }

$baseDir = Get-Location

# STEP 1: Move templates
Write-Info "STEP 1: Moving templates to /templates..."
$templateFiles = @("Professional_Template.docx", "My_Professional_Template.docx")
foreach ($file in $templateFiles) {
    $source = Join-Path $baseDir $file
    if (Test-Path $source) {
        $dest = Join-Path $baseDir "templates" $file
        Move-Item -Path $source -Destination $dest -Force 2>/dev/null
        if ($?) {
            Write-Success "Moved: $file → templates/"
        }
    }
}

# STEP 2: Move helper scripts
Write-Info "STEP 2: Moving helper scripts to /scripts..."
$scriptFiles = @("generar_plantilla.py")
foreach ($file in $scriptFiles) {
    $source = Join-Path $baseDir $file
    if (Test-Path $source) {
        $dest = Join-Path $baseDir "scripts" $file
        Move-Item -Path $source -Destination $dest -Force 2>/dev/null
        if ($?) {
            Write-Success "Moved: $file → scripts/"
        }
    }
}

# STEP 3: Move examples
Write-Info "STEP 3: Moving generated examples to /examples..."
$exampleFiles = @(
    "TechnicalDesign_EmailCommunication_DummyReport.docx",
    "TechnicalDesign_EmailCommunication_DummyReport.pdf",
    "TechnicalDesign_EmailCommunicationReport.pdf",
    "AccumulatedPBIPMetadata.txt"
)
foreach ($file in $exampleFiles) {
    $source = Join-Path $baseDir $file
    if (Test-Path $source) {
        $dest = Join-Path $baseDir "examples" $file
        Move-Item -Path $source -Destination $dest -Force 2>/dev/null
        if ($?) {
            Write-Success "Moved: $file → examples/"
        }
    }
}

# STEP 4: Delete unnecessary files
Write-Info "STEP 4: Deleting unnecessary files..."
$filesToDelete = @(
    "pandoc-3.9.0.2-windows-x86_64.msi",  # Installer - not needed
    "SDG Group - BOEHRINGER_GFE Balanced Scorecard Dashboard_Technical Design & Specifications Template.docx",  # Old template from different project
    "~$chnicalDesign_EmailCommunication_DummyReport.docx"  # Temp Word file
)
foreach ($file in $filesToDelete) {
    $source = Join-Path $baseDir $file
    if (Test-Path $source) {
        Remove-Item -Path $source -Force 2>/dev/null
        if ($?) {
            Write-Success "Deleted: $file"
        }
    }
}

# STEP 5: Create .gitkeep files for empty directories
Write-Info "STEP 5: Adding .gitkeep files to empty directories..."
$dirs = @("templates", "examples", "scripts", "assets")
foreach ($dir in $dirs) {
    $dirPath = Join-Path $baseDir $dir
    if (Test-Path $dirPath) {
        $gitkeepPath = Join-Path $dirPath ".gitkeep"
        if (!(Test-Path $gitkeepPath)) {
            "" | Out-File -FilePath $gitkeepPath -Encoding UTF8
            Write-Success "Created: $dir/.gitkeep"
        }
    }
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                CLEANUP COMPLETED! ✓                         ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Info "New folder structure:"
Write-Host "
📁 root/
├── 📖 README.md, CONTRIBUTING.md, etc (main docs)
├── 🐍 AutomaticDocumentation.py, ConvertToPdf.py
├── 📋 requirements.txt, LICENSE, .gitignore
├── 🚀 push-to-github.ps1
│
├── 📁 templates/
│   └── Professional_Template.docx (Word template)
│
├── 📁 examples/
│   ├── TechnicalDesign_EmailCommunication_DummyReport.md
│   ├── TechnicalDesign_EmailCommunication_DummyReport.docx
│   ├── TechnicalDesign_EmailCommunication_DummyReport.pdf
│   └── AccumulatedPBIPMetadata.txt
│
├── 📁 scripts/
│   └── generar_plantilla.py (helper scripts)
│
├── 📁 assets/
│   └── (images/screenshots for documentation)
│
└── 📁 EmailCommunication_DummyReport.* (Power BI project files)
" -ForegroundColor Gray

Write-Info "Next steps:"
Write-Host "1. Review the new structure"
Write-Host "2. Run: .\push-to-github.ps1"
Write-Host "3. Your repo will be perfectly organized!"
