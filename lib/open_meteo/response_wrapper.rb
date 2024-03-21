module OpenMeteo
  ##
  # Wrap the JSON body response from the OpenMeteo request.
  #
  class ResponseWrapper
    attr_reader :config

    def initialize(config: OpenMeteo::Client::Config.new)
      @config = config
    end

    def wrap(response, entity:)
      raise OpenMeteo::Errors::ResponseError, "Empty body" if response.body.nil?

      json_body = JSON.parse(response.body)
      check_for_error(response, json_body)

      entity.new(json_body)
    rescue JSON::ParserError
      raise OpenMeteo::Errors::ResponseError, "Unable to parse the response body: #{response.body}"
    end

    private

    def check_for_error(response, json_body)
      return if response.status == 200

      error_messages = extract_error_messages(json_body)

      @config.logger.debug(error_messages)

      raise OpenMeteo::Errors::ResponseError, error_messages
    end

    def extract_error_messages(json_body)
      error_value = json_body["error"]
      return "" if error_value.nil? || error_value == false

      json_body["reason"].to_s
    end
  end
end
