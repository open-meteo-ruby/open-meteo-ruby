RSpec.describe "Integration > configuration > logging" do
  subject(:response) { forecast.get(location:, variables:) }

  let(:logger_stream) { StringIO.new }
  let(:config) { OpenMeteo::Client::Config.new(logger: Logger.new(logger_stream))}
  let(:client) { OpenMeteo::Client.new(config:) }
  let(:forecast) { OpenMeteo::Forecast.new(client:) }

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

  it "writes to the configured logger when making requests" do
    expect { VCR.use_cassette("integration/forecast/general") { response } }
      .to change { logger_stream.tap(&:rewind).read }
      .from(be_empty)
      .to(include("Faraday"))
  end
end
