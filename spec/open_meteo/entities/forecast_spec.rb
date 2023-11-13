RSpec.describe OpenMeteo::Entities::Forecast do
  subject(:forecast) { described_class.new(json_body) }

  context "when current data" do
    let(:json_body) do
      {
        "latitude" => 13.375,
        "longitude" => 52.5,
        "generationtime_ms" => 0.01895427703857422,
        "utc_offset_seconds" => 0,
        "timezone" => "GMT",
        "timezone_abbreviation" => "GMT",
        "elevation" => 0.0,
        "current_units" => {
          "time" => "iso8601",
          "interval" => "seconds",
          "weather_code" => "wmo code",
          "temperature_2m" => "°C",
        },
        "current" => {
          "time" => "2023-11-07T13:00",
          "interval" => 900,
          "weather_code" => 2,
          "temperature_2m" => 27.0,
        },
      }
    end

    it "includes current data" do
      expect(forecast.current).to be_instance_of(OpenMeteo::Entities::Forecast::Current)
      expect(forecast.minutely_15).to be(nil)
      expect(forecast.hourly).to be(nil)
      expect(forecast.daily).to be(nil)
    end

    it "respond to attributes" do
      attributes = %w[
        latitude
        longitude
        generationtime_ms
        utc_offset_seconds
        timezone
        timezone_abbreviation
        elevation
        current_units
        current
      ]
      expect(forecast.attributes).to eq(attributes)
    end
  end

  context "when minutely_15 data" do
    let(:json_body) do
      {
        "latitude" => 13.375,
        "longitude" => 52.5,
        "generationtime_ms" => 0.024080276489257812,
        "utc_offset_seconds" => 0,
        "timezone" => "GMT",
        "timezone_abbreviation" => "GMT",
        "elevation" => 0.0,
        "hourly_units" => {
          "time" => "iso8601",
          "weather_code" => "wmo code",
          "temperature_2m" => "°C",
        },
        "minutely_15" => {
          "time" => %w[2023-11-07T00:00 2023-11-07T01:00],
          "weather_code" => [3, 3],
          "temperature_2m" => [26.6, 26.7],
        },
      }
    end

    it "includes minutely_15 data" do
      expect(forecast.current).to be(nil)
      expect(forecast.minutely_15).to be_instance_of(OpenMeteo::Entities::Forecast::Minutely15)
      expect(forecast.hourly).to be(nil)
      expect(forecast.daily).to be(nil)
    end
  end

  context "when hourly data" do
    let(:json_body) do
      {
        "latitude" => 13.375,
        "longitude" => 52.5,
        "generationtime_ms" => 0.024080276489257812,
        "utc_offset_seconds" => 0,
        "timezone" => "GMT",
        "timezone_abbreviation" => "GMT",
        "elevation" => 0.0,
        "hourly_units" => {
          "time" => "iso8601",
          "weather_code" => "wmo code",
          "temperature_2m" => "°C",
        },
        "hourly" => {
          "time" => %w[2023-11-07T00:00 2023-11-07T01:00],
          "weather_code" => [3, 3],
          "temperature_2m" => [26.6, 26.7],
        },
      }
    end

    it "includes hourly data" do
      expect(forecast.current).to be(nil)
      expect(forecast.minutely_15).to be(nil)
      expect(forecast.hourly).to be_instance_of(OpenMeteo::Entities::Forecast::Hourly)
      expect(forecast.daily).to be(nil)
    end

    it "respond to attributes" do
      attributes = %w[
        latitude
        longitude
        generationtime_ms
        utc_offset_seconds
        timezone
        timezone_abbreviation
        elevation
        hourly_units
        hourly
      ]
      expect(forecast.attributes).to eq(attributes)
    end
  end

  context "when daily data" do
    let(:json_body) do
      {
        "latitude" => 13.375,
        "longitude" => 52.5,
        "generationtime_ms" => 0.0209808349609375,
        "utc_offset_seconds" => 0,
        "timezone" => "GMT",
        "timezone_abbreviation" => "GMT",
        "elevation" => 0.0,
        "daily_units" => {
          "time" => "iso8601",
          "weather_code" => "wmo code",
          "temperature_2m_max" => "°C",
        },
        "daily" => {
          "time" => %w[
            2023-11-06
            2023-11-07
            2023-11-08
            2023-11-09
            2023-11-10
            2023-11-11
            2023-11-12
          ],
          "weather_code" => [3, 3, 2, 2, 3, 3, 2],
          "temperature_2m_max" => [27.0, 27.0, 26.9, 27.2, 27.4, 27.1, 27.1],
        },
      }
    end

    it "includes hourly data" do
      expect(forecast.current).to be(nil)
      expect(forecast.current).to be(nil)
      expect(forecast.hourly).to be(nil)
      expect(forecast.daily).to be_instance_of(OpenMeteo::Entities::Forecast::Daily)
    end

    it "respond to attributes" do
      attributes = %w[
        latitude
        longitude
        generationtime_ms
        utc_offset_seconds
        timezone
        timezone_abbreviation
        elevation
        daily_units
        daily
      ]
      expect(forecast.attributes).to eq(attributes)
    end
  end
end
