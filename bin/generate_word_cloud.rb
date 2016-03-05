require '../lib/word_isolater'

DATA_DIR = '../data/hangouts-conversation-17.csv'
OUT_DIR = '../out/'
wi = WordIsolater.new(DATA_DIR)
File.open("#{OUT_DIR}all.txt", 'w') { |f| f.write(wi.all_words.join(' ')) }
wi.words_by_person.each do |person, words|
  filename = OUT_DIR + person.downcase.split(' ').join('_') + '.txt'
  File.open(filename, 'w') { |f| f.write(words.join(' ')) }
end
