# List available commands
default:
  just --list

# Run all checks from CI
ci: spellcheck format rubocop test

# Start an IRB console with the OpenMeteo Ruby files loaded
console:
  bin/console

# Run the example script
example:
  bundle exec ruby example.rb

# Format files with Prettier
format:
  yarn format

# Build open-meteo gem
gem-build:
  gem build open-meteo.gemspec

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

# Run the spellcheck
spellcheck:
  yarn spellcheck

# List words that are unknown to the spellchecker
spellcheck-list:
  yarn spellcheck:list

# Run the RSpec tests
test:
  bundle exec rspec

# Run the RSpec tests and open the coverage report
test-open-coverage:
  bundle exec rspec; open coverage/index.html
