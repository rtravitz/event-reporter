require 'rubygems'
require 'sunlight'
Sunlight::Base.api_key = "bb3a1ba8af354f1dbfb1769f4cd893bb"

# district_info = Sunlight::District.get(:latitude => 33.876145, :longitude => -84.453789)
johns = Sunlight::Legislator.all_where(:firstname => "John")
# district = Sunlight::District.get(:address => "123 Fifth Ave New York, NY")
require "pry"; binding.pry


# def district
#   if count > 0 && count <= 10
#     @data.each do |record|
#       address = {:address => "#{record[:street]} #{record[:city]}, #{record[:state]}"}
#       district_info = Sunlight::District.get(:latitude => 33.876145, :longitude => -84.453789)
#       require "pry"; binding.pry
#     end
#   else
#     "The queue has too many entries to find legislators."
#   end
# end
