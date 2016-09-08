require "faraday"
require 'json'

class Sunlight
  def initialize
    @conn = Faraday.new(:url => 'https://congress.api.sunlightfoundation.com/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def district(zipcode)
    response = @conn.get("/districts/locate?zip=#{zipcode}&apikey=bb3a1ba8af354f1dbfb1769f4cd893bb")
    body = JSON.parse(response.body)
    body["results"].first["district"].to_s
  end
end
