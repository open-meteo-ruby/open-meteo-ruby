RSpec.describe OpenMeteo::Entities::Forecast::Hourly do
  subject(:hourly) { described_class.new(json_body, units_json_body) }

  let(:json_body) do
    {
      "time" => %w[2023-11-07T00:00 2023-11-07T01:00],
      "weather_code" => [3, 3],
      "temperature_2m" => [26.6, 26.7],
    }
  end

  let(:units_json_body) do
    { "time" => "iso8601", "weather_code" => "wmo code", "temperature_2m" => "°C" }
  end

  it "includes a list of item entities" do
    expect(hourly.items).to all(be_instance_of(OpenMeteo::Entities::Forecast::Item))
  end

  it "includes a units entity" do
    expect(hourly.units).to be_instance_of(OpenMeteo::Entities::Forecast::Units)
  end
end
