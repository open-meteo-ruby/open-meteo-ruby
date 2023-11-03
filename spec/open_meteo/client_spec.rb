RSpec.describe OpenMeteo::Client do
  subject { described_class.new(agent:, url_builder:) }

  let(:url_builder) { instance_double OpenMeteo::Client::UrlBuilder }
  let(:agent) { Faraday }

  describe "#get" do
    let(:http_response_body) { "{}" }
    let(:faraday_response) do
      instance_double(Faraday::Response, status: 200, body: http_response_body)
    end

    let(:response) { subject.get(:forecast) }

    before do
      allow(url_builder).to receive(:build_url).with(:forecast).and_return(
        "https://api.example.com/forecast",
      )
      allow(agent).to receive(:get).and_return(faraday_response)
    end

    it "returns a successful response" do
      expect(response.status).to eq(200)
    end

    context "when there is a Faraday connection error" do
      before do
        allow(agent).to receive(:get).and_raise(
          Faraday::ConnectionFailed,
          "Couldn't resolve host name",
        )
      end

      it "raises an error" do
        expect { response }.to raise_error(
          OpenMeteo::Client::ConnectionFailed,
          "Could not connect to OpenMeteo API: Couldn't resolve host name",
        )
      end
    end

    context "when there is a Faraday timeout error" do
      before { allow(agent).to receive(:get).and_raise(Faraday::TimeoutError) }

      it "returns an error" do
        expect { response }.to raise_error(
          OpenMeteo::Client::Timeout,
          "Timeout error from the OpenMeteo API",
        )
      end
    end
  end
end
