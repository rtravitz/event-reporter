require "./test/test_helper"
require "./lib/queue"

class QueueTest < Minitest::Test

  def test_queue_can_be_initialized
    queue = Queue.new

    assert_instance_of Queue, queue
  end


end
