# GitHub Workflows Deployment Script (PowerShell)
# This script helps you deploy the newly created workflows to GitHub

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Pet Markt-PH - GitHub Workflows Deployment" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in a git repository
if (-not (Test-Path ".git")) {
    Write-Host "Error: Not in a git repository!" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Git repository detected" -ForegroundColor Green
Write-Host ""

# Show what will be added
Write-Host "Files to be committed:" -ForegroundColor Yellow
Write-Host "  • .github/ (16 files)" -ForegroundColor White
Write-Host "  • WORKFLOWS_SETUP.md" -ForegroundColor White
Write-Host "  • DEPLOY_WORKFLOWS.ps1 (this script)" -ForegroundColor White
Write-Host "  • DEPLOY_WORKFLOWS.sh" -ForegroundColor White
Write-Host ""

# Check for uncommitted changes
$gitStatus = git status -s
if ($gitStatus) {
    Write-Host "Current git status:" -ForegroundColor Yellow
    git status -s
    Write-Host ""
}

# Ask for confirmation
$confirmation = Read-Host "Do you want to add and commit these workflow files? (y/n)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Host "Deployment cancelled." -ForegroundColor Red
    exit 0
}

Write-Host ""
Write-Host "Step 1: Adding files to git..." -ForegroundColor Green
git add .github/
git add WORKFLOWS_SETUP.md
git add DEPLOY_WORKFLOWS.ps1
git add DEPLOY_WORKFLOWS.sh

Write-Host "✓ Files added" -ForegroundColor Green
Write-Host ""

# Get commit message
Write-Host "Enter commit message (or press Enter for default):" -ForegroundColor Yellow
$commitMessage = Read-Host "Message"

if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = @"
feat: add GitHub Actions workflows and CI/CD automation

- Add 9 GitHub Actions workflows for testing, quality, build, and deployment
- Configure Dependabot for automated dependency updates
- Add PR and issue templates for better collaboration
- Include comprehensive documentation and quick reference guide

Workflows included:
- Laravel Tests (PHPUnit with MySQL)
- Code Quality (PHP CS Fixer, PHPStan, security)
- Frontend Build (npm/webpack)
- Lint (syntax validation)
- Deploy (production automation)
- Dependency Updates (weekly monitoring)
- Database Backup (daily automation)
- Docker Build (container publishing)
- CI Summary (PR insights)
"@
}

Write-Host ""
Write-Host "Step 2: Committing changes..." -ForegroundColor Green
git commit -m $commitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Commit failed!" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Changes committed" -ForegroundColor Green
Write-Host ""

# Ask about pushing
$pushConfirmation = Read-Host "Do you want to push to GitHub now? (y/n)"
if ($pushConfirmation -ne 'y' -and $pushConfirmation -ne 'Y') {
    Write-Host "Changes committed locally but not pushed." -ForegroundColor Yellow
    Write-Host "Run 'git push' when ready to push to GitHub." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Step 3: Pushing to GitHub..." -ForegroundColor Green

# Get current branch
$currentBranch = git rev-parse --abbrev-ref HEAD
Write-Host "Current branch: $currentBranch" -ForegroundColor White

git push origin $currentBranch

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Push failed!" -ForegroundColor Red
    Write-Host "You may need to set up remote tracking or check your credentials." -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Successfully pushed to GitHub" -ForegroundColor Green
Write-Host ""

# Success message
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "✓ Deployment Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Visit your repository on GitHub" -ForegroundColor White
Write-Host "2. Go to the 'Actions' tab to see your workflows" -ForegroundColor White
Write-Host "3. Create a test PR to see workflows in action" -ForegroundColor White
Write-Host ""
Write-Host "Repository URL:" -ForegroundColor Yellow
Write-Host "https://github.com/johndogmoc/Pet-Markt-PH" -ForegroundColor Cyan
Write-Host ""
Write-Host "Actions URL:" -ForegroundColor Yellow
Write-Host "https://github.com/johndogmoc/Pet-Markt-PH/actions" -ForegroundColor Cyan
Write-Host ""
Write-Host "Optional:" -ForegroundColor Yellow
Write-Host "• Configure deployment secrets in Settings → Secrets → Actions" -ForegroundColor White
Write-Host "• Enable branch protection rules in Settings → Branches" -ForegroundColor White
Write-Host "• Add status badges to your README.md" -ForegroundColor White
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Yellow
Write-Host "• WORKFLOWS_SETUP.md - Complete setup guide" -ForegroundColor White
Write-Host "• .github/WORKFLOWS_QUICK_REFERENCE.md - Quick reference" -ForegroundColor White
Write-Host "• .github/workflows/README.md - Detailed workflow docs" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Happy coding!" -ForegroundColor Green
