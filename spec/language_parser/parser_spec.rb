# frozen_string_literal: true

require "spec_helper"

RSpec.describe LanguageParser::Parser do
  describe "Parser" do
    let(:parser) { described_class.new "<body>testing</body> <title>parsing with ruby</title>" }

    it "can parse an HTML tag" do
      expect(parser.first_tag.name).to eq "body"
    end

    it "can find a tag content" do
      expect(parser.first_tag.content).to eq "testing"
    end

    it "can find more than one tag" do
      second_tag = parser.tags[1]
      expect(second_tag.name).to eq "title"
      expect(second_tag.content).to eq "parsing with ruby"
    end
  end
end
