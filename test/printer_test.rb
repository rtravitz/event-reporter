require "./test/test_helper"
require "./lib/printer"
require "./lib/event_reporter"
require "csv"

class PrinterTest < Minitest::Test

  def setup
    er = EventReporter.new
    er.load("./data/short_attendees.csv")
    @data = er.dataset
  end

  def test_find_greatest_length_returns_correct_column_lengths
    printer = Printer.new(@data)
    expected = {  "regdate"=>14, "first_name"=>10, "last_name"=>9,
                  "email_address"=>30, "homephone"=>10, "street"=>22, "city"=>16,
                  "state"=>5, "zipcode"=>7, "district"=>8   }

    assert_equal expected, printer.find_greatest_length_per_column
  end

  def test_print_by_sorts_data_for_printing
    printer = Printer.new(@data)

    assert_equal "Nguyen", @data.first.last_name

    @data = printer.print_by("last_name")

    assert_equal "Armideo", @data.first.last_name
  end

  def test_printing_rejects_empty_dataset
    @data = []
    printer = Printer.new(@data)

    assert_equal nil, printer.printing
  end

  def test_data_splits_into_subsets_of_ten
    er = EventReporter.new
    er.load
    er.find("first_name sarah")
    @data = er.queue.data
    printer = Printer.new(@data)

    assert_equal 10, printer.split_data_into_subsets_of_ten(@data)[0].count
    assert_equal 10, printer.split_data_into_subsets_of_ten(@data)[1].count
  end

end
