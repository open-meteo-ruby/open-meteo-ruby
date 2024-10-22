RSpec.describe OpenMeteo::Forecast do
  subject(:forecast) { described_class.new(client:, response_wrapper:) }

  let(:config) { instance_double(OpenMeteo::Client::Config) }
  let(:client) { instance_double(OpenMeteo::Client, config:) }
  let(:response_wrapper) { instance_double(OpenMeteo::ResponseWrapper) }
  let(:faraday_response) { instance_double(Faraday::Response) }
  let(:forecast_entity) { instance_double(OpenMeteo::Entities::Forecast) }

  it "uses same configuration class for all dependent classes" do
    forecast = described_class.new(config:)

    client = forecast.instance_variable_get(:@client)
    expect(client.config).to eq(config)

    wrapper = forecast.instance_variable_get(:@response_wrapper)
    expect(wrapper.config).to eq(config)
  end

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

    context "when the location and the variables are valid" do
      let(:variables) { { hourly: %i[apparent_temperature], daily: %i[apparent_temperature_max] } }
      let(:query_params) do
        {
          longitude: 1.1,
          latitude: 2.2,
          hourly: "apparent_temperature",
          daily: "apparent_temperature_max",
        }
      end

      before do
        allow(client).to receive(:get).with(:forecast, query_params:).and_return(faraday_response)
        allow(response_wrapper).to receive(:wrap).with(
          faraday_response,
          entity: OpenMeteo::Entities::Forecast,
        ).and_return(forecast_entity)
      end

      it "calls the client" do
        expect(forecast_get).to eq(forecast_entity)
      end
    end
  end
end
