# require "rubygems"
# require "sunlight"
# Sunlight::Base.api_key = "bb3a1ba8af354f1dbfb1769f4cd893bb"

class Queue
  attr_accessor :data

  def initialize
    @data = Array.new
  end

  def clear
    @data = Array.new
  end

  def count
    @data.count
  end


  def printing
    order = { :last_name=>"LAST NAME", :first_name=>"FIRST NAME",
              :email_address=>"EMAIL", :zipcode=>"ZIPCODE", :city=>"CITY",
              :state=>"STATE", :street=>"ADDRESS", :home_phone=>"PHONE",
              :district=>"DISTRICT" }
    header_lengths = find_length_per_column
    print_header(order, header_lengths)
    print_data(order, header_lengths)
  end


  # def district
  #   if count > 0 && count <= 10
  #     @data.each do |record|
  #       address = {:address => "#{record[:street]} #{record[:city]}, #{record[:state]}"}
  #       record[:district] = get_district_by_address(address)
  #     end
  #   else
  #     "The queue has too many entries to find legislators."
  #   end
  # end

  private

  def print_header(order, header_lengths)
    total_length = 140
    puts "-" * total_length
    order.each do |key, header|
      unless header_lengths[key].nil? || header_lengths[key].zero?
        print header.ljust(header_lengths[key]) + "\t"
      end
    end
    puts ""
    puts "-" * total_length
  end

  def print_data(order, header_lengths)
    @data.each do |record|
      order.each do |key, value|
        unless header_lengths[key].nil? || header_lengths[key].zero? || record[key].nil?
          print record[key].ljust(header_lengths[key]) + "\t"
        end
      end
      puts ""
    end
  end

  def find_length_per_column
    highest_total = {:reg_date=>0, :first_name=> 10, :last_name=>9,
      :email_address=>5, :home_phone=>5, :street=>7, :city=>4, :state=>5, :zipcode=>7}
      @data.each do |record|
        record.each do |key, value|
          unless value.nil?
            highest_total[key] = value.length if value.length > highest_total[key]
          end
        end
      end
      highest_total
    end

  # def get_district_by_address(address)
  #   Sunlight::District.get(address)
  # end

end
