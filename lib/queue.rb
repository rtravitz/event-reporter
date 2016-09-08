require "./lib/sunlight"
require "csv"
require "erb"

class Queue
  attr_accessor :data

  def initialize
    @data = Array.new
    @order = { "last_name"=>"LAST NAME", "first_name"=>"FIRST NAME",
      "email_address"=>"EMAIL", "zipcode"=>"ZIPCODE", "city"=>"CITY",
      "state"=>"STATE", "street"=>"ADDRESS", "homephone"=>"PHONE",
      "district"=>"DISTRICT" }
    @headers = ["regdate", "first_name", "last_name", "email_address",
        "homephone", "city", "street", "state", "zipcode", "district"]
  end

  def clear
    @data = Array.new
  end

  def count
    @data.count
  end

  def printing(dataset = @data)
    if dataset.empty?
      puts "There is no data in the queue to print."
    else
      header_lengths = find_greatest_length_per_column
      total_records = @data.count
      subsets = split_data_into_subsets_of_ten(dataset)
      print_one_subset_at_a_time(subsets, header_lengths, total_records)
    end
  end

  def print_by(category)
    @data = @data.sort_by do |person|
      person.send(category)
    end
    printing
  end

  def export_to_html(file_name)
    template = ERB.new(File.read("./data/export_format.erb")).result(binding)
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

  private

  def print_header(header_lengths)
    total_length = header_lengths.values.inject(:+) + (3 * header_lengths.count)
    puts "-" * total_length
    @order.each do |key, header|
      unless header_lengths[key].nil? || header_lengths[key].zero?
        print header.ljust(header_lengths[key]) + "\t"
      end
    end
    puts ""
    puts "-" * total_length
  end

  def print_data(subset, header_lengths)
    subset.each do |person|
      @order.each do |key, value|
        unless header_lengths[key].nil? || header_lengths[key].zero? || person.send(key).nil?
          print person.send(key).ljust(header_lengths[key]) + "\t"
        end
      end
      puts ""
    end
  end

  def find_greatest_length_per_column
    highest_total = {"regdate"=>0, "first_name"=> 10, "last_name"=>9,
      "email_address"=>5, "homephone"=>5, "street"=>7, "city"=>4, "state"=>5,
      "zipcode"=>7}
    highest_total["district"] = 8 if @data.count <= 10
    @data.each do |person|
      highest_total.keys.each do |header|
        if person.send(header).length > highest_total[header]
          highest_total[header] = person.send(header).length
        end
      end
    end
    highest_total
  end

  def split_data_into_subsets_of_ten(dataset)
    record_subsets = Array.new
    single_subset = Array.new
    dataset.each do |record|
      if single_subset.count == 10
        record_subsets << single_subset
        single_subset = Array.new
      end
      single_subset << record
    end
    record_subsets << single_subset unless single_subset.empty?
    record_subsets
  end

  def print_one_subset_at_a_time(subsets, header_lengths, total_records)
    counter = 0
    record_numbers = [1, subsets[counter].count]
    input = ""
    until input == "exit" || counter == subsets.count
      print_header(header_lengths)
      print_data(subsets[counter], header_lengths)
      puts ""
      puts "Displaying records #{record_numbers.first}-#{record_numbers.last} out of #{total_records}."
      puts "Press enter to continue, or type 'exit' to escape."
      input = gets.chomp
      record_numbers[0] += 10
      counter += 1
      record_numbers[1] += subsets[counter].count unless subsets[counter].nil?
    end
  end


end
