require_relative "client"
require_relative "forecast/variables"

module OpenMeteo
  ##
  # Perform a forecase request to the OpenMeteo API.
  #
  # See https://open-meteo.com/en/docs
  class Forecast
    class ForecastModelNotImplemented < StandardError
    end
    class WrongLocationType < StandardError
    end

    def initialize(client: OpenMeteo::Client.new)
      @client = client
    end

    def get(location:, variables:, model: :general)
      ensure_valid_location(location)

      model_definition = get_model_definition(model)

      variables_object = OpenMeteo::Forecast::Variables.new(**variables)

      get_forecast(model_definition[:endpoint], location, variables_object)
    end

    private

    attr_reader :client

    AVAILABLE_FORECAST_MODELS = {
      general: {
        # See https://open-meteo.com/en/docs
        endpoint: :forecast,
      },
    }.freeze

    def get_model_definition(model)
      AVAILABLE_FORECAST_MODELS.fetch(model) { raise ForecastModelNotImplemented }
    end

    def ensure_valid_location(location)
      raise WrongLocationType unless location.is_a? OpenMeteo::Entities::Location

      location.validate!
    end

    def get_forecast(endpoint, location, variables)
      get_params = { **location.to_get_params, **variables.to_get_params }
      client.get(endpoint, **get_params)
    end
  end
end
