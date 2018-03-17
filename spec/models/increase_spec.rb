# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Increase, type: :model do
  subject { described_class.new(DoubleCrochet.new) }
  describe "#make" do
    it "returns inc" do
      expect(subject.make).to eq 'dc inc'
    end
  end

  describe "#count" do
    it "returns 2" do
      expect(subject.count).to eq 2
    end
  end
end