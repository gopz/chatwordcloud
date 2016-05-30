Gem::Specification.new do |s|
  s.name = 'arugula'
  s.version = '1.0.0'
  s.summary = 'NLP and parsing for popular instant messaging services'
  s.description = 'Provides an API for working with conversation histories' 
  s.author = 'Ryan Collins'
  s.email = 'ryancollins.biz@gmail.com'
  s.files = Dir['lib/*.rb'] + Dir['lib/arugula/*.rb'] + Dir['spec/*.rb']
  s.files += Dir['spec/lib/*.rb'] + Dir['spec/fixtures/*.txt'] + Dir['spec/lib/arugula/*.rb']
  s.files += Dir['dict/*.txt']
end
