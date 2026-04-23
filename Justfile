# List available commands
default:
  just --list

install:
  rv clean-install

# Run all checks from CI
ci: install spellcheck format rubocop test

# Start an IRB console with the OpenMeteo Ruby files loaded
console:
  bin/console

# Run the example script
example:
  rv run ruby example.rb

# Format files with Prettier
format:
  yarn format

# Build open-meteo gem
gem-build:
  gem build open-meteo.gemspec

# Push the build gem FILE to RubyGems
gem-push FILE:
  gem push {{FILE}}

# Lint the Ruby files with Rubocop
rubocop:
  rv run rubocop

lint: rubocop

# Lint and autofix the Ruby files with Rubocop
rubocop-fix:
  rv run rubocop -a

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
  rv run rspec

# Run the RSpec tests and open the coverage report
test-open-coverage:
  rv run rspec; open coverage/index.html
