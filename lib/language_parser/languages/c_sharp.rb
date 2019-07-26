# frozen_string_literal: true

module LanguageParser

  module Language

    def self.c_sharp
      proc do
        token EQ: /^=$/
        token PLUS: /^\+$/
        token MINUS: /^\-$/
        token MULTI: /^\*$/
        token DIV: %r{^/$}
        token NUMBER: /^\d+\.?\d?$/
        token RESERVED: /^(void|static|class|string|int)$/
        token BLOCK: /^(\[\]|\(\)|\{|\}|\(|\))$/
        token STRING: /^"[^"]*"?$/
        token ID: /^[\w_]+$/
      end
    end

  end

end
