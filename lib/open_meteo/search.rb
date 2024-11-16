require_relative "client"
require_relative "search/variables"

module OpenMeteo
  ##
  # Perform a search request to the Open Meteo Geocoding Api
  #
  # Returns a list of possible locations based of a location name string
  # https://open-meteo.com/en/docs/geocoding-api
  class Search
    def initialize(
      config: OpenMeteo::Client::Config.new(host: "geocoding-api.open-meteo.com"),
      client: OpenMeteo::Client.new(config:),
      response_wrapper: OpenMeteo::ResponseWrapper.new(config:)
    )
      @client = client
      @response_wrapper = response_wrapper
    end

    def get(name:, variables:)
      variables_object = OpenMeteo::Search::Variables.new(**variables)
      search_get(name, variables_object)
    end

    private

    attr_reader :client

    def search_get(name, variables)
      query_params = { name:, **variables.to_query_params }
      response = client.get(:search, query_params:)

      @response_wrapper.wrap(response, entity: OpenMeteo::Entities::Search)
    end
  end
end
