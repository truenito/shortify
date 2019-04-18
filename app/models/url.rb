# frozen_string_literal: true

# Url: The bread and butter of our app, a URL holds the original link and the 
# shortened link of a previously submitted URL.
class Url < ApplicationRecord
  has_many :url_visits, dependent: :destroy
  before_create :shorten_original_link
  after_create :scrape_attributes

  validates :original_link, uniqueness: true,
                            presence: true,
                            format: URI.regexp(%w[http https])

  # Call the ShortenUrl Service to generate the shortened url for us.
  def shorten_original_link
    self.shortened_link = ShortenUrl.call(original_link)
  end

  # Call the CrawlUrlWorker to asynchronously scrape the URLs via the
  # CrawlUrl service.
  def scrape_attributes
    CrawlUrlWorker.perform_async(id)
  end

  # Counts the amount of Url visits.
  def visit_count
    url_visits.count
  end
end
