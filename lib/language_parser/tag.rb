# frozen_string_literal: true

module LanguageParser

  class Tag

    attr_reader :name
    attr_accessor :content

    def initialize(name)
      @name = name
    end

  end

end
