require 'hi/version'
require 'colorize'

module Hi
  class Error < StandardError; end

  class Highlighter
    def initialize(color, words)
      @color = color
      @words = words
    end
    def highlight(text)
      @words.each do |word|
        text.gsub! word, word.bold.send(@color)
      end
      return text
    end
  end

end
