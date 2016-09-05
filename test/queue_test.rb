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

  def test_sunlight_returns_districts_for_fewer_than_10_in_queue
    skip
    reporter = EventReporter.new
    # reporter.load("./data/event_attendees.csv")
    # reporter.find("first_name sarah")
    # expected = "The queue has too many entries to find legislators."
    #
    # assert_equal expected, reporter.queue.district

    reporter.load("./data/short_attendees.csv")
    reporter.find("first_name sarah")
    reporter.queue.district

    assert_equal "", reporter.queue.data[0][:district]
  end

  def test_print_returns_formatted_data
    reporter = EventReporter.new
    reporter.load("./data/short_attendees.csv")

    
  end

end
