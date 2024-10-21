require "faraday"
require "faraday/retry"

module OpenMeteo
  ##
  # The Faraday connection
  class FaradayConnection
    # See https://github.com/lostisland/faraday-retry/tree/main#usage
    RETRY_OPTIONS = { max: 3, interval: 0.05, interval_randomness: 0.5, backoff_factor: 3 }.freeze

    attr_reader :config

    def initialize(config: OpenMeteo::Client::Config.new)
      @config = config
    end

    def connect
      Faraday.new do |conn|
        conn.options[:timeout] = config.timeouts[:timeout]
        conn.options[:open_timeout] = config.timeouts[:open_timeout]

        conn.request :retry, RETRY_OPTIONS
        conn.response :logger, config.logger
      end
    end
  end
end
