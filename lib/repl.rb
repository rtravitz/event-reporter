require "./lib/event_reporter"

class Repl
  attr_accessor :er

  def initialize
    @er = EventReporter.new
  end

  def run
    puts "Welcome to Event Reporter. Type 'help' to see available commands and 'quit' to exit."
    input = Array.new
    until input.first == "quit"
      puts "-" * 50
      print "Enter a command: "
      input = gets.chomp.downcase.split
      check_first_command(input)
    end
  end

  def check_first_command(input)
    case input.first
    when "load"   then load_options(input)
    when "help"   then help_options(input)
    when "find"   then er.find(input[1..-1].join(" "))
    when "queue"  then queue_options(input)
    else
    end
  end

  def load_options(input)
    if input.count == 1
      er.load
      puts "Loaded file at ./data/event_attendees.csv"
    else
      er.load(input[1])
      puts "Loaded file at #{input[1]}"
    end
  end

  def help_options(input)
    if input.count == 1
      er.help
    else
      er.help(input[1..-1].join(" "))
    end
  end

  def queue_options(input)
    if input[1] == "count"
      puts er.queue.count
    elsif input[1] == "clear"
      er.queue.clear
    elsif input[1] == "district"
      er.queue.district
    elsif input[1..-2].join(" ") == "print by"
      er.queue.print_by(input[-1])
    elsif input[1] == "print"
      er.queue.printing
    elsif input[1..-2].join(" ") == "save to"
      er.queue.save_to(input[-1])
      puts "Saved to #{input[-1]}"
    elsif input[1..-2].join(" ") == "export html"
      er.queue.export_to_html(input[-1])
      puts "Exported to #{input[-1]}"
    else
      puts "Not a valid command."
    end
  end
end

Repl.new.run
