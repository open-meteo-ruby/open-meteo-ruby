require "dry-types"
require "dry-struct"
require "dry-validation"

require_relative "entities/contracts/application_contract"

module OpenMeteo
  ##
  # The types from the dry-types gem.
  module Types
    include Dry.Types()
  end
end
