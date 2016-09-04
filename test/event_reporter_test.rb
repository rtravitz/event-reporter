require "./test/test_helper"
require "./lib/event_reporter"

class EventReporterTest < Minitest::Test

  def test_event_reporter_exists
    reporter = EventReporter.new

    assert_instance_of EventReporter, reporter
  end

  def test_event_reporter_loads_a_file
    reporter = EventReporter.new
    dataset = reporter.load("./data/short_attendees.csv")

    assert dataset
  end



end
