require "csv"
require "erb"
require "./lib/printer"
require "./lib/sunlight"

class Queue
  attr_accessor :data

  def initialize
    @data = Array.new
    @headers = ["regdate", "first_name", "last_name", "email_address",
        "homephone", "city", "street", "state", "zipcode", "district"]
  end

  def clear
    @data = Array.new
  end

  def count
    @data.count
  end

  def printing
    printer = Printer.new(@data)
    printer.printing
  end

  def print_by(category)
    printer = Printer.new(@data)
    @data = printer.print_by(category)
  end

  def export_to_html(file_name)
    template = ERB.new(File.read("./lib/export_format.erb")).result(binding)
    File.open(file_name, "w"){|file| file.puts template}
  end

  def save_to(file_name)
    CSV.open(file_name, "wb") do |csv|
      csv << @headers
      @data.each do |person|
        values = Array.new
        @headers.each do |category|
          values << person.send(category)
        end
        csv << values
      end
    end
  end

  def district
    sunlight = Sunlight.new
    if @data.count <= 10
      @data.each do |person|
        person.district = sunlight.district(person.zipcode)
      end
    else
      puts "There are too many records to check for a district."
    end
  end

end
