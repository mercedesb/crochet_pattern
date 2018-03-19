# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepeatInstruction, type: :model do
  subject { described_class.new(3, [Increase.new([DoubleCrochet.new])]) }
  describe '#make' do
    it 'returns dc inc dc inc dc inc' do
      expect(subject.make).to eq 'dc inc dc inc dc inc'
    end
  end

  describe '#count' do
    it 'returns 6' do
      expect(subject.count).to eq 6
    end
  end
end
