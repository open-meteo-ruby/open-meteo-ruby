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
        :minutely_15,
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
      attribute(
        :models,
        OpenMeteo::Types::Strict::Array.of(OpenMeteo::Types::Strict::Symbol).default([].freeze),
      )
      attribute(:timezone, OpenMeteo::Types::Strict::String.optional.default(nil))

      def to_query_params
        query_params = {}

        %i[current minutely_15 hourly daily models].each do |key|
          query_params[key] = send(key).join(",") if send(key) != []
        end

        %i[timezone].each { |key| query_params[key] = send(key) if send(key) }

        query_params
      end
    end
  end
end
