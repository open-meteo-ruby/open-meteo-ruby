require "open_meteo/types"
require "open_meteo/configuration"
require "open_meteo/entities/location"
require "open_meteo/entities/forecast"
require "open_meteo/forecast"
require "open_meteo/response_wrapper"
require "open_meteo/errors"

##
# The OpenMeteo client.
module OpenMeteo
  # Returns the global `OpenMeteo::Configuration` object. While
  # you _can_ use this method to access the configuration, the more common
  # convention is to use `OpenMeteo.configure``
  #
  # @example
  #     OpenMeteo.configuration.logger = Logger.new($stdout)
  # @see OpenMeteo.configure
  # @see OpenMeteo::Configuration
  def self.configuration
    @configuration ||= OpenMeteo::Configuration.new
  end

  # Yields the global configuration to a block.
  # @yield [Configuration] global configuration
  #
  # @example
  #     OpenMeteo.configure do |config|
  #       config.logger Logger.new($stdout)
  #     end
  # @see OpenMeteo::Configuration
  def self.configure
    raise ArgumentError, "Please provide a block to configure" unless block_given?

    yield configuration
  end
end
