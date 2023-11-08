module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast entity for a data item returned by OpenMeteo
      class Item
        attr_reader :raw_json, :attributes, :time

        def initialize(json_data)
          @raw_json = json_data

          @attributes = json_data.keys
          @time = json_data["time"]
        end

        private

        def method_missing(name, *args)
          if raw_json.key?(name.to_s)
            raw_json[name.to_s]
          else
            super
          end
        end

        def respond_to_missing?(name, include_private = false)
          raw_json.key?(name.to_s) || super
        end
      end
    end
  end
end
