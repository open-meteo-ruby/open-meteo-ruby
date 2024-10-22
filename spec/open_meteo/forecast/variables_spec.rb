RSpec.describe OpenMeteo::Forecast::Variables do
  let(:variables) do
    described_class.new(current:, minutely_15:, hourly:, daily:, models:, timezone:)
  end
  let(:current) { [] }
  let(:minutely_15) { [] }
  let(:hourly) { [] }
  let(:daily) { [] }
  let(:models) { [] }
  let(:timezone) { nil }

  describe "#to_query_params" do
    subject { variables.to_query_params }

    context "when no variables are set" do
      subject { described_class.new.to_query_params }

      it { is_expected.to eq({}) }
    end

    context "when all variables are empty" do
      let(:current) { [] }
      let(:minutely_15) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({}) }
    end

    context "when current is set" do
      let(:current) { %i[something other] }
      let(:minutely_15) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({ current: "something,other" }) }
    end

    context "when minutely_15 is set" do
      let(:current) { [] }
      let(:minutely_15) { %i[something other] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({ minutely_15: "something,other" }) }
    end

    context "when hourly is set" do
      let(:current) { [] }
      let(:minutely_15) { [] }
      let(:hourly) { %i[something other] }
      let(:daily) { [] }
      let(:models) { [] }

      it { is_expected.to eq({ hourly: "something,other" }) }
    end

    context "when daily is set" do
      let(:current) { [] }
      let(:minutely_15) { [] }
      let(:hourly) { [] }
      let(:daily) { %i[something other] }
      let(:models) { [] }

      it { is_expected.to eq({ daily: "something,other" }) }
    end

    context "when models is set" do
      let(:current) { [] }
      let(:minutely_15) { [] }
      let(:hourly) { [] }
      let(:daily) { [] }
      let(:models) { %i[something other] }

      it { is_expected.to eq({ models: "something,other" }) }
    end

    context "when timezone is set" do
      let(:timezone) { "Europe/Berlin" }

      it { is_expected.to eq({ timezone: "Europe/Berlin" }) }
    end

    context "when all are set" do
      let(:current) { %i[something other] }
      let(:minutely_15) { %i[something other] }
      let(:hourly) { %i[something other] }
      let(:daily) { %i[something other] }
      let(:models) { %i[something other] }
      let(:timezone) { "Europe/Berlin" }
      let(:expected_output) do
        {
          current: "something,other",
          minutely_15: "something,other",
          hourly: "something,other",
          daily: "something,other",
          models: "something,other",
          timezone: "Europe/Berlin",
        }
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end
