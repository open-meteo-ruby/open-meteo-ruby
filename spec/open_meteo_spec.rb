RSpec.describe OpenMeteo do
  it "has a version number" do
    expect(OpenMeteo::VERSION).not_to be nil
  end

  describe ".configure" do
    context "when no block is given" do
      it "raises an ArgumentError" do
        expect { described_class.configure }.to raise_error ArgumentError
      end
    end

    context "when block is given" do
      it "sets configuration" do
        described_class.configure do |config|
          config.logger = Logger.new($stdout)
          config.host = "customer-api.open-meteo.com"
          config.api_key = "123-test"
        end

        expect(described_class.configuration.host).to eq("customer-api.open-meteo.com")
        expect(described_class.configuration.api_key).to eq("123-test")
        expect(described_class.configuration.logger).to be_a(Logger)
      end
    end
  end
end
