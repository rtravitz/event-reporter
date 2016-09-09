require "./test/test_helper"
require "./lib/event_reporter"

class EventReporterTest < Minitest::Test

  def test_event_reporter_exists
    reporter = EventReporter.new

    assert_instance_of EventReporter, reporter
  end

  def test_load_sends_people_and_information_to_dataset
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")

    assert_instance_of Person, reporter.dataset[0]
    assert_equal "Allison", reporter.dataset[0].first_name
  end

  def test_find_returns_correct_results_for_attributes_and_criteria
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")

    reporter.queue.data.each do |record|
      assert_equal record.send("first_name").downcase, "sarah"
    end

    assert_equal 2, reporter.queue.count
  end

  def test_find_properly_searches_for_multiple_criteria
    reporter = EventReporter.new
    reporter.load
    reporter.find("first_name sarah and state ca")

    reporter.queue.data.each do |record|
      assert_equal record.send("first_name").downcase, "sarah"
      assert_equal record.send("state").downcase, "ca"
    end

    assert_equal 4, reporter.queue.count
  end


  def test_help_returns_proper_help_text
    reporter = EventReporter.new
    expected = HelpText.new.help_text

    assert_equal expected, reporter.help
    assert_equal "Empty the queue.", reporter.help("queue clear")
    assert_equal "This is not a valid command.", reporter.help("wrong command")
  end

end
