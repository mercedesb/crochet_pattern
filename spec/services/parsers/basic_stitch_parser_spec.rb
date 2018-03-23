# frozen_string_literal: true

require "spec_helper"
require "basic_stitch_parser"

RSpec.describe Parsers::BasicStitchParser, type: :model do
  describe "#parsable?" do
    describe "with a parsable value" do
      it "returns true" do
        expect(Parsers::BasicStitchParser.parsable?("Dc")).to eq true
      end
    end
    describe "with a non-parsable value" do
      it "returns false" do
        expect(Parsers::BasicStitchParser.parsable?("cant be parsed")).to eq false
      end
    end
  end

  describe "#parse" do
    context "with a parsable instruction" do
      subject { described_class.new("Dc") }
      it "returns correctly parsed stitch object(s)" do
        expect(subject.parse).to be_instance_of(DoubleCrochet)
      end
    end

    context "with repeated parsable instruction" do
      subject { described_class.new("Sc 27") }
      it "returns corrected parsed stitch object(s)" do
        result = subject.parse
        expect(result).to be_instance_of(RepeatInstruction)
        expect(result.repeat).to eq 27
        expect(result.children[0]).to be_instance_of(SingleCrochet)
      end
    end

    context "with a non-parsable instruction" do
      subject { described_class.new("cant be parsed") }
      it "returns nil" do
        expect(subject.parse).to be_nil
      end
    end
  end
end
