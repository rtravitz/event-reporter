require "./test/test_helper"
require "./lib/event_reporter"

class EventReporterTest < Minitest::Test

  def test_event_reporter_exists
    reporter = EventReporter.new

    assert_instance_of EventReporter, reporter
  end

  def test_load_sends_records_to_dataset
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    expected =  {
                  :reg_date=>nil, :first_name=>"Allison",:last_name=>"Nguyen",
                  :email_address=>"arannon@jumpstartlab.com", :home_phone=>nil,
                  :street=>"3155 19th St NW", :city=>"Washington", :state=>"DC",
                  :zipcode=>"20010"
                }
    assert_equal expected, reporter.dataset[0]
  end

  def test_find_returns_correct_number_of_results_for_attributes_and_criteria
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")

    assert_equal 2, reporter.queue.data.count
  end

  def test_data_is_cleaned
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")

    find("first_name sarah")

    assert_equal "", queue.data.first[:zipcode]
  end


end
