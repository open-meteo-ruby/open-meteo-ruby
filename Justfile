# List available commands
default:
  just --list

# Run all checks from CI
ci: format rubocop typecheck test

# Start an IRB console with the OpenMeteo Ruby files loaded
console:
  bin/console

# Format files with Prettier
format:
  bundle exec rbprettier --write '**/*.{graphql,rb,json,yml,md}'

# Lint the Ruby files with Rubocop
rubocop:
  bundle exec rubocop
lint: rubocop

# Lint and autofix the Ruby files with Rubocop
rubocop-fix:
  bundle exec rubocop -a

# Install the yard docs needed for Solargraph to work better
solargraph-setup:
  yard gems

# Run the Ruby solargraph typechecker
solargraph-typecheck: typecheck

# Run the RSpec tests
test:
  bundle exec rspec

# Run the Ruby solargraph typechecker
typecheck:
  bundle exec solargraph typecheck
