# frozen_string_literal: true

require "language_parser/version"
require "language_parser/parser"
require "language_parser/tag"
require "language_parser/token"
require "pry"

module LanguageParser

  def self.define(&block)
    @lexer = LanguageParser.new
    @lexer.instance_eval(&block)

    @lexer
  end

  def self.reset!
    remove_instance_variable(:@lexer) if @lexer
  end

end
