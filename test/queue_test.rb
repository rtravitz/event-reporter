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

end
