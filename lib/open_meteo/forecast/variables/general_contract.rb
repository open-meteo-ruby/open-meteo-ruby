module OpenMeteo
  class Forecast
    module Variables
      ##
      # Validation contract for OpenMeteo::Forecast::Variables::General.
      #
      # See https://open-meteo.com/en/docs
      #
      # Don't validate variables as they will grow all the time.
      # See https://github.com/open-meteo/open-meteo-website/issues/40
      class GeneralContract < OpenMeteo::ApplicationContract
        params do
          required(:current).array(:symbol)
          required(:hourly).array(:symbol)
          required(:daily).array(:symbol)
        end
      end
    end
  end
end
