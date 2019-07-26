# frozen_string_literal: true

require "spec_helper"

RSpec.describe LanguageParser::Rule do
  subject { LanguageParser::Ruleset }

  describe "#initialize" do
    it "creates an instance" do
      instance = subject.new

      expect(instance).to be_a LanguageParser::Ruleset
    end

    it "yields control" do
      expect { |b| subject.new(&b) }.to yield_control
      expect { |b| subject.new(&b) }.to yield_with_args(LanguageParser::Ruleset)
    end
  end

  describe "#rule" do
    it "adds a new rule criteria" do
      token_params = ["PLUS", /^\+$/]
      ruleset = subject.new

      expect(ruleset.rule(*token_params).pop).to be_a LanguageParser::Rule
    end
  end

  describe "#ignore" do
    it "adds ignored token criteria" do
      ruleset = subject.new

      returned = ruleset.ignore(/\d/)
      expect(returned).to include(/\d/)
    end
  end

  describe "#ignorable?" do
    it "verifes if a char is ignorable" do
      ruleset = subject.new
      ruleset.ignore(/\s/)

      expect(ruleset.ignorable?(" ")).to  be_truthy
      expect(ruleset.ignorable?("\t")).to be_truthy
      expect(ruleset.ignorable?("\n")).to be_truthy
      expect(ruleset.ignorable?("C")).to  be_falsey
    end
  end

  describe "#identifiable?" do
    it "identifies a pattern" do
      ruleset = subject.new do |r|
        r.rule("INT", /\d+/)
      end

      returned = ruleset.identifiable?("1234")
      expect(returned).to be_truthy

      returned = ruleset.identifiable?("ABCD")
      expect(returned).to be_truthy
    end
  end

  describe "#identify" do
    it "identifies a token" do
      ruleset = subject.new do |r|
        r.rule("FUNCTION", /^sqrt|sin|cos|tan|pow$/)
      end

      expected = LanguageParser::Token.new("FUNCTION", "sin", 10)
      returned = ruleset.identify("sin", 10)

      expect(expected.name == returned.name && expected.value == returned.value).to be_truthy
    end
  end
end
