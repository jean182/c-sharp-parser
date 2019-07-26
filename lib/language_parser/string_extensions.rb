# frozen_string_literal: true

class String

  def tokenize
    @lexer ||= LanguageParser.define do
      use_language :natural
    end

    string_content = self

    @lexer.analyze do
      from_string string_content
    end

    @lexer.tokens
  end

end
