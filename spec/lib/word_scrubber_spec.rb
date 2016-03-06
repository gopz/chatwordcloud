require 'spec_helper'
require 'stopwords'
include WordScrubber
describe '#strip_stop_words' do
  describe 'level 1 stop words' do
    it 'removes stop words' do
      stopwords = %w(these they)
      words = %w(these stargates they glow)
      f = Stopwords::Filter.new stopwords
      scrubbed_words = f.filter words
      expect(scrubbed_words).to match %w(stargates glow)
    end
  end
end
