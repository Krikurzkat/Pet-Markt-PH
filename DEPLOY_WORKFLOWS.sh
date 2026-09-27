#!/bin/bash

# GitHub Workflows Deployment Script
# This script helps you deploy the newly created workflows to GitHub

echo "================================================"
echo "  Pet Markt-PH - GitHub Workflows Deployment"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: Not in a git repository!${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Git repository detected"
echo ""

# Show what will be added
echo -e "${YELLOW}Files to be committed:${NC}"
echo "  • .github/ (16 files)"
echo "  • WORKFLOWS_SETUP.md"
echo "  • DEPLOY_WORKFLOWS.sh (this script)"
echo ""

# Check for uncommitted changes
if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}Current git status:${NC}"
    git status -s
    echo ""
fi

# Ask for confirmation
read -p "Do you want to add and commit these workflow files? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Deployment cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${GREEN}Step 1: Adding files to git...${NC}"
git add .github/
git add WORKFLOWS_SETUP.md
git add DEPLOY_WORKFLOWS.sh

echo -e "${GREEN}✓${NC} Files added"
echo ""

# Get commit message
echo -e "${YELLOW}Enter commit message (or press Enter for default):${NC}"
read -p "Message: " commit_message

if [ -z "$commit_message" ]; then
    commit_message="feat: add GitHub Actions workflows and CI/CD automation

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
- CI Summary (PR insights)"
fi

echo ""
echo -e "${GREEN}Step 2: Committing changes...${NC}"
git commit -m "$commit_message"

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Commit failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Changes committed"
echo ""

# Ask about pushing
read -p "Do you want to push to GitHub now? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Changes committed locally but not pushed.${NC}"
    echo "Run 'git push' when ready to push to GitHub."
    exit 0
fi

echo ""
echo -e "${GREEN}Step 3: Pushing to GitHub...${NC}"

# Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

git push origin "$current_branch"

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Push failed!${NC}"
    echo "You may need to set up remote tracking or check your credentials."
    exit 1
fi

echo -e "${GREEN}✓${NC} Successfully pushed to GitHub"
echo ""

# Success message
echo "================================================"
echo -e "${GREEN}✓ Deployment Complete!${NC}"
echo "================================================"
echo ""
echo "Next steps:"
echo "1. Visit your repository on GitHub"
echo "2. Go to the 'Actions' tab to see your workflows"
echo "3. Create a test PR to see workflows in action"
echo ""
echo "Repository URL:"
echo "https://github.com/johndogmoc/Pet-Markt-PH"
echo ""
echo "Actions URL:"
echo "https://github.com/johndogmoc/Pet-Markt-PH/actions"
echo ""
echo -e "${YELLOW}Optional:${NC}"
echo "• Configure deployment secrets in Settings → Secrets → Actions"
echo "• Enable branch protection rules in Settings → Branches"
echo "• Add status badges to your README.md"
echo ""
echo "Documentation:"
echo "• WORKFLOWS_SETUP.md - Complete setup guide"
echo "• .github/WORKFLOWS_QUICK_REFERENCE.md - Quick reference"
echo "• .github/workflows/README.md - Detailed workflow docs"
echo ""
echo "🎉 Happy coding!"
