if ENV["BENCH"]
  require "test_helper"
  require "minitest/benchmark"

  class HiBench < Minitest::Benchmark
    def setup
      @highlighter = Hi::Highlighter.new :red
    end

    def bench_it_highlights
      text = "hello world"
      words = ['hello']
      assert_performance_linear 0.99 do |n|
        @highlighter.highlight(text * n, words)
      end
      assert_performance_linear 0.99 do |n|
        n.times do
          @highlighter.highlight(text, words)
        end
      end
    end
    def bench_it_highlights_regex
      text = "foo bar baz"
      words = [/f../]
      assert_performance_linear 0.99 do |n|
        @highlighter.highlight(text * n, words)
      end
      assert_performance_linear 0.99 do |n|
        n.times do
          @highlighter.highlight(text, words)
        end
      end
    end
  end
end
