module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast Entity for 15 minute data returned by OpenMeteo
      class Minutely15
        attr_reader :items, :units, :raw_json_hourly, :raw_json_hourly_units

        def initialize(json_minutely_15, json_minutely_15_units)
          @items = initialize_items(json_minutely_15)
          @units =
            json_minutely_15_units &&
              OpenMeteo::Entities::Forecast::Units.new(json_minutely_15_units)

          @raw_json_minutely_15 = json_minutely_15
          @raw_json_minutely_15_units = json_minutely_15_units
        end

        private

        def initialize_items(json_minutely_15)
          json_minutely_15["time"]
            .map do |element|
              json_minutely_15
                .keys
                .each_with_object({}) do |attr, json_item|
                  json_item[attr] = json_minutely_15[attr][json_minutely_15["time"].index(element)]
                end
            end
            .map { |json_item| OpenMeteo::Entities::Forecast::Item.new(json_item) }
        end
      end
    end
  end
end
