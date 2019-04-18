class Url < ApplicationRecord
  has_many :url_visits, dependent: :destroy
  validates :original_link, uniqueness: true,
                            presence: true,
                            format: URI.regexp(%w[http https])

  before_create :shorten_original_link

  def shorten_original_link
    self.shortened_link = ShortenUrl.call(original_link)
  end

  def visit_count
    url_visits.count
  end
end
