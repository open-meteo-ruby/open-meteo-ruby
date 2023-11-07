require_relative "forecast/current"
require_relative "forecast/hourly"
require_relative "forecast/daily"
require_relative "forecast/units"
require_relative "forecast/item"

module OpenMeteo
  module Entities
    #
    # A forecast Entity with data returned by OpenMeteo
    class Forecast
      attr_reader :attributes, :current, :hourly, :daily, :raw_json

      def initialize(json_body)
        @raw_json = json_body

        @current =
          json_body["current"] &&
            OpenMeteo::Entities::Forecast::Current.new(
              json_body["current"],
              json_body["current_units"],
            )
        @hourly =
          json_body["hourly"] &&
            OpenMeteo::Entities::Forecast::Hourly.new(
              json_body["hourly"],
              json_body["hourly_units"],
            )
        @daily =
          json_body["daily"] &&
            OpenMeteo::Entities::Forecast::Daily.new(json_body["daily"], json_body["daily_units"])

        @attributes = json_body.keys
      end
    end
  end
end
