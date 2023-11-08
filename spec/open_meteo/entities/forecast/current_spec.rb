RSpec.describe OpenMeteo::Entities::Forecast::Current do
  subject(:current) { described_class.new(json_body, units_json_body) }

  let(:json_body) do
    {
      "time" => "2023-11-07T13:00",
      "interval" => 900,
      "weather_code" => 2,
      "temperature_2m" => 27.0,
    }
  end

  let(:units_json_body) do
    {
      "time" => "2023-11-07T13:00",
      "interval" => 900,
      "weather_code" => 2,
      "temperature_2m" => 27.0,
    }
  end

  it "includes an item entity" do
    expect(current.item).to be_instance_of(OpenMeteo::Entities::Forecast::Item)
  end

  it "includes a units entity" do
    expect(current.units).to be_instance_of(OpenMeteo::Entities::Forecast::Units)
  end
end
