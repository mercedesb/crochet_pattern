# frozen_string_literal: true

require "spec_helper"
require "base_parser"

RSpec.describe Parsers::BaseParser, type: :model do
  subject { described_class.new }
  describe "#parse" do
    it "raises NotImplementedError" do
      expect { subject.parse }.to raise_error(NotImplementedError)
    end
  end

  describe "#parsable?" do
    it "raises NotImplementedError" do
      expect { Parsers::BaseParser.parsable?("anything") }.to raise_error(NotImplementedError)
    end
  end
end
