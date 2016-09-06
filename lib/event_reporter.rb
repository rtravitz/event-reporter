require "csv"
require "./lib/queue"

class EventReporter
  attr_reader :dataset, :queue

  def initialize
    @dataset = Array.new
    @queue = Queue.new
  end

  def load(file_path = "./data/event_attendees.csv")
    @dataset = Array.new
    send_csv_data_to_dataset(file_path)
    clean_dataset
  end

  def find(user_input)
    @queue.clear
    attribute = user_input.split.first.to_sym
    criteria = user_input.split.last.downcase
    @dataset.each do |record|
      @queue.data << record if record[attribute].downcase == criteria
    end
  end

  private

  def send_csv_data_to_dataset(file_path)
    header_names = [  :regdate, :first_name, :last_name, :email_address,
                      :homephone, :street, :city, :state, :zipcode ]

    CSV.foreach file_path, headers: true, header_converters: :symbol do |row|
      record = Hash.new
      header_names.each do |name|
        record[name] = row[name]
      end
      @dataset << record
    end
  end

  def clean_dataset
    @dataset.each do |record|
      record.each do |key, value|
        record[key] = "" if value.nil?
      end
      record[:zipcode] = clean_zipcode(record[:zipcode])
      record[:homephone] = clean_phone_numbers(record[:homephone])
    end
  end

  def clean_zipcode(zipcode)
    zipcode = zipcode.to_s.rjust(5,"0")[0..4]
    zipcode.gsub!("00000", "")
    zipcode
  end

  def clean_phone_numbers(number)
    number = "" if number == "0"
    unless number.empty?
      number = number.gsub(/[\s+.()+E-]/, "").rjust(10, "0")
    end
    number[0..9]
  end

end
