# TODO get rid of this class and make a words class that has these as instance methods
module WordScrubber
  require 'spellingbee'
  require 'stopwords'
  require 'pry'
  DICT = '../dict/dict.txt'
  LEVEL_1_STOP_WORDS = '../dict/level_1_stop_words.txt'
  LEVEL_2_STOP_WORDS = '../dict/level_2_stop_words.txt'

  def scrubbed_words(words, options = {})
    scrubbed_words = words
    (scrubbed_words = strip_punctuation scrubbed_words) unless options[:strip_punctuation] == false
    unless [0, false].include? options[:strip_stop_words]
      scrubbed_words = strip_stop_words scrubbed_words, options[:strip_stop_words]
    end
    (scrubbed_words = correct_spelling scrubbed_words) if options[:correct_spelling] == true
    scrubbed_words
  end

private

  def strip_punctuation(words)
    words.map!{ |w| w.gsub(/^[[:punct:]]/, '') }
    words.map{ |w| w.gsub(/[[:punct:]]$/, '') }
  end

  def correct_spelling(words)
    # TODO this class needs to be a module
    s = SpellingBee.new(DICT)
    words.map{ |w| (s.correct w).first }
  end

  def strip_stop_words(words, level)
    if [nil, 1].include? level 
      f = Stopwords::Filter.new stop_words(LEVEL_1_STOP_WORDS)
    elsif level == 2
      f = Stopwords::Filter.new stop_words(LEVEL_2_STOP_WORDS)
    else
      raise ArgumentError, 'Invalid stop word level', caller
    end
    f.filter words
  end

  def stop_words(file)
    stops = File.open(file, 'r')
    lines = []
    stops.each_line{ |line| lines.push(line) }
    lines
  end
end
