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
    assert_equal "3/28/91", person.regdate
    assert_equal "Travitz", person.last_name
    assert_equal "rtravitz@gmail.com", person.email_address
    assert_equal "919-609-3220", person.homephone
    assert_equal "1175 3rd Street NE", person.street
    assert_equal "Washington", person.city
    assert_equal "DC", person.state
    assert_equal "20002", person.zipcode
  end
end
