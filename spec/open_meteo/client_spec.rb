RSpec.describe OpenMeteo::Client do
  let(:client) { described_class.new(agent:, url_builder:, config:) }

  let(:url_builder) { instance_double OpenMeteo::Client::UrlBuilder }
  let(:agent) { OpenMeteo::FaradayConnection.new }
  let(:connection) { agent.connect }
  let(:config) { OpenMeteo::Client::Config.new }

  it "uses same configuration class for all dependent classes" do
    client = described_class.new(config:)
    expect(client.config).to eq(config)

    url_builder = client.instance_variable_get(:@url_builder)
    expect(url_builder.config).to eq(config)

    agent = client.instance_variable_get(:@agent)
    expect(agent.config).to eq(config)
  end

  describe "#agent" do
    context "when the agent is not passed in sets the default" do
      subject { described_class.new.agent }

      it { is_expected.to be_instance_of(OpenMeteo::FaradayConnection) }
    end
  end

  describe "#get" do
    subject(:response) { client.get(:forecast) }

    let(:http_response_body) { "{}" }
    let(:request) { instance_double(Faraday::Request, :params= => true, :url => true) }
    let(:faraday_response) do
      instance_double(Faraday::Response, status: 200, body: http_response_body)
    end

    before do
      allow(url_builder).to receive(:build_url).with(:forecast, {}).and_return(
        "https://api.example.com/forecast",
      )

      allow(agent).to receive(:connect).and_return(connection)
      allow(connection).to receive(:get).and_yield(request).and_return(faraday_response)
    end

    it "returns a successful response" do
      expect(response.status).to eq(200)
    end

    context "when an api key is set" do
      before { allow(config).to receive(:api_key).and_return("123") }

      it "adds the api key to the request" do
        response

        expect(request).to have_received(:params=).with({ apikey: "123" })
      end
    end

    context "when there is a Faraday connection error" do
      before do
        allow(connection).to receive(:get).and_raise(
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
      before { allow(connection).to receive(:get).and_raise(Faraday::TimeoutError) }

      it "returns an error" do
        expect { response }.to raise_error(
          OpenMeteo::Client::Timeout,
          "Timeout error from the OpenMeteo API",
        )
      end
    end
  end
end
