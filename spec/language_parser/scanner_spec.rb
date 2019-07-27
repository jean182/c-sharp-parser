# frozen_string_literal: true

describe "#define" do
  it "returns Lexeme object" do
    expect(LanguageParser.define { token ANY: /^.*$/ }).to be_a LanguageParser::Scanner
  end
end

describe "#analyze" do
  it "raise an erorr if source file cannot be found" do
    parser = LanguageParser.define do
      token ANY: /^.*$/
    end

    expect { parser.analyze { from_file "/root/surce.math" } }.to raise_error(RuntimeError)
  end

  # it "tokenizes a csharp file" do
  #   source = File.join(File.dirname(__FILE__), "/fixtures/source.cs")

  #   parser = LanguageParser.define do
  #     token EQ: /^=$/
  #     token PLUS: /^\+$/
  #     token MINUS: /^\-$/
  #     token MULTI: /^\*$/
  #     token DIV: %r{^/$}
  #     token NUMBER: /^\d+\.?\d?$/
  #     token RESERVED: /^(void|static|class|string|int)$/
  #     token BLOCK: /^(\[\]|\(\)|\{|\}|\(|\))$/
  #     token STRING: /^"[^"]*"?$/
  #     token ID: /^[\w_]+$/
  #   end

  #   parser.analyze do
  #     from_file source
  #   end
  # end

  it "tokenize a math formulas source" do
    source = File.join(File.dirname(__FILE__), "/fixtures/source.math")

    parser = LanguageParser.define do
      token "OPEN" => /^\($/
      token "CLOSE" => /^\)$/
      token "PLUS"     => /^\+$/
      token "MINUS"    => /^\-$/
      token "MULTI"    => /^\*$/
      token "DIV"      => %r{^/$}
      token "NUMBER"   => /^\d+\.?\d?$/
      token "FUNCTION" => /^(sqrt|pow|sin|cos|tan)$/
      token "VAR"      => /^\w+\d?$/
    end

    parser.analyze do
      from_file source
    end

    expect(parser.tokens[4].name).to eql("FUNCTION")
    expect(parser.tokens[4].value).to eql("sqrt")
  end

  it "tokenize a program language pseudo code" do
    source = File.join(File.dirname(__FILE__), "/fixtures/source.pseudo")

    parser = LanguageParser.define do
      token EQ: /^=$/
      token PLUS: /^\+$/
      token MINUS: /^\-$/
      token MULTI: /^\*$/
      token DIV: %r{^/$}
      token NUMBER: /^\d+\.?\d?$/
      token RESERVED: /^(fin|print|func)$/
      token STRING: /^"[^"]*"?$/
      token ID: /^[\w_]+$/
    end

    parser.analyze do
      from_file source
    end

    expect(parser.tokens[-1].name).to eq(:RESERVED)
    expect(parser.tokens[-1].value).to eq("fin")
  end

  it "tokenizes a human language sentence" do
    parser = LanguageParser.define do
      token STOP: /^\.$/
      token COMA: /^,$/
      token QUES: /^\?$/
      token EXCLAM: /^!$/
      token QUOT: /^"$/
      token APOS: /^'$/
      token WORD: /^[\w\-]+$/
    end

    tokens = parser.analyze do
      from_string "Hello! My name is Jean Aguilar. You killed my father. Prepare to die."
    end

    expect("#{tokens[0].name}: #{tokens[0].value}").to eql "WORD: Hello"
    expect("#{tokens[1].name}: #{tokens[1].value}").to eql "EXCLAM: !"
    expect("#{tokens[-1].name}: #{tokens[-1].value}").to eql "STOP: ."
  end
end
