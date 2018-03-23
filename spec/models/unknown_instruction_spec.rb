# frozen_string_literal: true

require "spec_helper"
require "unknown_instruction"

RSpec.describe UnknownInstruction, type: :model do
  subject { described_class.new("Repeat 3 times") }
  describe "#make" do
    it "returns passed in string" do
      expect(subject.make).to eq "Repeat 3 times"
    end
  end
end
