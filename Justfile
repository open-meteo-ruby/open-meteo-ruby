# List available commands
default:
  just --list

# Run all checks from CI
ci: format rubocop test

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

# Run the RSpec tests
test:
  bundle exec rspec
