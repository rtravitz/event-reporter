require "./test/test_helper"
require "./lib/sunlight"

class SunlightTest < Minitest::Test

  def test_district_returns_districts
    sunlight = Sunlight.new

    assert_equal "3", sunlight.district("81301")

  end
end
