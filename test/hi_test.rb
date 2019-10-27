require "test_helper"

class HiTest < Minitest::Test
  def setup
    @highlighter = Hi::Highlighter.new :red
  end

  def test_that_it_has_a_version_number
    refute_nil ::Hi::VERSION
  end

  def test_it_highlights
    text = "hello world"
    assert_equal @highlighter.highlight(text, ["hello"]),
      "#{"hello".bold.red} world"
  end

  def test_it_highlights_multiple_lines
    text = "hello world\nfoo bar baz"
    assert_equal @highlighter.highlight(text, ["hello", "foo"]),
      "#{"hello".bold.red} world\n#{"foo".bold.red} bar baz"
  end

  def test_it_highlights_regex
    text = "foo bar baz"
    assert_equal @highlighter.highlight(text, [/f../]),
      "#{"foo".bold.red} bar baz"
  end

  def test_it_highlights_multiple_regex
    text = "hello world"
    assert_equal @highlighter.highlight(text, [/.o/]),
      "hel#{"lo".bold.red} #{"wo".bold.red}rld"
  end

  def test_it_highlights_once
    text = "foo bar baz"
    assert_equal @highlighter.highlight(text, ["bar", "ar"]),
      "foo #{"bar".bold.red} baz"
  end

  def test_it_highlights_all_lines
    text = "hello world\nfoo bar baz"
    assert_equal @highlighter.highlight(text, [/./]),
      "#{"hello world".bold.red}\n#{"foo bar baz".bold.red}"
  end

  def test_it_does_not_highlight
    text = "hello world\nfoo bar baz"
    assert_equal @highlighter.highlight(text, ['donuts']), text
  end

  def test_it_fails_unknown_colors
    assert_raises RuntimeError do
      Hi::Highlighter.new(:neon_brown)
    end
  end

end
