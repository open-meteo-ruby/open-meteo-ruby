require_relative "faraday_connection"
require_relative "client/config"
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
      config: OpenMeteo::Client::Config.new,
      url_builder: UrlBuilder.new(config:),
      agent: FaradayConnection.new(config:)
    )
      @config = config
      @url_builder = url_builder
      @agent = agent
    end

    def get(endpoint_name, path_params: {}, query_params: {})
      endpoint = url_builder.build_url(endpoint_name, path_params)

      agent.connect.get do |request|
        request.params = query_params.merge({ apikey: config.api_key }.compact)
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
