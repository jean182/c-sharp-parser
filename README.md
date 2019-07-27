# C# reader

This project was built using ruby on rails.

### Project information

- Ruby 2.6.3

# Setup

1. Clone the repo
   `git clone https://github.com/jean182/c-sharp-parser.git`
2. In order to install this locally you need to have ruby 2.6.3 in your machine
3. Run this command
   `gem install --local /your_path_to_repo/language_parser-0.1.0.gem`
4. Open rails console
   `irb`
5. Start testing

```ruby
require "language_parser"

parser = LanguageParser.define do
  token :STOP     =>   /^\.$/
  token :COMA     =>   /^,$/
  token :QUES     =>   /^\?$/
  token :EXCLAM   =>   /^!$/
  token :QUOT     =>   /^"$/
  token :APOS     =>   /^'$/
  token :WORD     =>   /^[\w\-]+$/
end

tokens = parser.analyze do
from_string "Hello! My name is Jean Aguilar. You killed my father. Prepare to die."
end

tokens.each { |t| puts "#{t.name}: #{t.value}" }
```

And for C#

```ruby
require "language_parser"

parser = LanguageParser.define do
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

tokens = parser.analyze do
from_string "class Hello {}"
end

tokens.each { |t| puts "#{t.name}: #{t.value}" }
```

If you're creating an each do loop enter the loop one by one, don't copy the whole code since it won't be read from the terminal.

You can attempt to read a cs file you just need to specify it here

```ruby
  # This means your current folder location
  source = File.join(File.dirname(__FILE__), "/your_location/filename.cs")

  parser.analyze do
    from_file source
  end
```
