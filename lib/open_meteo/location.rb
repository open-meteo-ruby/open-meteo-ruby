module OpenMeteo
  ##
  # A location for a request to OpenMeteo.
  class Location
    attr_reader :latitude, :longitude

    def initialize(longitude:, latitude:)
      @longitude = longitude
      @latitude = latitude
    end

    def validate!
      # FIXME: Placeholder for validation
      true
    end

    def to_get_params
      { latitude:, longitude: }
    end
  end
end
