module OpenMeteo
  class Search
    ##
    # The variables used for a Search in the Open Meteo Geolocation API
    #
    class Variables < Dry::Struct
      attribute(:count, OpenMeteo::Types::Strict::Integer.optional.default(nil))
      attribute(:language, OpenMeteo::Types::Strict::String.optional.default(nil))

      def to_query_params
        %i[count language].each_with_object({}) do |key, query_params|
          query_params[key] = send(key) if send(key)
        end
      end
    end
  end
end
