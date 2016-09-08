require "./lib/event_reporter"

class Repl
  attr_accessor :er
  def initialize
    @er = EventReporter.new
  end

  def run
    puts "Program initialized. Type 'help' to see available commands and 'quit' to exit."
    input = []
    until input.first == "quit"
      print "Enter a command: "
      input = gets.chomp.downcase.split
      case input.first
      when "load"
        if input.count == 1
          er.load
          puts "Loaded file at ./data/event_attendees.csv"
        else
          er.load(input[1])
          puts "Loaded file at #{input[1]}"
        end
      when "help"
        if input.count == 1
          er.help
        else
          er.help(input[1..-1].join(" "))
        end
      when "find"
        er.find(input[1..-1].join(" "))
      when "queue"
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
      else
      end

    end
  end
end

Repl.new.run
