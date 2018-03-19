
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrochetParser, type: :model do
  subject { described_class.new('') }

  describe '#parse_element' do
    context 'single stitch' do
      it 'returns correct stitch output for row' do
        result = subject.parse_element('dc')
        expect(result.length).to eq 1
        expect(result[0]).to be_instance_of(DoubleCrochet)
      end
    end

    context 'multiple basic stitches' do
      it 'returns correct stitch output for row' do
        result = subject.parse_element('dc, sc, sc')
        expect(result.length).to eq 3
        expect(result[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(SingleCrochet)
        expect(result[2]).to be_instance_of(SingleCrochet)
      end
    end

    context 'simple instruction' do
      it 'returns correct stitch output for row' do
        result = subject.parse_element('dc, sc, sl st to join')
        expect(result.length).to eq 3
        expect(result[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(SingleCrochet)
        expect(result[2]).to be_instance_of(Join)
        expect(result[2].children[0]).to be_instance_of(SlipStitch)
      end
    end

    context 'repeated instruction' do
      it 'returns correct stitch output for row' do
        result = subject.parse_element('* dc inc * repeat 2 times, sl st to join')
        expect(result.length).to eq 2
        expect(result[0]).to be_instance_of(RepeatInstruction)
        expect(result[0].children[0]).to be_instance_of(Increase)
        expect(result[0].children[0].children[0]).to be_instance_of(DoubleCrochet)
        expect(result[1]).to be_instance_of(Join)
        expect(result[1].children[0]).to be_instance_of(SlipStitch)
      end
    end
  end
end
