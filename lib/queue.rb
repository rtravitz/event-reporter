class Queue
  attr_accessor :data

  def initialize
    @data = Array.new
  end

  def clear
    @data = Array.new
  end

  def count
    @data.count
  end
end
