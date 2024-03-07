module OpenMeteo
  class Client
    ##
    # The configuration for the OpenMeteo::Client.
    class Config
      attr_reader :api_key, :host, :logger, :timeouts

      def initialize(api_key: nil, host: nil, logger: nil, timeouts: nil)
        @api_key = api_key || OpenMeteo.configuration.api_key
        @host = host || OpenMeteo.configuration.host
        @logger = logger || OpenMeteo.configuration.logger
        @timeouts = timeouts || OpenMeteo.configuration.timeouts
      end

      def url
        "https://#{host}"
      end
    end
  end
end
