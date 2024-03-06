require_relative "faraday_connection"
require_relative "client/url_builder"

module OpenMeteo
  ##
  # The client that makes the actual requests to the OpenMeteo API.
  class Client
    class ConnectionFailed < StandardError
    end
    class Timeout < StandardError
    end

    attr_reader :config, :agent

    def initialize(
      config: OpenMeteo.configuration,
      url_builder: nil,
      agent: FaradayConnection.new.connect
    )
      @config = config
      @url_builder = url_builder || UrlBuilder.new(config:)
      @agent = agent
    end

    def get(endpoint_name, *endpoint_args, **get_params)
      endpoint = url_builder.build_url(endpoint_name, *endpoint_args)

      agent.get do |request|
        request.params = get_params.merge({ apikey: config.api_key }.compact)
        request.url(endpoint)
      end
    rescue Faraday::ConnectionFailed => e
      raise ConnectionFailed, "Could not connect to OpenMeteo API: #{e.message}"
    rescue Faraday::TimeoutError
      raise Timeout, "Timeout error from the OpenMeteo API"
    end

    private

    attr_reader :url_builder
  end
end
