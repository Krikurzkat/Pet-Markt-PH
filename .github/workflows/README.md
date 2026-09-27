# GitHub Actions Workflows

This directory contains automated workflows for the Pet Markt-PH Laravel application.

## Available Workflows

### 1. Laravel Tests (`laravel-tests.yml`)
- **Trigger**: Push/PR to main, master, or develop branches
- **Purpose**: Run PHPUnit tests with MySQL database
- **Features**:
  - PHP 7.4 environment setup
  - MySQL 8.0 service container
  - Code coverage reporting
  - Uploads coverage to Codecov

### 2. Code Quality (`code-quality.yml`)
- **Trigger**: Push/PR to main, master, or develop branches
- **Purpose**: Ensure code quality standards
- **Checks**:
  - PHP CS Fixer for code style
  - PHPStan for static analysis
  - Security vulnerability scanning

### 3. Frontend Build (`frontend-build.yml`)
- **Trigger**: Push/PR to main, master, or develop branches
- **Purpose**: Build and validate frontend assets
- **Features**:
  - Tests on Node.js 14.x and 16.x
  - Development and production builds
  - Uploads build artifacts

### 4. Lint (`lint.yml`)
- **Trigger**: Push/PR to main, master, or develop branches
- **Purpose**: Validate syntax and code structure
- **Checks**:
  - PHP syntax validation
  - Composer.json validation
  - JavaScript linting (if configured)
  - Blade template checks

### 5. Deploy (`deploy.yml`)
- **Trigger**: Push to main/master or manual dispatch
- **Purpose**: Deploy to production environment
- **Features**:
  - Optimized dependency installation
  - Frontend asset compilation
  - Creates deployment artifact
  - SSH deployment (requires configuration)

### 6. Dependency Updates (`dependency-update.yml`)
- **Trigger**: Weekly schedule (Monday 9 AM UTC) or manual
- **Purpose**: Monitor outdated dependencies
- **Features**:
  - Checks Composer packages
  - Checks npm packages
  - Generates update report

### 7. Database Backup (`database-backup.yml`)
- **Trigger**: Daily schedule (2 AM UTC) or manual
- **Purpose**: Automated database backups
- **Features**:
  - MySQL dump creation
  - Cloud storage upload (requires configuration)
  - Configurable retention

### 8. Docker Build (`docker-build.yml`)
- **Trigger**: Push/PR to main branches, version tags
- **Purpose**: Build and publish Docker images
- **Features**:
  - Multi-platform support
  - GitHub Container Registry integration
  - Automated tagging
  - Creates Dockerfile if missing

## Configuration Required

### For All Workflows
Ensure your repository has these basic files:
- `.env.example` - Environment template
- `composer.json` - PHP dependencies
- `package.json` - Node.js dependencies
- `phpunit.xml` - PHPUnit configuration

### For Deploy Workflow
Add these repository secrets:
- `DEPLOY_HOST` - Server hostname
- `DEPLOY_USER` - SSH username
- `DEPLOY_KEY` - SSH private key

### For Database Backup
Add these repository secrets:
- `DB_HOST` - Database host
- `DB_PORT` - Database port
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database user
- `DB_PASSWORD` - Database password
- `AWS_ACCESS_KEY_ID` - AWS access key (if using S3)
- `AWS_SECRET_ACCESS_KEY` - AWS secret key (if using S3)

### For Code Coverage
- Create a [Codecov](https://codecov.io) account
- Add repository to Codecov
- Token is automatically provided via GitHub integration

## Environments

Create the following environments in repository settings:
- `production` - For deployment workflows

## Branch Protection

Consider enabling branch protection rules:
- Require status checks to pass before merging
- Require pull request reviews
- Require linear history
- Include administrators

## Status Badges

Add these to your README.md:

```markdown
![Laravel Tests](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Laravel%20Tests/badge.svg)
![Code Quality](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Code%20Quality/badge.svg)
![Frontend Build](https://github.com/johndogmoc/Pet-Markt-PH/workflows/Frontend%20Build/badge.svg)
```

## Customization

Each workflow can be customized by:
1. Modifying trigger conditions
2. Adjusting PHP/Node versions
3. Adding or removing steps
4. Configuring environment variables

## Troubleshooting

### Workflow not triggering
- Check branch names match your repository
- Verify workflow files are in `.github/workflows/`
- Ensure YAML syntax is valid

### Tests failing
- Check database configuration
- Verify all dependencies are installed
- Review test environment variables

### Deployment issues
- Verify all secrets are configured
- Test SSH connection manually
- Check server permissions

## Support

For issues or questions:
1. Check workflow run logs in GitHub Actions tab
2. Review individual step outputs
3. Consult Laravel and GitHub Actions documentation
