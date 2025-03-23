RSpec.describe OpenMeteo::Search do
  subject(:search_get) { described_class.new(client:, response_wrapper:) }

  let(:config) { instance_double(OpenMeteo::Client::Config) }
  let(:client) { instance_double(OpenMeteo::Client, config:) }
  let(:response_wrapper) { instance_double(OpenMeteo::ResponseWrapper) }
  let(:faraday_response) { instance_double(Faraday::Response) }
  let(:search_entity) { instance_double(OpenMeteo::Entities::Search) }

  it "uses same configuration class for all dependent classes" do
    search = described_class.new(config:)

    client = search.instance_variable_get(:@client)
    expect(client.config).to eq(config)

    wrapper = search.instance_variable_get(:@response_wrapper)
    expect(wrapper.config).to eq(config)
  end

  describe "#get" do
    subject(:search_get) { search.get(name:, variables:) }

    let(:name) { "Minneapolis" }
    let(:variables) { {} }

    context "when it has as count of 20" do
      let(:variables) { {count: 20, language: "es" } }
      let(:query_params) do
        {
          count: 20,
          language: "es",
          name: "Minneapolis",
        }
      end

      before do
        allow(client).to receive(:get).with(:search_get, query_params:).and_return(faraday_response)
        allow(response_wrapper).to receive(:wrap).with(
          faraday_response,
          entity: OpenMeteo::Entities::Search,
          ).and_return(search_entity)
      end

      it "calls the client" do
        expect(search_get).to eq(search_entity)
      end
    end
  end
end
