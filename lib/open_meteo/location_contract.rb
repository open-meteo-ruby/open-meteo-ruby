module OpenMeteo
  ##
  # Validation contract for OpenMeteo::Location.
  class LocationContract < OpenMeteo::ApplicationContract
    params do
      required(:latitude).filled(:float)
      required(:longitude).filled(:float)
    end

    rule(:latitude) { key.failure("must be within [-90;90]") if value < -90 || value > 90 }

    rule(:longitude) { key.failure("must be within [-180;180]") if value < -180 || value > 180 }
  end
end
