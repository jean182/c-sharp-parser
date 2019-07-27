# frozen_string_literal: true

require "language_parser/version"
require "language_parser/parser"
require "language_parser/rule"
require "language_parser/ruleset"
require "language_parser/scanner"
require "language_parser/string_extensions"
require "language_parser/tag"
require "language_parser/token"
require "pry"

module LanguageParser

  def self.define(&block)
    @parser = LanguageParser::Scanner.new
    @parser.instance_eval(&block)

    @parser
  end

  def self.reset!
    remove_instance_variable(:@parser) if @parser
  end

end
