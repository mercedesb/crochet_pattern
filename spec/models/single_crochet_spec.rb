# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SingleCrochet, type: :model do
  subject { described_class.new }
  describe '#make' do
    it 'returns sc' do
      expect(subject.make).to eq 'sc'
    end
  end

  describe '#abbrev' do
    it 'returns sc' do
      expect(SingleCrochet.abbrev).to eq 'sc'
    end
  end

  describe '#count' do
    it 'returns 1' do
      expect(subject.count).to eq 1
    end
  end
end
