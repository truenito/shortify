json.extract! url, :id, :original_link, :shortened_link, :title, :description, :created_at, :updated_at
json.url url_url(url, format: :json)
