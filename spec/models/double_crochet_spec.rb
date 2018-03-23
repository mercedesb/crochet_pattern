# frozen_string_literal: true

require "spec_helper"
require "double_crochet"

RSpec.describe DoubleCrochet, type: :model do
  subject { described_class.new }
  describe "#make" do
    it "returns dc" do
      expect(subject.make).to eq "dc"
    end
  end

  describe "#abbrev" do
    it "returns dc" do
      expect(DoubleCrochet.abbrev).to eq "dc"
    end
  end

  describe "#count" do
    it "returns 1" do
      expect(subject.count).to eq 1
    end
  end
end
