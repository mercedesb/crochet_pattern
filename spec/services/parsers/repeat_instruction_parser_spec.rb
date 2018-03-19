# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parsers::RepeatInstructionParser, type: :model do
  describe "#parsable?" do
    describe "with a parsable value" do
      it "returns true" do
        expect(Parsers::RepeatInstructionParser.parsable?('* Dc inc * 3 times')).to eq true
        expect(Parsers::RepeatInstructionParser.parsable?('(Dc inc) repeat 10 times')).to eq true
        expect(Parsers::RepeatInstructionParser.parsable?('{ Dc inc } x 4')).to eq true
        expect(Parsers::RepeatInstructionParser.parsable?('[ Dc inc ] 3 repeats')).to eq true
      end
    end
    describe "with a non-parsable value" do
      it "returns false" do
        expect(Parsers::RepeatInstructionParser.parsable?('cant be parsed')).to eq false
      end
    end
  end

  describe "#parse" do
    context "with a parsable instruction" do
      subject { described_class.new('[ Dc inc ] x 4') }
      it "returns correctly parsed stitch object(s)" do
        result = subject.parse
        expect(result.repeat).to eq 4
        expect(result).to be_instance_of(RepeatInstruction)
        expect(result.children[0]).to be_instance_of(Increase)
        expect(result.children[0].children[0]).to be_instance_of(DoubleCrochet)
      end
    end

    context "with a non-parsable instruction" do
      subject { described_class.new('cant be parsed') }
      it "returns nil" do
        expect(subject.parse).to be_nil
      end
    end
  end
end