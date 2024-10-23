RSpec.describe OpenMeteo::Entities::Location do
  let(:location) { described_class.new(latitude:, longitude:) }
  let(:latitude) { nil }
  let(:longitude) { nil }

  describe "#to_query_params" do
    subject { location.to_query_params }

    let(:latitude) { 1.1.to_d }
    let(:longitude) { 2.2.to_d }

    it { is_expected.to eq({ latitude: 1.1, longitude: 2.2 }) }
  end

  describe "#validate!" do
    context "when the latitude and longitude are valid" do
      let(:latitude) { 1.1.to_d }
      let(:longitude) { 2.2.to_d }

      it "does not raise an error" do
        expect { location.validate! }.not_to raise_error
      end
    end

    context "when the latitude is higher than 90" do
      let(:latitude) { 91.to_d }
      let(:longitude) { 2.2.to_d }

      it "raises an error" do
        expect { location.validate! }.to raise_error(
          OpenMeteo::Entities::Contracts::ApplicationContract::ValidationError,
        )
      end
    end

    context "when the latitude is lower than -90" do
      let(:latitude) { -91.to_d }
      let(:longitude) { 2.2.to_d }

      it "raises an error" do
        expect { location.validate! }.to raise_error(
          OpenMeteo::Entities::Contracts::ApplicationContract::ValidationError,
        )
      end
    end

    context "when the longitude is higher than 180" do
      let(:latitude) { 1.1.to_d }
      let(:longitude) { 181.to_d }

      it "raises an error" do
        expect { location.validate! }.to raise_error(
          OpenMeteo::Entities::Contracts::ApplicationContract::ValidationError,
        )
      end
    end

    context "when the longitude is lower than -180" do
      let(:latitude) { 1.1.to_d }
      let(:longitude) { -181.to_d }

      it "raises an error" do
        expect { location.validate! }.to raise_error(
          OpenMeteo::Entities::Contracts::ApplicationContract::ValidationError,
        )
      end
    end
  end
end
