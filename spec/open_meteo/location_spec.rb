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

  describe "#validate!" do
    context "when the latitude and longitude are valid" do
      let(:latitude) { 1.1 }
      let(:longitude) { 2.2 }

      it "does not raise an error" do
        expect { location.validate! }.not_to raise_error
      end
    end

    context "when the latitude is higher than 90" do
      let(:latitude) { 91 }
      let(:longitude) { 2.2 }

      it "raises an error" do
        expect { location.validate! }.to raise_error(Dry::Struct::Error)
      end
    end

    context "when the latitude is lower than -90" do
      let(:latitude) { -91 }
      let(:longitude) { 2.2 }

      it "raises an error" do
        expect { location.validate! }.to raise_error(Dry::Struct::Error)
      end
    end

    context "when the longitude is higher than 180" do
      let(:latitude) { 1.1 }
      let(:longitude) { 181 }

      it "raises an error" do
        expect { location.validate! }.to raise_error(Dry::Struct::Error)
      end
    end

    context "when the longitude is lower than -180" do
      let(:latitude) { 1.1 }
      let(:longitude) { -181 }

      it "raises an error" do
        expect { location.validate! }.to raise_error(Dry::Struct::Error)
      end
    end
  end
end
