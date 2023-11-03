module OpenMeteo
  class Forecast
    module Variables
      ##
      # Validation contract for OpenMeteo::Forecast::Variables::General.
      #
      # See https://open-meteo.com/en/docs
      class GeneralContract < OpenMeteo::ApplicationContract # rubocop:disable Metrics/ClassLength
        params do
          required(:current).array(:symbol)
          required(:hourly).array(:symbol)
          required(:daily).array(:symbol)
        end

        CURRENT_VARIABALES = %i[
          apparent_temperature
          cloudcover
          is_day
          precipitation
          pressure_msl
          rain
          relativehumidity_2m
          showers
          snowfall
          surface_pressure
          temperature_2m
          weathercode
          winddirection_10m
          windgusts_10m
          windspeed_10m
        ].freeze

        HOURLY_VARIABLES_BASE = %i[
          apparent_temperature
          cloudcover
          cloudcover_high
          cloudcover_low
          cloudcover_mid
          dewpoint_2m
          et0_fao_evapotranspiration
          evapotranspiration
          precipitation
          precipitation_probability
          pressure_msl
          rain
          relativehumidity_2m
          showers
          snow_depth
          snowfall
          soil_moisture_0_to_1cm
          soil_moisture_1_to_3cm
          soil_moisture_27_to_81cm
          soil_moisture_3_to_9cm
          soil_moisture_9_to_27cm
          soil_temperature_0cm
          soil_temperature_18cm
          soil_temperature_54cm
          soil_temperature_6cm
          surface_pressure
          temperature_120m
          temperature_180m
          temperature_2m
          temperature_80m
          vapor_pressure_deficit
          visibility
          weathercode
          winddirection_10m
          winddirection_120m
          winddirection_180m
          winddirection_80m
          windgusts_10m
          windspeed_10m
          windspeed_120m
          windspeed_180m
          windspeed_80m
        ].freeze

        HOURLY_VARIABLES_ADDITIONAL = %i[
          uv_index
          uv_index_clear_sky
          is_day
          cape
          freezinglevel_height
        ].freeze

        HOURLY_VARIABLES_SOLAR_RADIATION = %i[
          shortwave_radiation
          direct_radiation
          diffuse_radiation
          direct_normal_irradiance
          terrestrial_radiation
          shortwave_radiation_instant
          direct_radiation_instant
          diffuse_radiation_instant
          direct_normal_irradiance_instant
          terrestrial_radiation_instant
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_TEMPERATURE = %i[
          temperature_1000hPa
          temperature_975hPa
          temperature_950hPa
          temperature_925hPa
          temperature_900hPa
          temperature_850hPa
          temperature_800hPa
          temperature_700hPa
          temperature_600hPa
          temperature_500hPa
          temperature_400hPa
          temperature_300hPa
          temperature_250hPa
          temperature_200hPa
          temperature_150hPa
          temperature_100hPa
          temperature_70hPa
          temperature_50hPa
          temperature_30hPa
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_RELATIVE_HUMIDITY = %i[
          relativehumidity_1000hPa
          relativehumidity_975hPa
          relativehumidity_950hPa
          relativehumidity_925hPa
          relativehumidity_900hPa
          relativehumidity_850hPa
          relativehumidity_800hPa
          relativehumidity_700hPa
          relativehumidity_600hPa
          relativehumidity_500hPa
          relativehumidity_400hPa
          relativehumidity_300hPa
          relativehumidity_250hPa
          relativehumidity_200hPa
          relativehumidity_150hPa
          relativehumidity_100hPa
          relativehumidity_70hPa
          relativehumidity_50hPa
          relativehumidity_30hPa
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_CLOUDCOVER = %i[
          cloudcover_1000hPa
          cloudcover_975hPa
          cloudcover_950hPa
          cloudcover_925hPa
          cloudcover_900hPa
          cloudcover_850hPa
          cloudcover_800hPa
          cloudcover_700hPa
          cloudcover_600hPa
          cloudcover_500hPa
          cloudcover_400hPa
          cloudcover_300hPa
          cloudcover_250hPa
          cloudcover_200hPa
          cloudcover_150hPa
          cloudcover_100hPa
          cloudcover_70hPa
          cloudcover_50hPa
          cloudcover_30hPa
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_WIND_SPEED = %i[
          windspeed_1000hPa
          windspeed_975hPa
          windspeed_950hPa
          windspeed_925hPa
          windspeed_900hPa
          windspeed_850hPa
          windspeed_800hPa
          windspeed_700hPa
          windspeed_600hPa
          windspeed_500hPa
          windspeed_400hPa
          windspeed_300hPa
          windspeed_250hPa
          windspeed_200hPa
          windspeed_150hPa
          windspeed_100hPa
          windspeed_70hPa
          windspeed_50hPa
          windspeed_30hPa
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_WIND_DIRECTION = %i[
          winddirection_1000hPa
          winddirection_975hPa
          winddirection_950hPa
          winddirection_925hPa
          winddirection_900hPa
          winddirection_850hPa
          winddirection_800hPa
          winddirection_700hPa
          winddirection_600hPa
          winddirection_500hPa
          winddirection_400hPa
          winddirection_300hPa
          winddirection_250hPa
          winddirection_200hPa
          winddirection_150hPa
          winddirection_100hPa
          winddirection_70hPa
          winddirection_50hPa
          winddirection_30hPa
        ].freeze

        HOURLY_VARIABLES_PRESSURE_LEVEL_GEOPOTENTIAL_HEIGHT = %i[
          geopotential_height_1000hPa
          geopotential_height_975hPa
          geopotential_height_950hPa
          geopotential_height_925hPa
          geopotential_height_900hPa
          geopotential_height_850hPa
          geopotential_height_800hPa
          geopotential_height_700hPa
          geopotential_height_600hPa
          geopotential_height_500hPa
          geopotential_height_400hPa
          geopotential_height_300hPa
          geopotential_height_250hPa
          geopotential_height_200hPa
          geopotential_height_150hPa
          geopotential_height_100hPa
          geopotential_height_70hPa
          geopotential_height_50hPa
          geopotential_height_30hPa
        ].freeze

        HOURLY_VARIABLES = [
          *HOURLY_VARIABLES_BASE,
          *HOURLY_VARIABLES_ADDITIONAL,
          *HOURLY_VARIABLES_SOLAR_RADIATION,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_TEMPERATURE,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_RELATIVE_HUMIDITY,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_CLOUDCOVER,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_WIND_SPEED,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_WIND_DIRECTION,
          *HOURLY_VARIABLES_PRESSURE_LEVEL_GEOPOTENTIAL_HEIGHT,
        ].freeze

        DAILY_VARIABLES = %i[
          apparent_temperature_max
          apparent_temperature_min
          et0_fao_evapotranspiration
          precipitation_hours
          precipitation_probability_max
          precipitation_sum
          rain_sum
          shortwave_radiation_sum
          showers_sum
          snowfall_sum
          sunrise
          sunset
          temperature_2m_max
          temperature_2m_min
          uv_index_clear_sky_max
          uv_index_max
          weathercode
          winddirection_10m_dominant
          windgusts_10m_max
          windspeed_10m_max
        ].freeze

        rule(:current).each do
          unless CURRENT_VARIABALES.include?(value)
            key.failure("must be one of #{CURRENT_VARIABALES.join(", ")}")
          end
        end

        rule(:hourly).each do
          unless HOURLY_VARIABLES.include?(value)
            key.failure("must be one of #{HOURLY_VARIABLES.join(", ")}")
          end
        end

        rule(:daily).each do
          unless DAILY_VARIABLES.include?(value)
            key.failure("must be one of #{DAILY_VARIABLES.join(", ")}")
          end
        end
      end
    end
  end
end
