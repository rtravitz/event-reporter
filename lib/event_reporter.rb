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
      attributes, criteria = get_attributes_and_criteria(user_input)
      add_matching_results(attributes, criteria, user_input)
      puts "Added search results for to the queue."
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

  def add_matching_results(attributes, criteria, input)
    if multiple_searches?(input.split)
      @dataset.each do |person|
        if (person.send(attributes.first).downcase == criteria.first) &&
        (person.send(attributes.last).downcase == criteria.last)
          @queue.data << person
        end
      end
    else
      @dataset.each do |person|
        if person.send(attributes.first).downcase == criteria.first
          @queue.data << person
        end
      end
    end
  end

  def get_attributes_and_criteria(input)
    split = input.downcase.split
    if multiple_searches?(split)
      attributes = [split[0], split[3]]
      criteria = [split[1], split[4]]
      return attributes, criteria
    else
      attributes = [split[0]]
      criteria = [split[1]]
      return attributes, criteria
    end
  end

  def multiple_searches?(input)
    input[2] == "and" ? true : false
  end
end
