require_relative "location_contract"

module OpenMeteo
  ##
  # A location for a request to OpenMeteo.
  class Location < Dry::Struct
    attribute :latitude, OpenMeteo::Types::Strict::Float
    attribute :longitude, OpenMeteo::Types::Strict::Float

    def validate!
      LocationContract.validate!(to_hash)
    end

    def to_get_params
      { latitude:, longitude: }
    end
  end
end
