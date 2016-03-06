$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'word_cloud'
include WordScrubber

DATA_DIR = '../data/hangouts-conversation-17.csv'
OUT_DIR = '../out/'
wi = WordIsolater.new(DATA_DIR)
all_scrubbed_words = scrubbed_words wi.all_words 
File.open("#{OUT_DIR}all.txt", 'w') { |f| f.write(all_scrubbed_words.join(' ')) }

wi.words_by_person.each do |person, words|
  filename = OUT_DIR + person.downcase.split(' ').join('_') + '.txt'
  scrubbed_words = scrubbed_words words, strip_stop_words: 2
  File.open(filename, 'w') { |f| f.write(scrubbed_words.join(' ')) }
end
