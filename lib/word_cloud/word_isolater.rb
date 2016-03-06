class WordIsolater
  require 'csv'
  require 'pry'
  UNIXTIME_COL = 0
  TIMESTAMP_COL = 1
  SENDER_ID_COL = 2
  SENDER_NAME_COL = 3
  MESSAGE_TYPE_COL = 4
  MESSAGE_COL = 5
  MESSAGE_HTML_COL = 6
  PERSON_SAYS = [SENDER_NAME_COL, MESSAGE_COL].freeze
  @text_file
  @words_by_person
  @all_words

  def initialize(text_file)
    @text_file = text_file
  end

  def words_by_person
    @words_by_person ||= parse_words_by_person
  end

  def all_words
    @all_words ||= parse_all_words
  end

  private

  def csv_as_array
    options = { col_sep: ';', quote_char: '"' }
    CSV.read(@text_file, options).drop(1) # Get rid of headers
  end

  def parse_words_by_person
    arr_of_arrs = csv_as_array
    arr_of_arrs.map! do |arr|
      arr.delete_if.with_index { |_, index| !(PERSON_SAYS.include? index) }
    end
    words_by_person = arr_of_arrs.group_by { |a| a[0] }.each do |_, v|
      v.map! { |arr| arr.drop(1)[0].split(' ') }.flatten!
    end
    words_by_person.delete_if { |person, _words| person =~ /unknown/ }
  end

  def parse_all_words
    csv_as_array.map { |a| a[MESSAGE_COL] }.map(&:split).flatten!
  end
end
