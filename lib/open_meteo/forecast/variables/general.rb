module OpenMeteo
  class Forecast
    module Variables
      ##
      # The Variables for a general request (meaning without a specific model) to the OpenMeteo API.
      #
      # See https://open-meteo.com/en/docs
      class General
        attr_reader :current, :hourly, :daily

        def initialize(current:, hourly:, daily:)
          @current = current
          @hourly = hourly
          @daily = daily
        end

        def validate
          # FIXME: Placeholder for validation
          true
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
