
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CrochetParser, type: :model do
   describe "#parse_element" do
    context "simple instruction" do
      subject { described_class.new("Dc, sc, sl st to join") }
      it "returns correct stitch output for row" do
        expect(subject.make).to eq "Dc sc sl st to join"
      end

      it "builds the correct stitch models" do
        subject.get_stitches
        expect(subject.stitches.count).to eq 4
        expect(subject.stitches[0]).to be_kind_of(DoubleCrochet)
        expect(subject.stitches[1]).to be_kind_of(SingleCrochet)
        expect(subject.stitches[2]).to be_kind_of(SlipStitch)
        expect(subject.stitches[3]).to be_kind_of(Join)
        exp
      end
    end
  end

  describe "#find_content" do
    it "returns up to end of repeat"
  end
end