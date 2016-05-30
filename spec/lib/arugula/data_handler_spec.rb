describe 'data handler' do
  it 'returns a list of isolated words given a gchat csv file' do
    data_handler = DataHandler.new('spec/fixtures/g0.txt')
    expect(data_handler.all_words).to match %w(A sample regular message)
  end

  it 'returns a list of words per person in gchat convo given a csv file' do
    data_handler = DataHandler.new('spec/fixtures/g1.txt')
    expect(data_handler.words_by_person['Ryan Collins'])
      .to match %w(A sample message from Ryan)
    expect(data_handler.words_by_person['Alex Doliner'])
      .to match %w(A sample message from Alex)
  end
end
