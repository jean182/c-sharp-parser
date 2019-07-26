# frozen_string_literal: true

require "spec_helper"

RSpec.describe LanguageParser::Rule do
  describe "#initialize" do
    subject { LanguageParser::Rule }

    it "raises argument error on no params" do
      expect { subject.new }.to raise_error(ArgumentError)
    end

    it "raises error on one param only" do
      expect { subject.new("RULE") }.to raise_error(ArgumentError)
    end

    it "raises error on invalid param type" do
      expect { subject.new("RULE", "") }.to raise_error(ArgumentError)
      expect { subject.new("RULE", 1) }.to raise_error(ArgumentError)
      expect { subject.new(//, //) }.to raise_error(ArgumentError)
      expect { subject.new(//, "") }.to raise_error(ArgumentError)
      expect { subject.new(//, 1) }.to raise_error(ArgumentError)
      expect { subject.new(1, "") }.to raise_error(ArgumentError)
      expect { subject.new(1, 1) }.to raise_error(ArgumentError)
      expect { subject.new(1, //) }.to raise_error(ArgumentError)
    end

    it "creates an instance" do
      rule = subject.new("RULE", /\w/)

      expect(rule).to be_a LanguageParser::Rule
    end
  end

  describe "#name" do
    subject { LanguageParser::Rule.new("TEST_RULE", /[A-Za-z0-9]+/) }
    it "returns rule's name" do
      expect(subject.name).to be_eql "TEST_RULE"
    end
  end

  describe "#regex" do
    subject { LanguageParser::Rule.new("TEST_RULE", /[A-Za-z0-9]+/) }
    it "returns rule's name" do
      expect(subject.regex).to be_eql(/[A-Za-z0-9]+/)
    end
  end
end
