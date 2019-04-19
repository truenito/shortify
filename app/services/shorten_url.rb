# frozen_string_literal: true

# ShortenUrl: Generates a shortened Url by passing the original Url through
#             a SHA1 hash function and taking the last 8 digits.
class ShortenUrl
  attr_accessor :original_link

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
    ENV['HOST_URL'] + "/#{short_id_base64}"
  end

  def short_id_sha
    Digest::SHA1.hexdigest(original_link).last(6)
  end

  def short_id_base64
    Base64.encode64(original_link).strip.last(10)[0..-3]
  end
end
