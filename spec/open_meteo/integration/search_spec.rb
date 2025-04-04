RSpec.describe "Integration > Search" do
  let(:search) { OpenMeteo::Search.new }
  let(:variables) { {} }

  describe "#get" do
    let(:name) { "Hollywood" }

    context "when a default amount(10) of responses is requested" do
      subject(:response) { search.get(name:, variables:) }

      it "returns search results" do
        VCR.use_cassette("integration/search/hollywood") do
          expect(response.results.first.name).to eq("Hollywood")
          expect(response.results.first.postcodes.length).to eq(12)
          expect(response.results.length).to eq(10)
        end
      end
    end

    context "when a larger amount of responses is requested" do
      subject(:response) { search.get(name:, variables:) }

      let(:variables) { { count: 20 } }

      it "More search results with a larger count" do
        VCR.use_cassette("integration/search/hollywood_20") do
          expect(response.results.first.name).to eq("Hollywood")
          expect(response.results.first.postcodes.length).to eq(12)
          expect(response.results.length).to eq(20)
        end
      end
    end
  end
end
