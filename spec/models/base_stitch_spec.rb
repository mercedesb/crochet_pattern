# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BaseStitch, type: :model do
  subject { described_class.new }
  describe "#make" do
    it "raises a NotImplementedError" do
      expect { subject.make }.to raise_error(NotImplementedError)
    end
  end

  describe "#abbrev" do
    it "raises a NotImplementedError" do
      expect { BaseStitch.abbrev }.to raise_error(NotImplementedError)
    end
  end

  describe "#count" do
    it "raises a NotImplementedError" do
      expect { subject.count }.to raise_error(NotImplementedError)
    end
  end

end