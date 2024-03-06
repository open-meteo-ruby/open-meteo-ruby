RSpec.describe "Integration > forecast > general" do
  let(:forecast) { OpenMeteo::Forecast.new }

  describe "get" do
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

    context "when no model is given" do
      subject(:response) { forecast.get(location:, variables:) }

      it "returns a forecast" do
        VCR.use_cassette("integration/forecast/general") do
          expect(response.current.item.weather_code_symbol).to eq(:overcast)
          expect(response.minutely_15.items.first.weather_code_symbol).to eq(:partly_cloudy)
          expect(response.hourly.items.first.weather_code_symbol).to eq(:partly_cloudy)
          expect(response.daily.items.first.weather_code_symbol).to eq(:rain_showers_slight)
        end
      end
    end

    context "when one model is given" do
      subject(:response) { forecast.get(location:, variables:) }

      let(:variables) { super().merge(models: %i[best_match]) }

      it "returns a forecast without suffixes" do
        VCR.use_cassette("integration/forecast/general_one_model") do
          expect(response.current.item.weather_code_symbol).to eq(:overcast)
          expect(response.minutely_15.items.first.weather_code_symbol).to eq(:partly_cloudy)
          expect(response.hourly.items.first.weather_code_symbol).to eq(:partly_cloudy)
          expect(response.daily.items.first.weather_code_symbol).to eq(:rain_showers_slight)
        end
      end
    end

    context "when more models are given" do
      subject(:response) { forecast.get(location:, variables:) }

      let(:variables) { super().merge(models: %i[best_match gfs_seamless]) }

      it "returns a forecast with suffixes except for current" do
        VCR.use_cassette("integration/forecast/general_more_models") do
          expect(response.current.item.weather_code).to eq(3)
          expect(response.minutely_15.items.first.weather_code_best_match).to eq(2)
          expect(response.hourly.items.first.weather_code_best_match).to eq(2)
          expect(response.daily.items.first.weather_code_best_match).to eq(80)
        end
      end
    end

    context "when an API key is used" do
      subject(:response) { forecast.get(location:, variables:) }

      let(:client) { OpenMeteo::Client.new }
      let(:forecast) { OpenMeteo::Forecast.new(client:) }

      before do
        allow(OpenMeteo.configuration).to receive_messages(
          api_key: "123-test",
          host: "customer-api.open-meteo.com",
        )
      end

      it "returns a forecast" do
        VCR.use_cassette("integration/forecast/api_key") do
          expect(response.current.item.weather_code_symbol).to eq(:rain_showers_slight)
          expect(response.minutely_15.items.first.weather_code_symbol).to eq(:rain_slight)
          expect(response.hourly.items.first.weather_code_symbol).to eq(:rain_slight)
          expect(response.daily.items.first.weather_code_symbol).to eq(:rain_showers_slight)
        end
      end
    end
  end
end
