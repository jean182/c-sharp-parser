# frozen_string_literal: true

module LanguageParser

  class Scanner

    attr_accessor :ruleset

    def tokens
      @tokens ||= []
    end

    def analyze(&block)
      instance_eval(&block)
    end

    def from_file(filepath = nil)
      raise ArgumentError, "Argument 1 must be a String" unless
        filepath.instance_of? String

      raise ArgumentError, "Source not defined" if
        filepath.empty?

      raise "Source file not readable" unless
        File.exist?(filepath)

      @tokens = scan(IO.read(filepath))
    end

    def from_string(source)
      raise ArgumentError, "Argument 1 must be a String" unless
        source.instance_of? String

      raise ArgumentError, "Source not defined" if
        source.empty?

      @tokens = scan(source)
    end

    def token(params)
      @ruleset ||= Ruleset.new

      name  = params.keys.first   || nil
      regex = params.values.first || nil
      @ruleset.rule(name, regex)

      @ruleset
    end

    def use_language(name)
      lang_file = "language_parser/languages/#{name}.rb"
      require lang_file

      instance_eval(&Language.send(name))
    rescue LoadError
      abort "Language file #{lang_file} cannot be found"
    end

    private

    def scan(input)
      previous = ""
      current  = ""
      new_line = 0
      line_num = 1

      input.each_char.with_index(1) do |c, i|
        if c == "\n"
          new_line += 1
          line_num += 1
          c = " "
        else
          new_line = 0
        end

        if !previous.empty? && ignorable?(previous)
          previous = ""
          current  = ""
        end

        current += c

        if current.eql?("(") || current.eql?("{") || current.eql?("[")
          current_string = input[i - 1...input.size].delete("\n")
          if brackets_balanced?(current_string)
            block = current_string[1...current_string.size - 1]
            scan(block)
          else
            raise "No closing for `#{current}` on line #{line_num - new_line}"
          end
        end

        unless identifiable?(current)
          raise "Unknown token `#{current}` on line #{line_num - new_line}" if
            previous.empty?

          token = identify(previous, line_num - new_line)
          raise "Unknown token `#{previous}` on line #{line_num - new_line}" if
            token.nil? || token.name.nil?

          tokens << token
          previous = c.clone
          current  = c.clone
          next
        end
        previous = current.clone
      end
      if !previous.empty? && !ignorable?(previous)
        token = identify(previous, line_num - new_line)
        raise "Unknown token `#{previous}` on line #{line_num - new_line}" if
          token.nil? || token.name.nil?

        tokens << token
      end

      tokens
    end

    def ignorable?(string)
      @ruleset.ignorable?(string)
    end

    def identifiable?(string)
      @ruleset.identifiable?(string)
    end

    def identify(string, line)
      @ruleset.identify(string, line)
    end

    def brackets_balanced?(string)
      return false if string.length < 2

      brackets_hash = { "(" => ")", "{" => "}", "[" => "]" }
      brackets = []
      string.each_char do |c|
        brackets.push(c) if brackets_hash.keys.include?(c)
        brackets.pop if brackets_hash.values.include?(c)
      end
      brackets.empty?
    end

  end

end
