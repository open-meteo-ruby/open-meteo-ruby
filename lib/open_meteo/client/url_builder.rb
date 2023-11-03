module OpenMeteo
  class Client
    ##
    # The class that constructs the URLs for given endpoints.
    class UrlBuilder
      API_PATHS = { forecast: "v1/forecast" }.freeze

      attr_reader :api_config

      def initialize(api_config: OpenMeteo::Client::Config.new)
        @api_config = api_config
      end

      def build_url(endpoint, *args)
        relative_path = API_PATHS.fetch(endpoint.to_sym)
        full_path = [api_config.url, relative_path].join("/")

        URI::DEFAULT_PARSER.escape(format(full_path, args))
      end
    end
  end
end
