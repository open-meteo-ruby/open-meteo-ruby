module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast entity for data units returned by OpenMeteo
      class Units
        attr_reader :raw_json_units, :attributes, :time

        def initialize(json_units)
          @raw_json_units = json_units

          @attributes = json_units.keys
          @time = json_units["time"]
        end

        private

        def method_missing(name, *args)
          if raw_json_units.key?(name.to_s)
            raw_json_units[name.to_s]
          else
            super
          end
        end

        def respond_to_missing?(name, include_private = false)
          raw_json_units.key?(name.to_s) || super
        end
      end
    end
  end
end
