module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast Entity for daily data returned by OpenMeteo
      class Daily
        attr_reader :items, :units, :raw_json_daily, :raw_json_daily_units

        def initialize(json_daily, json_daily_units)
          @items = initialize_items(json_daily)
          @units = json_daily_units && OpenMeteo::Entities::Forecast::Units.new(json_daily_units)

          @raw_json_daily = json_daily
          @raw_json_daily_units = json_daily_units
        end

        private

        def initialize_items(json_daily)
          json_daily["time"]
            .map do |element|
              json_daily
                .keys
                .each_with_object({}) do |attr, json_item|
                  json_item[attr] = json_daily[attr][json_daily["time"].index(element)]
                end
            end
            .map { |json_item| OpenMeteo::Entities::Forecast::Item.new(json_item) }
        end
      end
    end
  end
end
