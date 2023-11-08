require "open_meteo"

OpenMeteo.configure { |config| config.logger = Logger.new("open_meteo.log") }

client = OpenMeteo::Client.new(agent: Faraday.new { |conn| conn.response :logger })

location = OpenMeteo::Entities::Location.new(latitude: 52.52.to_d, longitude: 13.41.to_d)
variables = { current: %i[], hourly: %i[weathercode temperature_2m], daily: %i[] }
forecast_response = OpenMeteo::Forecast.new(client:).get(location:, variables:)

data = OpenMeteo::ResponseWrapper.new.wrap(forecast_response, entity: OpenMeteo::Entities::Forecast)

puts "Status: #{forecast_response.status}"
puts data
puts data.current
puts data.daily
puts data.hourly
puts ""
puts data.hourly&.items&.first(5)
puts ""
puts "Weathercode symbol: :#{data.hourly&.items&.first&.weathercode_symbol}"
