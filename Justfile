# List available commands
default:
  just --list

# Run all checks from CI
ci: rubocop

# Lint the Ruby files with Rubocop
rubocop:
  bundle exec rubocop

# Lint and autofix the Ruby files with Rubocop
rubocop-fix:
  bundle exec rubocop -a
