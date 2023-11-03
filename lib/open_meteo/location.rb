module OpenMeteo
  ##
  # A location for a request to OpenMeteo.
  class Location < Dry::Struct
    attribute :latitude, OpenMeteo::Types::Strict::Float
    attribute :longitude, OpenMeteo::Types::Strict::Float

    def validate!
      # FIXME: Placeholder for validation
      true
    end

    def to_get_params
      { latitude:, longitude: }
    end
  end
end
