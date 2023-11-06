require "open_meteo"

client = OpenMeteo::Client.new(agent: Faraday.new { |conn| conn.response :logger })

location = OpenMeteo::Entities::Location.new(longitude: 52.52, latitude: 13.41)
variables = { current: %i[], hourly: %i[], daily: %i[weather_code temperature_2m_max] }
forecast_response = OpenMeteo::Forecast.new(client:).get(location:, variables:)

data = OpenMeteo::ResponseWrapper.new.wrap(forecast_response)

puts "Status: #{forecast_response.status}"
puts data
