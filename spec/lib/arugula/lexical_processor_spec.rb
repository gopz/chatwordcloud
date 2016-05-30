describe 'lexical processor' do
  let(:words) { ["we've", 'all', 'been', 'there', 'another', 'day', 'dollar'] }
  it 'returns a list of words without stop words based on default list' do
    lexical_processor = LexicalProcessor.new(words)
    lexical_processor.strip_stop_words!
    expect(lexical_processor.words).to eq %w(another day dollar)
  end

  it 'excludes custom words' do
    lexical_processor = LexicalProcessor.new(words)
    lexical_processor.strip_stop_words!(augment: ['dollar'])
    expect(lexical_processor.words).to eq %w(another day)
  end
end
