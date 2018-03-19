# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Row, type: :model do
  describe "#make" do
    context "simple instruction" do
      subject { described_class.new("Dc, sc, sl st to join") }
      it "returns correct stitch output for row" do
        expect(subject.make).to eq "dc sc sl st to join"
      end
    end

    context "complex instruction" do
      subject { described_class.new("* Dc Inc * Repeat 2 times, sl st to join ") }
      it "returns correct stitch output for row" do
        expect(subject.make).to eq "dc inc dc inc sl st to join"
      end
    end
  end
end