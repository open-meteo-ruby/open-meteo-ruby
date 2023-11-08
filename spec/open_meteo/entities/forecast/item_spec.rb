RSpec.describe OpenMeteo::Entities::Forecast::Item do
  subject(:item) { described_class.new(json_body) }

  let(:json_body) do
    {
      "time" => "2023-11-07T13:00",
      "interval" => 900,
      "weather_code" => 2,
      "temperature_2m" => 27.0,
    }
  end

  it "respond to attributes" do
    expect(item.attributes).to eq(%w[time interval weather_code temperature_2m])
  end

  it "respond to each attribute method" do
    expect(item.time).to eq("2023-11-07T13:00")
    expect(item.interval).to eq(900)
    expect(item.weather_code).to eq(2)
    expect(item.temperature_2m).to eq(27.0)
  end

  it "responds correctly to missing" do
    expect(item.respond_to?(:weather_code)).to be(true)
    expect(item.respond_to?(:whatever)).to be(false)
  end

  it "raises for unexistent attributes" do
    expect { item.whatever }.to raise_error(NoMethodError)
  end
end
