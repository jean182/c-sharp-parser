# frozen_string_literal: true

module LanguageParser

  module Language

    def self.natural
      proc do
        token STOP: /^\.$/
        token COMA: /^,$/
        token QUES: /^\?$/
        token EXCL: /^!$/
        token QUOT: /^"$/
        token APOS: /^'$/
        token WORD: /^[\w\-]+$/
      end
    end

  end

end
