RSpec.describe OpenMeteo::ResponseWrapper do
  subject(:wrapper) { described_class.new }

  let(:response) { instance_double(Faraday::Response, status:, body:) }

  describe "#wrap" do
    let(:entity) { OpenMeteo::Entities::Forecast }

    context "when everything is ok" do
      let(:status) { 200 }

      context "when current data" do
        let(:body) { <<~JSON }
        {
          "latitude": 13.375,
          "longitude": 52.5,
          "generationtime_ms": 0.01895427703857422,
          "utc_offset_seconds": 0,
          "timezone": "GMT",
          "timezone_abbreviation": "GMT",
          "elevation": 0.0,
          "current_units": {
            "time": "iso8601",
            "interval": "seconds",
            "weather_code": "wmo code",
            "temperature_2m": "°C"
          },
          "current": {
            "time": "2023-11-07T13:00",
            "interval": 900,
            "weather_code": 2,
            "temperature_2m": 27.0
          }
        }
        JSON

        it "responds with the data" do
          data = wrapper.wrap(response, entity:)

          expect(data.daily).to be(nil)
          expect(data.hourly).to be(nil)

          expect(data).to be_an_instance_of(OpenMeteo::Entities::Forecast)
          expect(data.current).to be_an_instance_of(OpenMeteo::Entities::Forecast::Current)
          expect(data.current.units).to be_an_instance_of(OpenMeteo::Entities::Forecast::Units)
          expect(data.current.item).to be_an_instance_of(OpenMeteo::Entities::Forecast::Item)
          expect(data.attributes).to eq(JSON.parse(body).keys)
        end
      end

      context "when hourly data" do
        let(:body) { <<~JSON }
        {
          "latitude": 13.375,
          "longitude": 52.5,
          "generationtime_ms": 0.024080276489257812,
          "utc_offset_seconds": 0,
          "timezone": "GMT",
          "timezone_abbreviation": "GMT",
          "elevation": 0.0,
          "hourly_units": {"time": "iso8601", "weather_code": "wmo code", "temperature_2m": "°C"},
          "hourly": {
            "time": ["2023-11-07T00:00", "2023-11-07T01:00", "2023-11-07T02:00", "2023-11-07T03:00", "2023-11-07T04:00", "2023-11-07T05:00", "2023-11-07T06:00", "2023-11-07T07:00", "2023-11-07T08:00", "2023-11-07T09:00", "2023-11-07T10:00", "2023-11-07T11:00", "2023-11-07T12:00", "2023-11-07T13:00", "2023-11-07T14:00", "2023-11-07T15:00", "2023-11-07T16:00", "2023-11-07T17:00", "2023-11-07T18:00", "2023-11-07T19:00", "2023-11-07T20:00", "2023-11-07T21:00", "2023-11-07T22:00", "2023-11-07T23:00", "2023-11-08T00:00", "2023-11-08T01:00", "2023-11-08T02:00", "2023-11-08T03:00", "2023-11-08T04:00", "2023-11-08T05:00", "2023-11-08T06:00", "2023-11-08T07:00", "2023-11-08T08:00", "2023-11-08T09:00", "2023-11-08T10:00", "2023-11-08T11:00", "2023-11-08T12:00", "2023-11-08T13:00", "2023-11-08T14:00", "2023-11-08T15:00", "2023-11-08T16:00", "2023-11-08T17:00", "2023-11-08T18:00", "2023-11-08T19:00", "2023-11-08T20:00", "2023-11-08T21:00", "2023-11-08T22:00", "2023-11-08T23:00", "2023-11-09T00:00", "2023-11-09T01:00", "2023-11-09T02:00", "2023-11-09T03:00", "2023-11-09T04:00", "2023-11-09T05:00", "2023-11-09T06:00", "2023-11-09T07:00", "2023-11-09T08:00", "2023-11-09T09:00", "2023-11-09T10:00", "2023-11-09T11:00", "2023-11-09T12:00", "2023-11-09T13:00", "2023-11-09T14:00", "2023-11-09T15:00", "2023-11-09T16:00", "2023-11-09T17:00", "2023-11-09T18:00", "2023-11-09T19:00", "2023-11-09T20:00", "2023-11-09T21:00", "2023-11-09T22:00", "2023-11-09T23:00", "2023-11-10T00:00", "2023-11-10T01:00", "2023-11-10T02:00", "2023-11-10T03:00", "2023-11-10T04:00", "2023-11-10T05:00", "2023-11-10T06:00", "2023-11-10T07:00", "2023-11-10T08:00", "2023-11-10T09:00", "2023-11-10T10:00", "2023-11-10T11:00", "2023-11-10T12:00", "2023-11-10T13:00", "2023-11-10T14:00", "2023-11-10T15:00", "2023-11-10T16:00", "2023-11-10T17:00", "2023-11-10T18:00", "2023-11-10T19:00", "2023-11-10T20:00", "2023-11-10T21:00", "2023-11-10T22:00", "2023-11-10T23:00", "2023-11-11T00:00", "2023-11-11T01:00", "2023-11-11T02:00", "2023-11-11T03:00", "2023-11-11T04:00", "2023-11-11T05:00", "2023-11-11T06:00", "2023-11-11T07:00", "2023-11-11T08:00", "2023-11-11T09:00", "2023-11-11T10:00", "2023-11-11T11:00", "2023-11-11T12:00", "2023-11-11T13:00", "2023-11-11T14:00", "2023-11-11T15:00", "2023-11-11T16:00", "2023-11-11T17:00", "2023-11-11T18:00", "2023-11-11T19:00", "2023-11-11T20:00", "2023-11-11T21:00", "2023-11-11T22:00", "2023-11-11T23:00", "2023-11-12T00:00", "2023-11-12T01:00", "2023-11-12T02:00", "2023-11-12T03:00", "2023-11-12T04:00", "2023-11-12T05:00", "2023-11-12T06:00", "2023-11-12T07:00", "2023-11-12T08:00", "2023-11-12T09:00", "2023-11-12T10:00", "2023-11-12T11:00", "2023-11-12T12:00", "2023-11-12T13:00", "2023-11-12T14:00", "2023-11-12T15:00", "2023-11-12T16:00", "2023-11-12T17:00", "2023-11-12T18:00", "2023-11-12T19:00", "2023-11-12T20:00", "2023-11-12T21:00", "2023-11-12T22:00", "2023-11-12T23:00", "2023-11-13T00:00", "2023-11-13T01:00", "2023-11-13T02:00", "2023-11-13T03:00", "2023-11-13T04:00", "2023-11-13T05:00", "2023-11-13T06:00", "2023-11-13T07:00", "2023-11-13T08:00", "2023-11-13T09:00", "2023-11-13T10:00", "2023-11-13T11:00", "2023-11-13T12:00", "2023-11-13T13:00", "2023-11-13T14:00", "2023-11-13T15:00", "2023-11-13T16:00", "2023-11-13T17:00", "2023-11-13T18:00", "2023-11-13T19:00", "2023-11-13T20:00", "2023-11-13T21:00", "2023-11-13T22:00", "2023-11-13T23:00"],
            "weather_code": [3, 3, 3, 2, 2, 1, 1, 3, 3, 2, 2, 2, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 3, 3, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 0, 0, 0, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 2, 2, 2, 3, 3, 3, 2, 2, 2, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            "temperature_2m": [26.6, 26.7, 26.9, 27.0, 27.2, 27.3, 27.0, 27.1, 27.1, 27.1, 27.1, 27.1, 27.0, 27.0, 26.9, 27.0, 27.2, 27.1, 27.0, 27.0, 27.0, 26.9, 26.7, 26.6, 26.8, 26.8, 26.8, 26.8, 26.8, 26.9, 26.9, 26.8, 26.7, 26.8, 26.9, 27.0, 27.0, 27.1, 27.1, 27.1, 27.2, 27.3, 27.2, 27.3, 27.5, 27.5, 27.4, 27.4, 27.3, 27.2, 27.1, 27.1, 27.2, 27.3, 27.4, 27.4, 27.5, 27.5, 27.5, 27.5, 27.5, 27.4, 27.3, 27.2, 27.2, 27.2, 27.2, 27.2, 27.2, 27.2, 27.2, 27.0, 26.9, 26.9, 26.8, 26.9, 27.0, 27.0, 27.0, 27.0, 27.0, 27.2, 27.1, 27.2, 27.4, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.4, 27.3, 27.2, 27.2, 27.1, 27.2, 27.2, 27.3, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.5, 27.5, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.4, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.6, 27.6, 27.7, 27.7, 27.7, 27.7, 27.8, 27.8, 27.8, 27.8, 27.6, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 27.6, 27.6, 27.6, 27.6, 27.6, 27.6, 27.6, 27.6, 27.7, 27.8, 27.8, 27.8, 27.8, 27.8, 27.8, 27.8, 27.7, 27.6, 27.6, 27.5, 27.5]
          }
        }
        JSON

        it "responds with the data" do
          data = wrapper.wrap(response, entity:)

          expect(data.current).to be(nil)
          expect(data.daily).to be(nil)

          expect(data).to be_an_instance_of(OpenMeteo::Entities::Forecast)
          expect(data.hourly).to be_an_instance_of(OpenMeteo::Entities::Forecast::Hourly)
          expect(data.hourly.units).to be_an_instance_of(OpenMeteo::Entities::Forecast::Units)
          expect(data.hourly.items).to be_an_instance_of(Array)
          expect(data.hourly.items[0]).to be_an_instance_of(OpenMeteo::Entities::Forecast::Item)
          expect(data.attributes).to eq(JSON.parse(body).keys)
        end
      end

      context "when daily data" do
        let(:body) { <<~JSON }
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

        it "responds with the data" do
          data = wrapper.wrap(response, entity:)

          expect(data.current).to be(nil)
          expect(data.hourly).to be(nil)

          expect(data).to be_an_instance_of(OpenMeteo::Entities::Forecast)
          expect(data.daily).to be_an_instance_of(OpenMeteo::Entities::Forecast::Daily)
          expect(data.daily.units).to be_an_instance_of(OpenMeteo::Entities::Forecast::Units)
          expect(data.daily.items).to be_an_instance_of(Array)
          expect(data.daily.items[0]).to be_an_instance_of(OpenMeteo::Entities::Forecast::Item)
          expect(data.attributes).to eq(JSON.parse(body).keys)
        end
      end
    end

    context "when there is an error" do
      context "when open meteo responds with an error" do
        let(:status) { 400 }
        let(:body) { <<~JSON }
        {
          "error": true,
          "reason": "Data corrupted at path ''. Cannot initialize ForecastVariableDaily from invalid String value some_attribute."
        }
        JSON

        it "raises an error" do
          expect { wrapper.wrap(response, entity:) }.to raise_error(
            OpenMeteo::Errors::ResponseError,
          )
        end

        context "when the error is false" do
          let(:body) { <<~JSON }
          {
            "error": false,
            "reason": "Data corrupted at path ''. Cannot initialize ForecastVariableDaily from invalid String value some_attribute."
          }
          JSON

          it "raises an error" do
            expect { wrapper.wrap(response, entity:) }.to raise_error(
              OpenMeteo::Errors::ResponseError,
              "",
            )
          end
        end
      end

      context "when body is nil" do
        let(:status) { 200 }
        let(:body) { nil }

        it "raises an error" do
          expect { wrapper.wrap(response, entity:) }.to raise_error(
            OpenMeteo::Errors::ResponseError,
          )
        end
      end

      context "when body is not json" do
        let(:status) { 200 }
        let(:body) { "this is not a json" }

        it "raises an error" do
          expect { wrapper.wrap(response, entity:) }.to raise_error(
            OpenMeteo::Errors::ResponseError,
          )
        end
      end
    end
  end
end
