require "./test/test_helper"
require "./lib/event_reporter"

class EventReporterTest < Minitest::Test

  def test_event_reporter_exists
    reporter = EventReporter.new

    assert_instance_of EventReporter, reporter
  end

  def test_load_converts_data_to_hash
    reporter = EventReporter.new
    reporter.load
    expected =  {
                  :reg_date=>nil, :first_name=>"Allison",:last_name=>"Nguyen",
                  :email_address=>"arannon@jumpstartlab.com", :home_phone=>nil,
                  :street=>"3155 19th St NW", :city=>"Washington", :state=>"DC",
                  :zipcode=>"20010"
                }
    assert_equal expected, reporter.dataset[1]
  end

  def test_find_returns_correct_results_for_attribute_and_criteria
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")

    assert_equal "", reporter.queue.data
  end



end
