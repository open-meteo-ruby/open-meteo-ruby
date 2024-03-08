RSpec.describe OpenMeteo::Client::UrlBuilder do
  let(:builder) { described_class.new(config:) }
  let(:config) { OpenMeteo::Client::Config.new(host: "api.example.com") }

  describe "forecast url" do
    let(:endpoint) { :forecast }
    let(:expected_url) { "https://api.example.com/v1/forecast" }

    describe "#build_url" do
      subject { builder.build_url(endpoint) }

      it { is_expected.to eq(expected_url) }
    end
  end
end
