# frozen_string_literal: true

# CrawlUrl: Crawls the original Url leveraging requests on HTTParty and parsing
#           on Nokogiri to get website titles and descriptions.
class CrawlUrl
  include HTTParty

  def self.call(url)
    new(url).call
  end

  def call
    { title: @title, description: @description }
  end

  private

  def initialize(url)
    @response = HTTParty.get(url, verify: false)
    @parsed_response = Nokogiri::HTML::Document.parse(@response.parsed_response)
    @title = for_title
    @description = for_description
  end

  def for_title
    @parsed_response.title.nil? ? "Couldn't fetch a title" : @parsed_response.title 
  end

  def for_description
    if @parsed_response.at("meta[name='description']").nil?
      "Couldn't fetch a description"
    else
      @parsed_response.at("meta[name='description']")['content']
    end
  end
end
