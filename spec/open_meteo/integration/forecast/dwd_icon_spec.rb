RSpec.describe "Integration > forecast > general" do
  let(:forecast) { OpenMeteo::Forecast.new }

  describe "get" do
    subject(:response) { forecast.get(location:, variables:, model: :dwd_icon) }

    let(:location) do
      OpenMeteo::Entities::Location.new(latitude: 52.52.to_d, longitude: 13.41.to_d)
    end
    let(:variables) do
      {
        current: %i[weather_code],
        minutely_15: %i[weather_code],
        hourly: %i[weather_code],
        daily: %i[weather_code],
      }
    end

    it "returns a forecast" do
      VCR.use_cassette("integration/forecast/dwd_icon") do
        expect(response.current.item.weather_code_symbol).to eq(:overcast)
        expect(response.minutely_15.items.first.weather_code_symbol).to eq(:partly_cloudy)
        expect(response.hourly.items.first.weather_code_symbol).to eq(:partly_cloudy)
        expect(response.daily.items.first.weather_code_symbol).to eq(:rain_showers_slight)
      end
    end
  end
end
