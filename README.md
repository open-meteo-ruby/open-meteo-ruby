<h1 align="center">
  Ruby client for <a href="https://github.com/open-meteo/open-meteo">OpenMeteo</a>
</h1>

<p align="center">
  <a href="https://github.com/open-meteo-ruby/open-meteo-ruby/actions?query=branch%3Amain+">
    <img alt="CI" src="https://github.com/open-meteo-ruby/open-meteo-ruby/actions/workflows/ci.yml/badge.svg" \>
  </a>
  <a href="https://codecov.io/gh/open-meteo-ruby/open-meteo-ruby">
    <img alt="CodeCov" src="https://codecov.io/gh/open-meteo-ruby/open-meteo-ruby/branch/main/graph/badge.svg?token=V5HKH4C2BA" \>
  </a>
  <a href="https://rubygems.org/gems/open-meteo">
    <img src="https://badge.fury.io/rb/open-meteo.svg" alt="Gem Version" height="18">
  </a>
</p>

<p align="center">
  This client library lets you easily connect to the <a href="https://open-meteo.com/">OpenMeteo API</a>.
</p>

> NOTE: [There is a plan to create official SDKs](https://github.com/open-meteo/open-meteo-website/issues/40) via [FlatBuffers](https://flatbuffers.dev/). However, I couldn't find a Ruby implementation of FlatBuffers in general. Hence, most likely, there won't be a Ruby SDK in the near future.

## Usage

```ruby
require "open_meteo"

location = OpenMeteo::Entities::Location.new(latitude: 52.52.to_d, longitude: 13.41.to_d)
variables = { current: %i[], hourly: %i[weather_code], daily: %i[] }
data = OpenMeteo::Forecast.new.get(location:, variables:)

data.hourly.items.each { |item| puts item.weather_code_symbol }
```

### Forecast models

#### Forecast models in general request

The general forecast endpoint allows for models to be specified which adds suffixes to the response variables if multiple models are selected. You can make use of this by adding models to the forecast variables:

```ruby
variables = {
  current: %i[],
  hourly: %i[weather_code],
  daily: %i[],
  models: %i[best_match ecmwf_ifs04],
}
```

#### Forecast models in separate requests

There are separate requests for certain weather models. You can make use of those by providing the model symbol to `Forecast#get`:

```ruby
data = OpenMeteo::Forecast.new.get(location:, variables:, model: :dwd_icon)
```

Default is `:general`.

Available models:

- `:general`: [OpenMeteo Weather Forecast](https://open-meteo.com/en/docs)
- `:dwd_icon`: [DWD ICON](https://open-meteo.com/en/docs/dwd-api)

## Configuration

### Global configuration

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
