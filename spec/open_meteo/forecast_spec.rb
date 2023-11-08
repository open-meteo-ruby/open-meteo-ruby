RSpec.describe OpenMeteo::Forecast do
  subject(:forecast) { described_class.new(client:) }

  let(:client) { instance_double(OpenMeteo::Client) }
  let(:faraday_response) { instance_double(Faraday::Response) }

  describe "#get" do
    subject(:forecast_get) { forecast.get(location:, variables:, model:) }

    let(:location) { OpenMeteo::Entities::Location.new(longitude: 1.1.to_d, latitude: 2.2.to_d) }
    let(:variables) { {} }
    let(:model) { :general }

    context "when the model does not exist" do
      let(:model) { :unknown_model }

      it "raises an error" do
        expect { forecast_get }.to raise_error(OpenMeteo::Forecast::ForecastModelNotImplemented)
      end
    end

    context "when the location is not an OpenMeteo::Entities::Location" do
      let(:location) { :something }

      it "raises an error" do
        expect { forecast_get }.to raise_error(OpenMeteo::Forecast::WrongLocationType)
      end
    end

    context "when the location and the varialbes are valid" do
      let(:variables) { { hourly: %i[apparent_temperature], daily: %i[apparent_temperature_max] } }

      before do
        allow(client).to receive(:get).with(
          :forecast,
          longitude: 1.1,
          latitude: 2.2,
          hourly: "apparent_temperature",
          daily: "apparent_temperature_max",
        ).and_return(faraday_response)
      end

      it "calls the client" do
        expect(forecast_get).to eq(faraday_response)
      end
    end
  end
end
