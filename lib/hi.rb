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

    def highlight(string, words)
      # find the start / end index of each word
      ranges = []
      words.each do |word|
        ranges += string.enum_for(:scan, word).map do
          Regexp.last_match.begin(0) ... Regexp.last_match.end(0)
        end
      end

      # join into as many continuous ranges
      ranges.sort!
      combined_ranges = [ranges[0]]
      ranges[1...].each do |range|
        combined_ranges[-1...] = join(combined_ranges[-1], range)
      end

      # iterate in reverse order and replace
      new_string = string.dup
      combined_ranges.reverse_each do |range|
        highlight_range!(new_string, range)
      end
      return new_string
    end

    # join two ranges
    def join(r1, r2)
      return [r1, r2] if r2.begin > r1.end
      return [ r1.begin ... [r1.end, r2.end].max ]
    end

    def highlight_range!(string, range)
      string[range] = string[range].bold.send(@color)
    end
  end

end

class Range
  include Comparable
  def <=>(other)
    self.begin <=> other.begin
  end
end
