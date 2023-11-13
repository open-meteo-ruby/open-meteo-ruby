RSpec.describe OpenMeteo::Entities::Forecast::Units do
  subject(:units) { described_class.new(json_body) }

  let(:json_body) do
    { "time" => "iso8601", "weather_code" => "wmo code", "temperature_2m_max" => "°C" }
  end

  it "respond to time" do
    expect(units.time).to eq("iso8601")
  end

  it "respond to other existent attributes" do
    expect(units.weather_code).to eq("wmo code")
    expect(units.temperature_2m_max).to eq("°C")
  end

  it "responds correctly to missing" do
    expect(units.respond_to?(:weather_code)).to be(true)
    expect(units.respond_to?(:whatever)).to be(false)
  end

  it "raises for un-existent attributes" do
    expect { units.whatever }.to raise_error(NoMethodError)
  end
end
