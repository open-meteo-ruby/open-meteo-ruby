RSpec.describe OpenMeteo::Forecast::Variables::General do
  let(:variables) { described_class.new(current:, hourly:, daily:) }
  let(:current) { [] }
  let(:hourly) { [] }
  let(:daily) { [] }

  describe "#validate!" do
    context "when the current array contains only symbols" do
      let(:current) { %i[apparent_temperature cloudcover] }

      it "does not raise an error" do
        expect { variables.validate! }.not_to raise_error
      end
    end

    context "when the current array contains strings" do
      let(:current) { [:something, "invalid"] }

      it "raises an error" do
        expect { variables.validate! }.to raise_error(Dry::Struct::Error)
      end
    end
  end

  describe "#to_get_params" do
    subject { variables.to_get_params }

    context "when all variables are empty" do
      let(:current) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }

      it { is_expected.to eq({}) }
    end

    context "when current is set" do
      let(:current) { %i[something other] }
      let(:hourly) { [] }
      let(:daily) { [] }

      it { is_expected.to eq({ current: "something,other" }) }
    end

    context "when hourly is set" do
      let(:current) { [] }
      let(:hourly) { %i[something other] }
      let(:daily) { [] }

      it { is_expected.to eq({ hourly: "something,other" }) }
    end

    context "when daily is set" do
      let(:current) { [] }
      let(:hourly) { [] }
      let(:daily) { %i[something other] }

      it { is_expected.to eq({ daily: "something,other" }) }
    end

    context "when all are set" do
      let(:current) { %i[something other] }
      let(:hourly) { %i[something other] }
      let(:daily) { %i[something other] }
      let(:expected_output) do
        { current: "something,other", hourly: "something,other", daily: "something,other" }
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end
