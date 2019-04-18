# frozen_string_literal: true

# UrlVisit: Is the persisted atomic Url visit counter, decided to do it this way
#           instead of using a property to keep better track of creation times
#           be more object oriented and to easily expand functionalities.
class UrlVisit < ApplicationRecord
  belongs_to :url
end
