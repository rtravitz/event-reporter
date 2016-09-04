require "csv"
require "./lib/queue"

class EventReporter
  attr_reader :dataset, :queue

  def initialize
    @dataset = Hash.new
    @queue = Queue.new
  end

  def load(file_path = "./data/short_attendees.csv")
    @dataset = Hash.new
    convert_csv_data_to_hash(file_path)
  end

  def find(user_input)
    @queue.clear
    attribute = user_input.split.first.to_sym
    criteria = user_input.split.last.downcase
    @dataset.each do |record, attributes|
      @queue.data << attributes if attributes[attribute].downcase == criteria
    end
  end

  private

  def convert_csv_data_to_hash(file_path)
    header_names = [  :reg_date, :first_name, :last_name, :email_address,
                      :home_phone, :street, :city, :state, :zipcode ]

    CSV.foreach file_path, headers: true, header_converters: :symbol do |row|
      id = row[0].to_i
      @dataset[id] = Hash.new if @dataset[id].nil?
      header_names.each do |name|
        @dataset[id][name] = row[name]
      end
    end
  end
end
