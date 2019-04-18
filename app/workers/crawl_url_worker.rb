class CrawlUrlWorker
  include Sidekiq::Worker

  def perform(id)
    url = Url.find(id)
    url_attributes = CrawlUrl.call(url.original_link)
    url.title = url_attributes[:title]
    url.description = url_attributes[:description]
    url.save!
  end
end
