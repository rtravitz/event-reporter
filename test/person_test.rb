require "./test/test_helper"
require "./lib/person"

class PersonTest < Minitest::Test

  def test_person_takes_a_hash_of_data
    info =  {  regdate: "3/28/91", first_name: "Ryan", last_name: "Travitz",
              email_address: "rtravitz@gmail.com", homephone: "919-609-3220",
              street: "1175 3rd Street NE", city: "Washington", state: "DC",
              zipcode: "20002"
            }
    person = Person.new(info)

    assert_equal "Ryan", person.first_name
    assert_equal "20002", person.zipcode
  end
end
