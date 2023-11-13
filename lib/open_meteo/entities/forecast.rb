require_relative "forecast/current"
require_relative "forecast/minutely_15"
require_relative "forecast/hourly"
require_relative "forecast/daily"
require_relative "forecast/units"
require_relative "forecast/item"

module OpenMeteo
  module Entities
    #
    # A forecast Entity with data returned by OpenMeteo
    class Forecast
      attr_reader :attributes, :current, :minutely_15, :hourly, :daily, :raw_json

      def initialize(json_body)
        @raw_json = json_body

        set_data(json_body, :current, OpenMeteo::Entities::Forecast::Current)
        set_data(json_body, :minutely_15, OpenMeteo::Entities::Forecast::Minutely15)
        set_data(json_body, :hourly, OpenMeteo::Entities::Forecast::Hourly)
        set_data(json_body, :daily, OpenMeteo::Entities::Forecast::Daily)

        @attributes = json_body.keys
      end

      def set_data(json_body, type, klass)
        return if json_body[type.to_s].nil?

        instance_variable_set(
          "@#{type}",
          klass.new(json_body[type.to_s], json_body["#{type}_units"]),
        )
      end
    end
  end
end
