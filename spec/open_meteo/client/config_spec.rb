RSpec.describe OpenMeteo::Client::Config do
  let(:config) { described_class.new(host:) }
  let(:host) { "api.example.com" }

  describe "#host" do
    subject { config.host }

    it { is_expected.to eq("api.example.com") }
  end

  describe "#url" do
    subject { config.url }

    it { is_expected.to eq("https://api.example.com") }
  end
end
