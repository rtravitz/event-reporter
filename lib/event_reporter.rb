require "csv"
require "./lib/queue"
require "./lib/help_text"
require "./lib/person"
require "./lib/cleaner"

class EventReporter
  include Cleaner
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
    if @dataset.empty?
      puts "No file has been loaded to search."
    else
      @queue.clear
      attribute = user_input.downcase.split.first
      criteria = user_input.downcase.split[1..-1].join(" ")
      @dataset.each do |person|
        @queue.data << person if person.send(attribute).downcase == criteria
      end
      puts "Added results for '#{attribute} #{criteria}' to the queue."
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
      @dataset << Person.new(Cleaner.clean_dataset(row))
    end
  end

end
