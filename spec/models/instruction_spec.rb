# frozen_string_literal: true

require "spec_helper"
require "instruction"

RSpec.describe Instruction, type: :model do
  subject { described_class.new }
  describe "#make" do
    it "raises a NotImplementedError" do
      expect { subject.make }.to raise_error(NotImplementedError)
    end
  end
end
