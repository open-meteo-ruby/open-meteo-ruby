require "faraday"

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

    attr_reader :api_config

    def initialize(
      api_config: OpenMeteo::Client::Config.new,
      url_builder: OpenMeteo::Client::UrlBuilder.new,
      agent: Faraday.new
    )
      @api_config = api_config
      @url_builder = url_builder
      @agent = agent
    end

    def get(endpoint_name, *endpoint_args, **get_params)
      endpoint = url_builder.build_url(endpoint_name, *endpoint_args)

      agent.get do |req|
        req.params = get_params
        req.url(endpoint)
      end
    rescue Faraday::ConnectionFailed => e
      raise ConnectionFailed, "Could not connect to OpenMeteo API: #{e.message}"
    rescue Faraday::TimeoutError
      raise Timeout, "Timeout error from the OpenMeteo API"
    end

    private

    attr_reader :agent, :url_builder
  end
end
