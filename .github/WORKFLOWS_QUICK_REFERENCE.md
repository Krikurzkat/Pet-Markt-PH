# GitHub Workflows Quick Reference

## 🚀 One-Page Cheat Sheet

### Workflow Triggers

| Workflow | Auto Trigger | Manual Trigger |
|----------|--------------|----------------|
| Laravel Tests | ✅ Push/PR | ✅ Yes |
| Code Quality | ✅ Push/PR | ✅ Yes |
| Frontend Build | ✅ Push/PR | ✅ Yes |
| Lint | ✅ Push/PR | ✅ Yes |
| Docker Build | ✅ Push/PR/Tag | ❌ No |
| CI Summary | ✅ PR Only | ❌ No |
| Dependency Updates | ⏰ Weekly | ✅ Yes |
| Database Backup | ⏰ Daily | ✅ Yes |
| Deploy | ✅ Main Push | ✅ Yes |

### Manual Workflow Execution

1. Go to **Actions** tab on GitHub
2. Select the workflow from left sidebar
3. Click **Run workflow** button
4. Choose branch and click **Run workflow**

### Common Commands

```bash
# Check workflow syntax locally (requires act)
act -l

# Validate workflow YAML
yamllint .github/workflows/*.yml

# List all workflows
ls .github/workflows/

# View workflow status
gh run list

# View specific workflow runs
gh run list --workflow="Laravel Tests"

# Re-run failed jobs
gh run rerun <run-id>
```

### Required Secrets (Optional Workflows)

**Deploy Workflow:**
```
DEPLOY_HOST=your-server.com
DEPLOY_USER=ubuntu
DEPLOY_KEY=<ssh-private-key>
```

**Database Backup:**
```
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=petmarkt_db
DB_USERNAME=root
DB_PASSWORD=<password>
AWS_ACCESS_KEY_ID=<aws-key>
AWS_SECRET_ACCESS_KEY=<aws-secret>
```

### Status Check URLs

```
https://github.com/johndogmoc/Pet-Markt-PH/actions
https://github.com/johndogmoc/Pet-Markt-PH/actions/workflows/laravel-tests.yml
https://github.com/johndogmoc/Pet-Markt-PH/actions/workflows/code-quality.yml
```

### Badge Markdown

```markdown
![Tests](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Laravel%20Tests/badge.svg)
![Quality](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Code%20Quality/badge.svg)
![Build](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Frontend%20Build/badge.svg)
![Lint](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Lint/badge.svg)
![Deploy](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Deploy%20to%20Production/badge.svg)
```

### Workflow Files

```
.github/workflows/laravel-tests.yml      # PHPUnit tests
.github/workflows/code-quality.yml       # CS Fixer, PHPStan
.github/workflows/frontend-build.yml     # npm build
.github/workflows/lint.yml               # Syntax checks
.github/workflows/deploy.yml             # Production deploy
.github/workflows/dependency-update.yml  # Dependency check
.github/workflows/database-backup.yml    # DB backup
.github/workflows/docker-build.yml       # Container build
.github/workflows/ci-summary.yml         # PR summary
```

### Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Workflow not triggering | Check branch names in workflow file |
| Tests fail | Review `.env.example` and database config |
| Build timeout | Increase timeout in workflow |
| Permission denied | Add required permissions in workflow |
| Secret not found | Add secret in Settings → Secrets → Actions |

### Useful GitHub CLI Commands

```bash
# Install GitHub CLI
# Windows: winget install GitHub.cli
# Mac: brew install gh

# Authenticate
gh auth login

# View workflow runs
gh run list

# View specific run
gh run view <run-id>

# Download artifacts
gh run download <run-id>

# Cancel a run
gh run cancel <run-id>

# Watch a workflow run
gh run watch
```

### Branch Protection Setup

```
Settings → Branches → Add rule

Branch name pattern: main
✅ Require pull request reviews before merging
✅ Require status checks to pass before merging
   - Laravel Tests
   - Code Quality  
   - Frontend Build
   - Lint
✅ Require branches to be up to date before merging
```

### Cron Schedule Examples

```yaml
# Every day at midnight
- cron: '0 0 * * *'

# Every Monday at 9 AM
- cron: '0 9 * * 1'

# Every hour
- cron: '0 * * * *'

# Every 15 minutes
- cron: '*/15 * * * *'
```

### Environment Variables in Workflows

```yaml
env:
  PHP_VERSION: '7.4'
  NODE_VERSION: '16.x'
  DB_CONNECTION: mysql
```

### Matrix Strategy Example

```yaml
strategy:
  matrix:
    php: ['7.4', '8.0', '8.1']
    os: [ubuntu-latest, windows-latest]
```

### Useful Actions

```yaml
# Checkout code
- uses: actions/checkout@v3

# Setup PHP
- uses: shivammathur/setup-php@v2

# Setup Node
- uses: actions/setup-node@v3

# Cache dependencies
- uses: actions/cache@v3

# Upload artifacts
- uses: actions/upload-artifact@v3

# Download artifacts
- uses: actions/download-artifact@v3
```

### Conditional Steps

```yaml
# Run only on main branch
- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: ./deploy.sh

# Run only on PR
- name: Comment
  if: github.event_name == 'pull_request'
  run: echo "PR detected"

# Continue on error
- name: Lint
  run: npm run lint
  continue-on-error: true
```

### Debugging Workflows

```yaml
# Enable debug logging
- name: Debug Info
  run: |
    echo "Event: ${{ github.event_name }}"
    echo "Ref: ${{ github.ref }}"
    echo "SHA: ${{ github.sha }}"
    echo "Actor: ${{ github.actor }}"

# SSH debugging (use with caution)
- name: Setup tmate session
  uses: mxschmitt/action-tmate@v3
```

### Notification Integration

```yaml
# Slack notification
- name: Slack Notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

### Performance Tips

1. **Use caching** for dependencies
2. **Run jobs in parallel** when possible
3. **Limit workflow scope** with path filters
4. **Use matrix builds** strategically
5. **Set appropriate timeouts**

### Path Filters

```yaml
on:
  push:
    paths:
      - 'app/**'
      - 'resources/**'
      - '!**.md'
```

### Cost Management

- **Public repos**: Unlimited minutes
- **Private repos**: Check your plan limits
- **Self-hosted runners**: Free, unlimited
- **Artifact storage**: 90 days default

### Support Resources

- 📚 [GitHub Actions Docs](https://docs.github.com/actions)
- 💬 [Community Forum](https://github.community)
- 🐛 [Report Issues](https://github.com/actions/toolkit/issues)
- 🎓 [Learning Lab](https://lab.github.com)

---

**Quick Access**: Bookmark this page for instant workflow reference!

*Last Updated: September 27, 2026*
