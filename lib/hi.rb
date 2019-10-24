require 'hi/version'
require 'colorize'

module Hi
  class Error < StandardError; end

  class Highlighter
    def initialize(color)
      if !String.colors.include? color.to_sym
        raise "I don't have that color"
      end
      @color = color
    end
    def highlight(text, words)
      words.each do |word|
        text.scan(word).each do |match|
          text.gsub! match, match.bold.send(@color)
        end
      end
      return text
    end
  end

end
