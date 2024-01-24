RSpec.describe OpenMeteo::Client::Config do
  describe "#api_key" do
    subject { described_class.new.api_key }

    context "when no api_key is set" do
      context "when the environment variable is not set" do
        it { is_expected.to be nil }
      end

      context "when the environment variable is set" do
        before { stub_const("ENV", ENV.to_hash.merge("OPEN_METEO_API_KEY" => "secret-key")) }

        it { is_expected.to eq "secret-key" }
      end

      context "when the global config is set" do
        before { OpenMeteo.configure { |config| config.api_key = "global-api-key" } }

        after do
          OpenMeteo.configure do |config|
            config.api_key = -> { ENV.fetch("OPEN_METEO_API_KEY", nil) }
          end
        end

        it { is_expected.to eq "global-api-key" }
      end
    end

    context "when an api_key is set" do
      subject { described_class.new(api_key: "other-api-key").api_key }

      it { is_expected.to eq "other-api-key" }
    end
  end

  describe "#host" do
    context "when no host is set" do
      it "uses the default value" do
        expect(described_class.new.host).to eq("api.open-meteo.com")
      end

      context "when the global config is set" do
        before { OpenMeteo.configure { |config| config.host = "global-api.example.com" } }
        after { OpenMeteo.configure { |config| config.host = "api.open-meteo.com" } }

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
