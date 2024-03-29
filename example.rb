require "open_meteo"

OpenMeteo.configure { |config| config.logger = Logger.new("open_meteo.log") }

client = OpenMeteo::Client.new

location = OpenMeteo::Entities::Location.new(latitude: 52.52.to_d, longitude: 13.41.to_d)
variables = { current: %i[], hourly: %i[weather_code temperature_2m], daily: %i[] }
data = OpenMeteo::Forecast.new(client:).get(location:, variables:)

puts data
puts data.current
puts data.daily
puts data.hourly
puts ""
puts data.hourly&.items&.first(5)&.map(&:raw_json)
puts ""
puts "Weather code symbol: :#{data.hourly&.items&.first&.weather_code_symbol}"
