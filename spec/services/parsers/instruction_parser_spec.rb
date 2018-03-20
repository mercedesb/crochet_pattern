# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::InstructionParser, type: :model do
  describe '#parse' do
    context 'single stitch' do
      subject { described_class.new('dc') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 1
        expect(result[0]).to be_instance_of(DoubleCrochet)
      end
    end

    context 'multiple basic stitches' do
      subject { described_class.new('dc, sc, sc') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 3
        expect(result[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(SingleCrochet)
        expect(result[2]).to be_instance_of(SingleCrochet)
      end
    end

    context 'simple instruction' do
      subject { described_class.new('dc, sc, sl st to join') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 3
        expect(result[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(SingleCrochet)
        expect(result[2]).to be_instance_of(Join)
        expect(result[2].children[0]).to be_instance_of(SlipStitch)
      end
    end

    context 'repeated instruction' do
      subject { described_class.new('* dc inc * repeat 2 times, sl st to join') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 2
        expect(result[0]).to be_instance_of(RepeatInstruction)
        expect(result[0].children[0]).to be_instance_of(Increase)
        expect(result[0].children[0].children[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(Join)
        expect(result[1].children[0]).to be_instance_of(SlipStitch)
      end
    end

    context 'with unknown instruction at beginning' do
      subject { described_class.new('In heel color, * Sc 27, Turn * Repeat 7 times') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 2
        expect(result[0]).to be_instance_of(UnknownInstruction)
        expect(result[1]).to be_instance_of(RepeatInstruction)
        expect(result[1].repeat).to eq 7
        expect(result[1].children[0]).to be_instance_of(RepeatInstruction)
        expect(result[1].children[0].repeat).to eq 27
        expect(result[1].children[0].children[0]).to be_instance_of(SingleCrochet)
      end
    end

    context 'with unknown instruction at end' do
      subject { described_class.new('Sc 9, up side of heel') }
      it 'returns correct stitch output for row' do
        result = subject.parse
        expect(result.length).to eq 2
        expect(result[0]).to be_instance_of(RepeatInstruction)
        expect(result[0].repeat).to eq 9
        expect(result[0].children[0]).to be_instance_of(SingleCrochet)
        expect(result[1]).to be_instance_of(UnknownInstruction)
      end
    end
  end
end
