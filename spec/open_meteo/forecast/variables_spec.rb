RSpec.describe OpenMeteo::Forecast::Variables do
  let(:variables) { described_class.new(current:, hourly:, daily:, models:) }
  let(:current) { [] }
  let(:hourly) { [] }
  let(:daily) { [] }
  let(:models) { [] }

  describe "#to_get_params" do
    subject { variables.to_get_params }

    context "when all variables are empty" do
      let(:current) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({}) }
    end

    context "when current is set" do
      let(:current) { %i[something other] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({ current: "something,other" }) }
    end

    context "when hourly is set" do
      let(:current) { [] }
      let(:hourly) { %i[something other] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({ hourly: "something,other" }) }
    end

    context "when daily is set" do
      let(:current) { [] }
      let(:hourly) { [] }
      let(:daily) { %i[something other] }
      let(:models) { [] }

      it { is_expected.to eq({ daily: "something,other" }) }
    end

    context "when models is set" do
      let(:current) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { %i[something other] }

      it { is_expected.to eq({ models: "something,other" }) }
    end

    context "when all are set" do
      let(:current) { %i[something other] }
      let(:hourly) { %i[something other] }
      let(:daily) { %i[something other] }
      let(:models) { %i[something other] }
      let(:expected_output) do
        {
          current: "something,other",
          hourly: "something,other",
          daily: "something,other",
          models: "something,other",
        }
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end
