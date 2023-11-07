module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast Entity for current data returned by OpenMeteo
      class Current
        attr_reader :item, :units, :raw_json_current, :raw_json_current_units

        def initialize(json_current, json_current_units)
          @item = json_current && OpenMeteo::Entities::Forecast::Item.new(json_current)
          @units =
            json_current_units && OpenMeteo::Entities::Forecast::Units.new(json_current_units)

          @raw_json_current = json_current
          @raw_json_current_units = json_current_units
        end
      end
    end
  end
end
