# Ruby client for [OpenMeteo](https://github.com/open-meteo/open-meteo)

... in progress.

> NOTE: [There is a plan to create official SDKs](https://github.com/open-meteo/open-meteo-website/issues/40) via [FlatBuffers](https://flatbuffers.dev/). However, I couldn't find a Ruby implementation of FlatBuffers in general. Hence, most likely, there won't be a Ruby SDK in the near future.

## Configuration

### Global configuation

There is the possibility to configure `OpenMeteo` globally e.g. in an initializer:

```ruby
# config/initializer/open_meteo.rb
require "open-meteo"

OpenMeteo.configure do |config|
  config.host = "api.my-own-open-meteo.com"
  config.logger = Rails.logger
end
```

```ruby
# some/other/file.rb
forecast = OpenMeteo::Forecast.new

location = OpenMeteo::Entities::Location.new(latitude: 52.52, longitude: 13.41)
variables = { current: %i[weather_code], hourly: %i[], daily: %i[] }
forecast_response = forecast.get(location:, variables:)
```

### Configuration of a client instance

You can also create a client that takes a configuration that overwrites the global configuration:

```ruby
# some/other/file.rb
require "open-meteo"

api_config =
  OpenMeteo::Client::Config.new(logger: Logger.new($stdout), host: "api.my-own-open-meteo.com")
client = OpenMeteo::Client.new(api_config:)
forecast = OpenMeteo::Forecast.new(client:)

location = OpenMeteo::Entities::Location.new(latitude: 52.52, longitude: 13.41)
variables = { current: %i[weather_code], hourly: %i[], daily: %i[] }
forecast_response = forecast.get(location:, variables:)
```

## Development

Useful commands are defined in the [`Justfile`](Justfile) and can be listed with [`just`](https://github.com/casey/just).

E.g. execute an [example](example.rb) request: `just example`.
