require "csv"
require "./lib/queue"
require "./lib/help_text"
require "./lib/person"

class EventReporter
  attr_reader :dataset, :queue

  def initialize
    @dataset = Array.new
    @queue = Queue.new
  end

  def load(file_path = "./data/event_attendees.csv")
    @dataset = Array.new
    send_csv_data_to_dataset(file_path)
  end

  def find(user_input)
    @queue.clear
    attribute, criteria = user_input.downcase.split
    @dataset.each do |person|
      @queue.data << person if person.send(attribute).downcase == criteria
    end
  end

  def help(command = "")
    helper = HelpText.new
    if command.empty?
      puts helper.help_text
      helper.help_text
    elsif helper.help_text_for_commands.include?(command)
      puts helper.help_text_for_commands[command]
      helper.help_text_for_commands[command]
    else
      puts "This is not a valid command."
      "This is not a valid command."
    end
  end



  private

  def send_csv_data_to_dataset(file_path)
    CSV.foreach file_path, headers: true, header_converters: :symbol do |row|
      @dataset << Person.new(clean_dataset(row))
    end
  end

  def clean_dataset(row)
    row.each do |category, value|
      row[category] = "" if value.nil?
    end
    row[:zipcode] = clean_zipcode(row[:zipcode])
    row[:homephone] = clean_phone_numbers(row[:homephone])
    row
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
