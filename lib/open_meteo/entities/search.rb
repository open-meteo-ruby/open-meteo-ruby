module OpenMeteo
  module Entities

    ##
    # A Search Result in the Open Mateo Geolocation Api, Represents one possible location
    #
    SearchResult = Struct.new(
      :id,
      :name,
      :latitude,
      :longitude,
      :elevation,
      :feature_code,
      :country_code,
      :admin1_id,
      :admin2_id,
      :admin3_id,
      :admin4_id,
      :timezone,
      :population,
      :postcodes,
      :country_id,
      :country,
      :admin1,
      :admin2,
      :admin3,
      :admin4,
      keyword_init: true)

    ##
    # A list of possible locations from the Geolocation API
    #
    class Search
      attr_reader :attributes, :results, :raw_json

      def initialize(json_body)
        @raw_json = json_body
        @results = json_body["results"].map { |result| SearchResult.new(result) }
        @attributes = json_body.keys
      end
    end
  end
end
