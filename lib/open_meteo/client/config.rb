module OpenMeteo
  class Client
    ##
    # The configuration for the OpenMeteo::Client.
    class Config
      attr_reader :host, :logger

      def initialize(host: nil, logger: nil)
        @host = host || OpenMeteo.configuration.host
        @logger = logger || OpenMeteo.configuration.logger
      end

      def url
        "https://#{host}"
      end
    end
  end
end
