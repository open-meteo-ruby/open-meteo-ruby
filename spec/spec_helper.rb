require "byebug"
require "pry"
require "pry-byebug"
require "simplecov"

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
  minimum_coverage 99

  # DryValidation contracts are not covered by SimpleCov even if there
  # are tests for it.
  add_filter "_contract.rb"
end

require "open_meteo"

require_relative "support/vcr"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
