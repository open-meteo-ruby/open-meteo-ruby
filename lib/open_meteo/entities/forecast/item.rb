module OpenMeteo
  module Entities
    class Forecast
      ##
      # A forecast entity for a data item returned by OpenMeteo
      class Item
        class UnknownWeatherCode < StandardError
        end

        ##
        # The conversion map of weather_codes to a more descriptive symbol.
        #
        # See "WMO Weather interpretation codes (WW)" on
        # https://open-meteo.com/en/docs
        WMO_CODE_TO_SYMBOL_MAP = {
          0 => :clear_sky,
          1 => :mainly_clear,
          2 => :partly_cloudy,
          3 => :overcast,
          45 => :fog,
          48 => :depositing_rime_fog,
          51 => :drizzle_light,
          53 => :drizzle_moderate,
          55 => :drizzle_dense,
          56 => :freezing_drizzle_light,
          57 => :freezing_drizzle_dense,
          61 => :rain_slight,
          63 => :rain_moderate,
          65 => :rain_heavy,
          66 => :freezing_rain_slight,
          67 => :freezing_rain_heavy,
          71 => :snow_slight,
          73 => :snow_moderate,
          75 => :snow_heavy,
          77 => :snow_grains,
          80 => :rain_showers_slight,
          81 => :rain_showers_moderate,
          82 => :rain_showers_violent,
          85 => :snow_showers_slight,
          86 => :snow_showers_heavy,
          95 => :thunderstorm_slight_or_moderate,
          96 => :thunderstorm_with_slight_hail,
          99 => :thunderstorm_with_heavy_hail,
        }.freeze

        attr_reader :raw_json, :attributes, :time

        def initialize(json_data)
          @raw_json = json_data

          @attributes = json_data.keys
          @time = json_data["time"]
        end

        ##
        # Provide a symbol for the weather_code.
        #
        # @see WMO_CODE_TO_SYMBOL_MAP
        def weather_code_symbol
          return if weather_code.nil?

          WMO_CODE_TO_SYMBOL_MAP.fetch(weather_code) { raise UnknownWeatherCode, weather_code }
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
