RSpec.describe OpenMeteo::Entities::Forecast::Daily do
  subject(:daily) { described_class.new(json_body, units_json_body) }

  let(:json_body) do
    {
      "time" => %w[2023-11-06 2023-11-07 2023-11-08 2023-11-09 2023-11-10 2023-11-11],
      "weather_code" => [3, 3, 2, 2, 3, 3],
      "temperature_2m_max" => [27.0, 27.0, 26.9, 27.2, 27.4, 27.1],
    }
  end

  let(:units_json_body) do
    { "time" => "iso8601", "weather_code" => "wmo code", "temperature_2m_max" => "°C" }
  end

  it "includes a list of item entities" do
    expect(daily.items).to all(be_instance_of(OpenMeteo::Entities::Forecast::Item))
  end

  it "includes a units entity" do
    expect(daily.units).to be_instance_of(OpenMeteo::Entities::Forecast::Units)
  end
end
