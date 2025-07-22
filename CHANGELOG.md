# Changelog

## [Unreleased]

## [0.3.5] - 2025-07-22

- Add more variables: `temperature_unit`, `wind_speed_unit`, `precipitation_unit`, `forecast_days`, `past_days`

## [0.3.4] - 2025-04-06

- Add [Geocoding API](https://open-meteo.com/en/docs/geocoding-api) via `OpenMeteo::Search`

## [0.3.3] - 2024-10-23

- refactor(UrlBuilder): use variable interpolation instead of `%s, %i` for string substitution
- Add `timezone` to variables ([Issue #69](https://github.com/open-meteo-ruby/open-meteo-ruby/issues/69))
- fix(logging): uses configured logger with Faraday https://github.com/cpb

## [0.3.2] - 2024-03-21

- Forecast class accepts a initializer config class that is shared across dependent classes.

## [0.3.1] - 2024-03-08

- Add configurable timeouts

## [0.3.0] - 2024-01-24

- Add Ruby 3.3 to CI
- Add API key setting (`config.api_key`) that defaults to `ENV.fetch("OPEN_METEO_API_KEY", nil)`
- Add retry logic to the client
- Add models to forecast variables
- Add minutely_15 to forecast variables
- Add minutely_15 to forecast entity
- Add DWD Icon forecast model
- Add integration test with VCR

## [0.2.0] - 2023-11-08

- Wrap the response of OpenMeteo::Forecast to get back an OpenMeteo::Entities::Forecast entity

## [0.1.0] - 2023-11-08

- Don't validate variables, see https://github.com/open-meteo/open-meteo-website/issues/40
- Return data in the shape of understandable and manageable entities
- Change Location latitude/longitude types to coercible decimals
- Create a global configuration object
- Add OpenMeteo::Entities::Forecast::Item#weather_code_symbol

## [0.0.3] - 2023-11-03

- Use [`dry-validation`](https://github.com/dry-rb/dry-validation) to validate data classes
- Use [`dry-types`](https://github.com/dry-rb/dry-types) and [`dry-struct`](https://github.com/dry-rb/dry-struct) for data classes

## [0.0.2] - 2023-11-03

- Adjust Faraday version dependency

## [0.0.1] - 2023-11-03

- Initial release
