# TODO: get rid of this class and make a words class that has these as instance methods
module WordScrubber
  require 'spellingbee'
  require 'stopwords'
  DICT = '../dict/dict.txt'.freeze
  LEVEL_1_STOP_WORDS = '../dict/level_1_stop_words.txt'.freeze
  LEVEL_2_STOP_WORDS = '../dict/level_2_stop_words.txt'.freeze
  LAZY_CONTRACTIONS = %w(im hasnt havnt ill thats well hes youre id thats ive).freeze
  # TODO: come up with a much better way to manage this
  OVERRIDE_WORDS = ["he's", "you're", "that's", 'ya', 'youd', 'yea', 'arent', "i'm", 'didnt', "didn't"].freeze

  def scrubbed_words(words, options = {})
    scrubbed_words = words.map(&:downcase).map(&:strip)
    (scrubbed_words = strip_punctuation scrubbed_words) unless options[:strip_punctuation] == false
    (scrubbed_words = remove_numeric scrubbed_words) unless options[:strip_numeric] == false
    unless [0, false].include? options[:strip_stop_words]
      scrubbed_words = strip_stop_words scrubbed_words, options[:strip_stop_words]
    end
    (scrubbed_words = correct_spelling scrubbed_words) if options[:correct_spelling] == true
    scrubbed_words
  end

  private

  def strip_punctuation(words)
    words.map! { |w| w.gsub(/^[[:punct:]]/, '') }
    words.map { |w| w.gsub(/[[:punct:]]$/, '') }
  end

  def correct_spelling(words)
    # TODO: this class needs to be a module
    s = SpellingBee.new(DICT)
    words.map { |w| (s.correct w).first }
  end

  def strip_stop_words(words, level)
    if [nil, 1].include? level
      f = Stopwords::Filter.new stop_words(LEVEL_1_STOP_WORDS)
    elsif level == 2
      f = Stopwords::Filter.new (stop_words(LEVEL_2_STOP_WORDS) + LAZY_CONTRACTIONS + OVERRIDE_WORDS)
    else
      raise ArgumentError, 'Invalid stop word level', caller
    end
    f.filter words
  end

  def stop_words(file)
    lines = []
    stops = File.open(file, 'r') { |f| f.each_line { |line| lines.push(line) } }
    lines.map { |w| w.delete("\n") }
  end

  def remove_numeric(words)
    words.delete_if { |w| w =~ /^[+-]?(\d*\.)?\d+$/ }
  end
end
