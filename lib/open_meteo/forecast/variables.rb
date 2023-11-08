module OpenMeteo
  class Forecast
    ##
    # The Variables for a forecast request to the OpenMeteo API.
    #
    # See https://open-meteo.com/en/docs
    class Variables < Dry::Struct
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
