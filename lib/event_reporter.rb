require "csv"

class EventReporter
  attr_reader :dataset

  def initialize
    @dataset = Hash.new
  end

  def load(file_path = "./data/short_attendees.csv")
    @dataset = Hash.new
    convert_csv_data_to_hash(file_path)
  end

  private

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def convert_csv_data_to_hash(file_path)
    header_names = [ :reg_date, :first_name, :last_name, :email_address,
      :home_phone, :street, :city, :state, :zipcode]
    CSV.foreach file_path, headers: true, header_converters: :symbol do |row|
      id = row[0]
      @dataset[id] = Hash.new if @dataset[id].nil?
      header_names.each do |name|
        @dataset[id][name] = row[name]
      end
    end
  end
  
end
