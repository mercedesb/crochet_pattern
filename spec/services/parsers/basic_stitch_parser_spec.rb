# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parsers::BasicStitchParser, type: :model do
  describe "#parsable?" do
    describe "with a parsable value" do
      it "returns true" do
        expect(Parsers::BasicStitchParser.parsable?('Dc')).to eq true
      end
    end
    describe "with a non-parsable value" do
      it "returns false" do
        expect(Parsers::BasicStitchParser.parsable?('cant be parsed')).to eq false
      end
    end
  end

  describe "#parse" do
    context "with a parsable instruction" do
      subject { described_class.new('Dc') }
      it "returns correctly parsed stitch object(s)" do
        expect(subject.parse).to be_instance_of(DoubleCrochet)
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