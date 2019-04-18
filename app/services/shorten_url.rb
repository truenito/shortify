class ShortenUrl
  def self.call(original_link)
    new(original_link).call
  end

  def call
    shorten
  end

  private

  def initialize(original_link)
    @original_link = original_link
  end

  def shorten
    ENV['HOST_URL'] + "/#{short_id}"
  end

  def short_id
    Digest::SHA1.hexdigest(original_link).last(8)
  end

  attr_reader :original_link
end
