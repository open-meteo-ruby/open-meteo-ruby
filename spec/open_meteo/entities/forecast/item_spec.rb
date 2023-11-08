RSpec.describe OpenMeteo::Entities::Forecast::Item do
  subject(:item) { described_class.new(json_body) }

  let(:json_body) do
    {
      "time" => "2023-11-07T13:00",
      "interval" => 900,
      "temperature_2m" => 27.0,
      "weathercode" => weathercode,
    }
  end
  let(:weathercode) { 0 }

  it "respond to attributes" do
    expect(item.attributes).to eq(%w[time interval temperature_2m weathercode])
  end

  it "respond to each attribute method" do
    expect(item.time).to eq("2023-11-07T13:00")
    expect(item.interval).to eq(900)
    expect(item.temperature_2m).to eq(27.0)
  end

  it "responds correctly to missing" do
    expect(item.respond_to?(:temperature_2m)).to be(true)
    expect(item.respond_to?(:whatever)).to be(false)
  end

  it "raises for unexistent attributes" do
    expect { item.whatever }.to raise_error(NoMethodError)
  end

  describe "#weathercode_symbol" do
    context "when the weahtercode is nil" do
      let(:weathercode) { nil }

      it "returns nil" do
        expect(item.weathercode_symbol).to be nil
      end
    end

    context "when the weathercode exists" do
      let(:weathercode) { 0 }

      it "returns the corresponding symvol" do
        expect(item.weathercode_symbol).to eq(:clear_sky)
      end
    end

    context "when the weathercode doesn't exist" do
      let(:weathercode) { 100 }

      it "raises an error" do
        expect { item.weathercode_symbol }.to raise_error described_class::UnknownWeathercode
      end
    end
  end
end
