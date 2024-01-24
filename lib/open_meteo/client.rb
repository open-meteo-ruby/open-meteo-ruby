require "faraday"
require "faraday/retry"

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

    # See https://github.com/lostisland/faraday-retry/tree/main#usage
    RETRY_OPTIONS = { max: 3, interval: 0.05, interval_randomness: 0.5, backoff_factor: 3 }.freeze

    attr_reader :api_config, :agent

    def initialize(api_config: OpenMeteo::Client::Config.new, url_builder: nil, agent: nil)
      @api_config = api_config
      @url_builder = url_builder || UrlBuilder.new(api_config:)
      @agent = agent || Faraday.new { |f| f.request :retry, RETRY_OPTIONS }
    end

    def get(endpoint_name, *endpoint_args, **get_params)
      endpoint = url_builder.build_url(endpoint_name, *endpoint_args)

      agent.get do |request|
        request.params = get_params.merge({ apikey: api_config.api_key }.compact)
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
