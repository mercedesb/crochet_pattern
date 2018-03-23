# frozen_string_literal: true

require "spec_helper"
require "decrease"
require "single_crochet"

RSpec.describe Decrease, type: :model do
  subject { described_class.new([SingleCrochet.new]) }
  describe "#make" do
    it "returns dec" do
      expect(subject.make).to eq "sc dec"
    end
  end

  describe "#abbrev" do
    it "returns dec" do
      expect(Decrease.abbrev).to eq "dec"
    end
  end

  describe "#count" do
    it "returns -1" do
      expect(subject.count).to eq 0
    end
  end
end
