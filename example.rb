require "open_meteo"

client = OpenMeteo::Client.new(agent: Faraday.new { |conn| conn.response :logger })

location = OpenMeteo::Entities::Location.new(longitude: 52.52, latitude: 13.41)
variables = { current: %i[weathercode], hourly: %i[], daily: %i[] }
forecast_response = OpenMeteo::Forecast.new(client:).get(location:, variables:)

puts "Status: #{forecast_response.status}"
puts forecast_response.body
