# frozen_string_literal: true

require "spec_helper"
require "double_crochet"
require "increase"

RSpec.describe Increase, type: :model do
  subject { described_class.new([DoubleCrochet.new]) }
  describe "#make" do
    it "returns inc" do
      expect(subject.make).to eq "dc inc"
    end
  end

  describe "#abbrev" do
    it "returns inc" do
      expect(Increase.abbrev).to eq "inc"
    end
  end

  describe "#count" do
    it "returns 2" do
      expect(subject.count).to eq 2
    end
  end
end
