module OpenMeteo
  module Entities
    ##
    # A Search Result in the Open Meteo Geolocation Api, Represents one possible location
    #
    SearchResult =
      Struct.new(
        :id,
        :name,
        :latitude,
        :longitude,
        :elevation,
        :feature_code,
        :country_code,
        :admin_1_id,
        :admin_2_id,
        :admin_3_id,
        :admin_4_id,
        :timezone,
        :population,
        :postcodes,
        :country_id,
        :country,
        :admin_1,
        :admin_2,
        :admin_3,
        :admin_4,
        keyword_init: true,
      )

    ##
    # A list of possible locations from the Geolocation API
    #
    class Search
      attr_reader :attributes, :results, :raw_json

      def initialize(json_body)
        @raw_json = json_body

        @results =
          json_body["results"].map do |result|
            normalized_result = result.transform_keys { |key| key.to_s.gsub(/(\w)(\d)/, '\1_\2') }

            SearchResult.new(normalized_result)
          end
        @attributes = json_body.keys
      end
    end
  end
end
