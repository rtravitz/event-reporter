class HelpText
  attr_reader :help_text, :help_text_for_commands

  def initialize
    @help_text = "Available commands:\nload <filename>, help, help <command>,\nqueue count, queue clear, queue district, queue print,\nqueue print by <attribute>, queue save to <filename.csv>,\nqueue export html <filename.html>, find <attribute> <criteria>."

    @help_text_for_commands = { "load <filename>" => "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv.",
      "help" => "Output a listing of the available individual commands.",
      "help <command>" => "Output a description of how to use the specific command.",
      "queue count" => "Output how many records are in the current queue.",
      "queue clear" => "Empty the queue.",
      "queue district" => "If there are less than 10 entries in the queue, this command will use the Sunlight API to get Congressional District information for each entry.",
      "queue print" => "Print out a tab-delimited data table with a header row.",
      "queue print by <attribute>" => "Print the data table sorted by the specified attribute like zipcode.",
      "queue save to <filename.csv>" => "Export the current queue to the specified filename as a CSV.",
      "queue export html <filename.csv>" => "Export the current queue to the specified filename as a valid HTML file.",
      "find <attribute> <criteria>" => "Load the queue with all records matching the criteria for the given attribute.",
    }
  end
end
