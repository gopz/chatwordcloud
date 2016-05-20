class TextFormatter
  require 'spellingbee'
  require 'stopwords'

  DICT = 'dict/dict.txt'.freeze

  attr_reader :words

  def initialize(words_array, clean: true)
    @s = SpellingBee.new source_text: DICT
    @words = words_array
    make_clean if clean
  end

  def scrub!(options: { stopword_level: 2,
                        custom_words: [],
                        spelling_bee: false })
    strip_punctuation!
    remove_numeric!
    correct_spelling! if options[:spelling_bee]
  end

  private

  # Strips trailing and leading punctuation
  # aka !oi! will become oi but y!y will be unchanged
  def strip_punctuation!
    @words.map! do |w|
      w.gsub(/^[[:punct:]]/, '').gsub(/[[:punct:]]$/, '')
    end
  end

  def correct_spelling!
    @words.map! { |w| (@s.correct w).first }
  end

  def remove_numeric!
    @words.delete_if { |w| w =~ /^[+-]?(\d*\.)?\d+$/ }
  end

  def make_clean
    @words.map! { |w| w.downcase.strip }
  end
end
