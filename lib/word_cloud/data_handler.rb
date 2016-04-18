class DataHandler
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
    CSV.read(@text_file, options).drop(1).reject(&:empty?) # Get rid of headers
  end

  def parse_words_by_person
    words_by_person = delete_empty_messages.group_by { |a| a[0] }.each do |_, v|
      v.map! { |arr| arr.drop(1)[0].split(' ') }.flatten!
    end
    words_by_person.delete_if { |person, _words| person =~ /unknown/ }
  end

  # TODO: I'm not sure what this does since I last changed it
  def delete_empty_messages
    csv_as_array.map do |arr|
      arr.delete_if.with_index { |_, index| !(PERSON_SAYS.include? index) }
    end
  end

  def parse_all_words
    csv_as_array.map { |a| a[MESSAGE_COL] }.map(&:split).flatten!
  end
end
