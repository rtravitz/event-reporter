require "csv"
require "./lib/queue"

class EventReporter
  attr_reader :dataset, :queue

  def initialize
    @dataset = Array.new
    @queue = Queue.new
  end

  def load(file_path = "./data/short_attendees.csv")
    @dataset = Array.new
    send_csv_data_to_dataset(file_path)
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
    header_names = [  :reg_date, :first_name, :last_name, :email_address,
                      :home_phone, :street, :city, :state, :zipcode ]

    CSV.foreach file_path, headers: true, header_converters: :symbol do |row|
      record = Hash.new
      header_names.each do |name|
        record[name] = row[name]
      end
      @dataset << record
    end
  end
end
