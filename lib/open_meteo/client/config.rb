module OpenMeteo
  class Client
    ##
    # The configuration for the OpenMeteo::Client.
    class Config
      attr_reader :host

      def initialize(host: "api.open-meteo.com")
        @host = host
      end

      def url
        "https://#{host}"
      end
    end
  end
end
