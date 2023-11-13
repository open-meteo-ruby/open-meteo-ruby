# Changelog

## [Unreleased]

- Add retry logic to the client
- Add models to forecast variables

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
