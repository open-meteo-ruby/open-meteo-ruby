RSpec.describe OpenMeteo::Forecast::Variables do
  let(:variables) do
    described_class.new(
      current:,
      minutely_15:,
      hourly:,
      daily:,
      models:,
      timezone:,
      temperature_unit:,
      wind_speed_unit:,
      precipitation_unit:,
      forecast_days:,
      past_days:,
    )
  end
  let(:current) { [] }
  let(:minutely_15) { [] }
  let(:hourly) { [] }
  let(:daily) { [] }
  let(:models) { [] }
  let(:timezone) { nil }
  let(:temperature_unit) { nil }
  let(:wind_speed_unit) { nil }
  let(:precipitation_unit) { nil }
  let(:forecast_days) { nil }
  let(:past_days) { nil }

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

    context "when temperature_unit is set" do
      let(:temperature_unit) { "fahrenheit" }

      it { is_expected.to eq({ temperature_unit: "fahrenheit" }) }
    end

    context "when wind_speed_unit is set" do
      let(:wind_speed_unit) { "mph" }

      it { is_expected.to eq({ wind_speed_unit: "mph" }) }
    end

    context "when precipitation_unit is set" do
      let(:precipitation_unit) { "inch" }

      it { is_expected.to eq({ precipitation_unit: "inch" }) }
    end

    context "when forecast_days is set" do
      let(:forecast_days) { 1 }

      it { is_expected.to eq({ forecast_days: 1 }) }
    end

    context "when past_days is set" do
      let(:past_days) { 1 }

      it { is_expected.to eq({ past_days: 1 }) }
    end

    context "when all are set" do
      let(:current) { %i[something other] }
      let(:minutely_15) { %i[something other] }
      let(:hourly) { %i[something other] }
      let(:daily) { %i[something other] }
      let(:models) { %i[something other] }
      let(:timezone) { "Europe/Berlin" }
      let(:temperature_unit) { "fahrenheit" }
      let(:wind_speed_unit) { "mph" }
      let(:precipitation_unit) { "inch" }
      let(:forecast_days) { 1 }
      let(:past_days) { 1 }
      let(:expected_output) do
        {
          current: "something,other",
          minutely_15: "something,other",
          hourly: "something,other",
          daily: "something,other",
          models: "something,other",
          timezone: "Europe/Berlin",
          temperature_unit: "fahrenheit",
          wind_speed_unit: "mph",
          precipitation_unit: "inch",
          forecast_days: 1,
          past_days: 1,
        }
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end
