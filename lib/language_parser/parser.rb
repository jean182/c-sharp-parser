# frozen_string_literal: true

module LanguageParser

  class Parser

    attr_reader :tags

    def initialize(str)
      @buffer = StringScanner.new(str)
      @tags   = []
      parse
    end

    def parse
      until @buffer.eos?
        skip_spaces
        parse_element
      end
    end

    def parse_element
      return unless @buffer.peek(1) == "<"

      @tags << find_tag
      last_tag.content = find_content
    end

    def skip_spaces
      @buffer.skip(/\s+/)
    end

    def find_tag
      @buffer.getch
      tag = @buffer.scan(/\w+/)
      @buffer.getch
      Tag.new(tag)
    end

    def find_content
      tag = last_tag.name
      content = @buffer.scan_until %r{</#{tag}>}
      content.sub("</#{tag}>", "")
    end

    def first_tag
      @tags.first
    end

    def last_tag
      @tags.last
    end

  end

end
