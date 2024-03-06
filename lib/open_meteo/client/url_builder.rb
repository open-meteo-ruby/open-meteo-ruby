module OpenMeteo
  class Client
    ##
    # The class that constructs the URLs for given endpoints.
    class UrlBuilder
      API_PATHS = { forecast: "v1/forecast", forecast_dwd_icon: "v1/dwd-icon" }.freeze

      attr_reader :config

      def initialize(config: OpenMeteo.configuration)
        @config = config
      end

      def build_url(endpoint, *args)
        relative_path = API_PATHS.fetch(endpoint.to_sym)
        full_path = ["https://#{config.host}", relative_path].join("/")

        URI::DEFAULT_PARSER.escape(format(full_path, args))
      end
    end
  end
end
