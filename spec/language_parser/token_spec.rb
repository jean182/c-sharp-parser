# frozen_string_literal: true

require "spec_helper"

describe LanguageParser::Token do
  subject { LanguageParser::Token.new("INT", "1234", 1) }

  describe "#initialize" do
    it "properly instances the token object" do
      expect(subject).to be_a LanguageParser::Token
    end
  end

  describe "#to_text" do
    it "returns token as string" do
      expect(subject.to_s).to be_eql "1 => INT : 1234"
    end
  end

  describe "#to_array" do
    it "returns token as array" do
      expect(subject.to_a).to eq ["INT", "1234", 1]
    end
  end

  describe "#to_hash" do
    it "returns token as a hash" do
      expect(subject.to_hash).to eq(line: 1, name: "INT", value: "1234")
    end
  end
end
