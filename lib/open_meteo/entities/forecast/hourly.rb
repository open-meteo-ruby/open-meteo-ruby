module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast Entity for hourly data returned by OpenMeteo
      class Hourly
        attr_reader :items, :units, :raw_json_hourly, :raw_json_hourly_units

        def initialize(json_hourly, json_hourly_units)
          @items = initialize_items(json_hourly)
          @units = json_hourly_units && OpenMeteo::Entities::Forecast::Units.new(json_hourly_units)

          @raw_json_hourly = json_hourly
          @raw_json_hourly_units = json_hourly_units
        end

        private

        def initialize_items(json_hourly)
          json_hourly["time"]
            .map do |element|
              json_hourly.keys.to_h do |attr|
                [attr, json_hourly[attr][json_hourly["time"].index(element)]]
              end
            end
            .map { |json_item| OpenMeteo::Entities::Forecast::Item.new(json_item) }
        end
      end
    end
  end
end
