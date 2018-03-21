# frozen_string_literal: true

require 'spec_helper'
require 'slip_stitch'

RSpec.describe SlipStitch, type: :model do
  subject { described_class.new }
  describe '#make' do
    it 'returns sl st' do
      expect(subject.make).to eq 'sl st'
    end
  end

  describe '#abbrev' do
    it 'returns sl st' do
      expect(SlipStitch.abbrev).to eq 'sl st'
    end
  end

  describe '#count' do
    it 'returns 1' do
      expect(subject.count).to eq 1
    end
  end
end
