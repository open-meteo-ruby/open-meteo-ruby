RSpec.describe OpenMeteo::Location do
  let(:location) { described_class.new(latitude:, longitude:) }
  let(:latitude) { nil }
  let(:longitude) { nil }

  describe "#to_get_params" do
    subject { location.to_get_params }

    let(:latitude) { 1.1 }
    let(:longitude) { 2.2 }

    it { is_expected.to eq({ latitude: 1.1, longitude: 2.2 }) }
  end
end
