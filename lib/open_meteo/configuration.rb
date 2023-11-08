module OpenMeteo
  ##
  # The global configuration of the OpenMeteo client.
  #
  # @see OpenMeteo.configure
  class Configuration
    def initialize
      @config = {}
    end

    ##
    # Create a getter and a setter for a setting.
    #
    # If the default value is a Proc, it will be called on initialize.
    #
    # @param name: Symbol
    # @param default: Proc | Object
    def self.add_setting(name, default)
      define_method name do
        @config[name] ||= default.is_a?(Proc) ? default.call : default
      end

      define_method "#{name}=" do |value|
        @config[name] = value
      end
    end

    add_setting :logger, -> { Logger.new($stdout) }
    add_setting :host, "api.open-meteo.com"
  end
end
