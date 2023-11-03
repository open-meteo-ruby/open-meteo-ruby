require_relative "general_contract"

module OpenMeteo
  class Forecast
    module Variables
      ##
      # The Variables for a general request (meaning without a specific model) to the OpenMeteo API.
      #
      # See https://open-meteo.com/en/docs
      class General < Dry::Struct
        attribute(
          :current,
          OpenMeteo::Types::Strict::Array.of(OpenMeteo::Types::Strict::Symbol).default([].freeze),
        )
        attribute(
          :hourly,
          OpenMeteo::Types::Strict::Array.of(OpenMeteo::Types::Strict::Symbol).default([].freeze),
        )
        attribute(
          :daily,
          OpenMeteo::Types::Strict::Array.of(OpenMeteo::Types::Strict::Symbol).default([].freeze),
        )

        def validate!
          GeneralContract.validate!(to_hash)
        end

        def to_get_params
          get_params = {}

          get_params[:current] = current.join(",") if current != []
          get_params[:hourly] = hourly.join(",") if hourly != []
          get_params[:daily] = daily.join(",") if daily != []

          get_params
        end
      end
    end
  end
end
