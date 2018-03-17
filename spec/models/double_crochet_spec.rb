# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DoubleCrochet, type: :model do
  subject { described_class.new }
  describe "#make" do
    it "returns dc" do
      expect(subject.make).to eq 'dc'
    end
  end

  describe "#count" do
    it "returns 1" do
      expect(subject.count).to eq 1
    end
  end
end