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

        init_data_for(OpenMeteo::Entities::Forecast::Current)
        init_data_for(OpenMeteo::Entities::Forecast::Minutely15)
        init_data_for(OpenMeteo::Entities::Forecast::Hourly)
        init_data_for(OpenMeteo::Entities::Forecast::Daily)

        @attributes = json_body.keys
      end

      private

      def init_data_for(klass)
        name = name_for_klass(klass)

        return if raw_json[name.to_s].nil?

        instance_variable_set("@#{name}", klass.new(raw_json[name.to_s], raw_json["#{name}_units"]))
      end

      def name_for_klass(klass)
        # Extract that last part of the class name, e.g. "Minutely15"
        # from "OpenMeteo::Entities::Forecast::Minutely15"
        # but as snake_case version e.g. "minutely_15"
        klass.to_s.split("::").last.downcase.gsub(/(\d+)/, '_\1').to_sym
      end
    end
  end
end
