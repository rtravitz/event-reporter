class Person
  attr_accessor :first_name, :last_name, :regdate, :email_address, :homephone, :street, :city, :state, :zipcode, :district
  def initialize(row)
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @regdate = row[:regdate]
    @email_address = row[:email_address]
    @homephone = row[:homephone]
    @street = row[:street]
    @city = row[:city]
    @state = row[:state]
    @zipcode = row[:zipcode]
    @district = ""
  end
end
