# frozen_string_literal: true

class String

  def tokenize
    @parser ||= LanguageParser.define do
      use_language :natural
    end

    string_content = self

    @parser.analyze do
      from_string string_content
    end

    @parser.tokens
  end

end
