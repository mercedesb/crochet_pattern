# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ParserFactory, type: :model do
  subject { described_class.new }
  describe "#get_parser" do
    describe "basic stitch" do
      it "returns a BasicStitchParser obj" do
        expect(subject.get_parser('sc')).to be_instance_of(Parsers::BasicStitchParser)
      end
    end

     describe "composite stitch" do
      it "returns a CompositeStitchParser obj" do
        expect(subject.get_parser('Dc inc')).to be_instance_of(Parsers::CompositeStitchParser)
      end
    end

     describe "repeat instruction" do
      it "returns a RepeatInstructionParser obj" do
        expect(subject.get_parser('* Dc inc * repeat 3 times')).to be_instance_of(Parsers::RepeatInstructionParser)
      end
    end

    describe "general instruction" do
      it "returns an InstructionParser obj" do
        expect(subject.get_parser('Unknown instruction')).to be_instance_of(Parsers::InstructionParser)
      end
    end
  end

  describe "#get_row_parser" do
    it "returns an InstructionParser obj" do
      expect(subject.get_row_parser('* Dc inc * repeat 3 times')).to be_instance_of(Parsers::InstructionParser)
    end
  end
end