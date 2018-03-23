# frozen_string_literal: true

require "spec_helper"
require "join"
require "slip_stitch"

RSpec.describe Join, type: :model do
  subject { described_class.new([SlipStitch.new]) }
  describe "#make" do
    it "returns to join" do
      expect(subject.make).to eq "sl st to join"
    end
  end

  describe "#abbrev" do
    it "returns to join" do
      expect(Join.abbrev).to eq "to join"
    end
  end

  describe "#count" do
    it "returns -1" do
      expect(subject.count).to eq 0
    end
  end
end
