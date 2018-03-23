# frozen_string_literal: true

require "spec_helper"
require "double_crochet"
require "single_crochet"
require "slip_stitch"
require "increase"
require "join"
require "stitch_factory"

RSpec.describe StitchFactory, type: :model do
  subject { described_class.new }
  describe "#get_stitch" do
    describe "sl st" do
      it "returns a SlipStitch obj" do
        expect(subject.get_stitch("sl st")).to be_instance_of(SlipStitch)
      end
    end

    describe "sc" do
      it "returns a SingleCrochet obj" do
        expect(subject.get_stitch("sc")).to be_instance_of(SingleCrochet)
      end
    end

    describe "dc" do
      it "returns a DoubleCrochet obj" do
        expect(subject.get_stitch("dc")).to be_instance_of(DoubleCrochet)
      end
    end

    describe "inc" do
      it "returns a Increase obj" do
        expect(subject.get_stitch("inc")).to be_instance_of(Increase)
      end
    end

    describe "to join" do
      it "returns a Join obj" do
        expect(subject.get_stitch("to join")).to be_instance_of(Join)
      end
    end
  end
end
