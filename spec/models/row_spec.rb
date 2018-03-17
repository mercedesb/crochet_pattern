# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Row, type: :model do
  describe "#make" do
    context "simple instruction" do
      subject { described_class.new("Dc sc sl st to join") }
      fit "returns correct stitch output for row" do
        expect(subject.make).to eq "Dc sc sl st to join"
      end

      fit "builds the correct stitch models" do
        subject.get_stitches
        expect(subject.stitches.count).to eq 4
        expect(subject.stitches[0]).to be_kind_of(DoubleCrochet)
        expect(subject.stitches[1]).to be_kind_of(SingleCrochet)
        expect(subject.stitches[2]).to be_kind_of(SlipStitch)
        expect(subject.stitches[3]).to be_kind_of(Join)
        exp
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