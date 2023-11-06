RSpec.describe OpenMeteo::ResponseWrapper do
  subject(:wrapper) { described_class.new }

  let(:response) { instance_double(Faraday::Response, status:, body:) }

  describe "#wrap" do
    context "when everything is ok" do
      let(:status) { 200 }
      let(:body) do
        <<~JSON
          {
            "latitude": 13.375,
            "longitude": 52.5,
            "generationtime_ms": 0.0209808349609375,
            "utc_offset_seconds": 0,
            "timezone": "GMT",
            "timezone_abbreviation": "GMT",
            "elevation": 0.0,
            "daily_units": {
              "time": "iso8601",
              "weather_code": "wmo code",
              "temperature_2m_max": "°C"
            },
            "daily": {
              "time": ["2023-11-06", "2023-11-07", "2023-11-08", "2023-11-09", "2023-11-10", "2023-11-11", "2023-11-12"],
             "weather_code": [3, 3, 2, 2, 3, 3, 2],
             "temperature_2m_max": [27.0, 27.0, 26.9, 27.2, 27.4, 27.1, 27.1]
            }
          }
        JSON
      end

      it "responds with the data" do
        expect(wrapper.wrap(response)).to eq(JSON.parse(body))
      end
    end

    context "when there is an error" do
      let(:status) { 400 }
      let(:body) do
        <<~JSON
          {
            "error": true,
            "reason": "Data corrupted at path ''. Cannot initialize ForecastVariableDaily from invalid String value weatherx_code."
          }
        JSON
      end

      it "raises an error" do
        expect { wrapper.wrap(response) }.to raise_error(OpenMeteo::Errors::ResponseError)
      end
    end
  end
end
