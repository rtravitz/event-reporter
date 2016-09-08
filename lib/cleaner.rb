module Cleaner

  def self.clean_dataset(row)
    row.each do |category, value|
      row[category] = "" if value.nil?
    end
    row[:zipcode] = clean_zipcode(row[:zipcode])
    row[:homephone] = clean_phone_numbers(row[:homephone])
    row
  end

  def self.clean_zipcode(zipcode)
    zipcode = zipcode.to_s.rjust(5,"0")[0..4]
    zipcode.gsub!("00000", "")
    zipcode
  end

  def self.clean_phone_numbers(number)
    number = "" if number == "0"
    unless number.empty?
      number = number.gsub(/[\s+.()+En-]/, "").rjust(10, "0")
    end
    number[0..9]
  end

end
