require_relative "contracts/location_contract"

module OpenMeteo
  module Entities
    ##
    # A location for a request to OpenMeteo.
    class Location < Dry::Struct
      attribute :latitude, OpenMeteo::Types::Coercible::Decimal
      attribute :longitude, OpenMeteo::Types::Coercible::Decimal

      def validate!
        OpenMeteo::Entities::Contracts::LocationContract.validate!(to_hash)
      end

      def to_query_params
        { latitude:, longitude: }
      end
    end
  end
end
