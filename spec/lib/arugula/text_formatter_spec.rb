describe 'text formatter' do
  it 'returns a list of cleaned words on init by default' do
    text_formatter = TextFormatter.new(['UnFormaTted',
                                        ' lisT ',
                                        ' of',
                                        '   WordS'])
    expect(text_formatter.words).to eq %w(unformatted list of words)
  end

  it 'returns a list of words on init if cleaning is overriden' do
    words = ['UnFormaTted', ' lisT ', ' of', '   WordS']
    text_formatter = TextFormatter.new(words, clean: false)
    expect(text_formatter.words).to eq words
  end

  it 'returns a words without leading and trailing punctuation, no numerics' do
    words = ['a', 'message,', 'w!th', '6', 'words!', '!oi!']
    text_formatter = TextFormatter.new(words)
    text_formatter.scrub!
    expect(text_formatter.words).to eq ['a', 'message', 'w!th', 'words', 'oi']
  end
end
