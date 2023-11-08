RSpec.describe OpenMeteo do
  it "has a version number" do
    expect(OpenMeteo::VERSION).not_to be nil
  end

  describe ".configure" do
    context "when no block is given" do
      it "raises an ArgumentError" do
        expect { described_class.configure }.to raise_error ArgumentError
      end
    end
  end
end
