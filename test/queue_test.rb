require "./test/test_helper"
require "./lib/queue"
require "./lib/event_reporter"

class QueueTest < Minitest::Test

  def test_queue_can_be_initialized
    queue = Queue.new

    assert_instance_of Queue, queue
  end

  def test_queue_returns_correct_count
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")

    assert_equal 2, reporter.queue.count
  end

  def test_clear_empties_the_queue
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")

    assert_equal 2, reporter.queue.count

    reporter.queue.clear

    assert_equal 0, reporter.queue.count
  end

  def test_save_to_creates_csv_with_queue_information
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")
    reporter.queue.district
    reporter.queue.save_to("testing_save.csv")
    reporter.load("./testing_save.csv")

    assert_equal "sarah", reporter.dataset[0].send("first_name").downcase
    assert_equal "33703", reporter.dataset[1].send("zipcode")
    assert_equal 2, reporter.dataset.count
  end

  def test_export_to_html_creates_new_file
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")
    reporter.queue.district
    reporter.queue.export_to_html("testing_export.html")

    file_text = File.open("testing_export.html", "r").map{|line| line}

    assert_equal "<html>\n", file_text[0]
  end

  def test_sunlight_returns_districts_for_fewer_than_10_in_queue
    reporter = EventReporter.new
    reporter.load
    reporter.find("first_name sarah")

    refute reporter.queue.district

    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")
    reporter.queue.district

    assert_equal "0", reporter.queue.data.first.district
    assert_equal "13", reporter.queue.data.last.district
  end
end
