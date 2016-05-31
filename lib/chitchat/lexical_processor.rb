class LexicalProcessor
  LEVEL_1_STOP_WORDS = 'dict/level_1_stop_words.txt'.freeze
  LEVEL_2_STOP_WORDS = 'dict/level_2_stop_words.txt'.freeze

  attr_reader :words

  def initialize(words)
    @words = words
  end

  def strip_stop_words!(level: 1, augment: [])
    @words = filter(level).filter @words
    @words -= augment
  end

  private

  def filter(level)
    case level
    when 1
      Stopwords::Filter.new stop_words(LEVEL_1_STOP_WORDS)
    when 2
      Stopwords::Filter.new stop_words(LEVEL_2_STOP_WORDS)
    else
      raise ArgumentError, 'Invalid stop word level', caller
    end
  end

  def stop_words(file)
    lines = []
    File.open(file, 'r') { |f| f.each_line { |line| lines.push(line) } }
    lines.map! { |w| w.delete("\n") }
  end
end
