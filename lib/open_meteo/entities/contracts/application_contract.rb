module OpenMeteo
  module Entities
    module Contracts
      ##
      # Shared functionality for dry contracts.
      class ApplicationContract < Dry::Validation::Contract
        ##
        # A validation error that can be raised on contract validation.
        class ValidationError < StandardError
          attr_reader :result, :errors

          def initialize(result)
            @errors = result.errors
            first_error_key = result.errors.first.path.first
            first_error_value = result[first_error_key]

            super(
              "Validation failed: :#{first_error_key} is #{first_error_value} but #{errors.first.text}",
            )
          end
        end

        def self.validate!(object)
          result = new.call(object)
          raise ValidationError, result unless result.errors.empty?
        end
      end
    end
  end
end
