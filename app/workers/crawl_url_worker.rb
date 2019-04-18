class CrawlUrlWorker
  include Sidekiq::Worker

  def perform(id)
    url = Url.find(id)
    url.title = CrawlUrl.call(url.original_link)
    url.save!
  end
end
