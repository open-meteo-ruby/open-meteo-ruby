RSpec.describe OpenMeteo::Client::Config do
  describe "#host" do
    context "when no host is set" do
      it "uses the default value" do
        expect(described_class.new.host).to eq("api.open-meteo.com")
      end

      context "when the global config is set" do
        before { OpenMeteo.configure { |config| config.host = "global-api.example.com" } }

        it "uses the global configuration" do
          expect(described_class.new.host).to eq("global-api.example.com")
        end
      end
    end

    context "when a host is set" do
      it "uses the passed in host" do
        expect(described_class.new(host: "api.example.com").host).to eq("api.example.com")
      end
    end
  end

  describe "#logger" do
    context "when no logger value is set" do
      it "uses the default value" do
        expect(described_class.new.logger.level).to eq(0)
      end

      context "when the global config is set" do
        before { OpenMeteo.configure { |config| config.logger = Logger.new($stdout, level: 1) } }

        it "uses the global configuration" do
          expect(described_class.new.logger.level).to eq(1)
        end
      end
    end

    context "when a logger is set" do
      it "uses the passed in logger" do
        expect(described_class.new(logger: Logger.new($stdout, level: 2)).logger.level).to eq(2)
      end
    end
  end

  describe "#url" do
    subject { config.url }

    let(:config) { described_class.new(host:) }
    let(:host) { "api.example.com" }

    it { is_expected.to eq("https://api.example.com") }
  end
end
