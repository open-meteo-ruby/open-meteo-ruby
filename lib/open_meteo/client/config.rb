module OpenMeteo
  class Client
    ##
    # The configuration for the OpenMeteo::Client.
    class Config
      attr_reader :host, :logger

      def initialize(
        host: "api.open-meteo.com",
        logger: Logger.new("open_meteo.log")
      )
        @host = host
        @logger = logger
      end

      def url
        "https://#{host}"
      end
    end
  end
end
