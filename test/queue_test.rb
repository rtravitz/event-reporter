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
    reporter.queue.save_to("testing_save.csv")
    reporter.load("./testing_save.csv")

    assert_equal "sarah", reporter.dataset[0][:first_name].downcase
    assert_equal "33703", reporter.dataset[1][:zipcode]
    assert_equal 2, reporter.dataset.count
  end

  # def test_sunlight_returns_districts_for_fewer_than_10_in_queue
  #   skip
  #   reporter = EventReporter.new
  #   # reporter.load("./data/event_attendees.csv")
  #   # reporter.find("first_name sarah")
  #   # expected = "The queue has too many entries to find legislators."
  #   #
  #   # assert_equal expected, reporter.queue.district
  #
  #   reporter.load("./data/short_attendees.csv")
  #   reporter.find("first_name sarah")
  #   reporter.queue.district
  #
  #   assert_equal "", reporter.queue.data[0][:district]
  # end

  # def test_print_returns_formatted_data
  #   reporter = EventReporter.new
  #   reporter.load
  # end



end
