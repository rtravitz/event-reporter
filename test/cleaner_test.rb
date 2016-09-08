require "./test/test_helper"
require "./lib/cleaner"

class CleanerTest < Minitest::Test
  include Cleaner

  def test_zip_codes_are_cleaned
    assert_equal "27519", Cleaner.clean_zipcode("275199999")
    assert_equal "", Cleaner.clean_zipcode("00000")
    assert_equal "00345", Cleaner.clean_zipcode("345")
  end

  def test_phone_numbers_are_cleaned
    assert_equal "9196093220", Cleaner.clean_phone_numbers("(919)6 09-3E2.20")
    assert_equal "9195931431", Cleaner.clean_phone_numbers("919593143111111")
  end

  def test_cleaner_removes_nils
    row = {name: nil, zipcode: "27519", homephone: "9196093220"}
    cleaned = Cleaner.clean_dataset(row)
    assert_equal "", cleaned[:name]
  end

end
