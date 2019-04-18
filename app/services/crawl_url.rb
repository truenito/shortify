class CrawlUrl
  include HTTParty

  def self.call(url)
    new(url).call
  end

  def call
    for_title
  end

  private

  def initialize(url)

    @response = HTTParty.get(url, verify: false)
  end

  def for_title
    Nokogiri::HTML::Document.parse(@response.parsed_response).title
  end
end
