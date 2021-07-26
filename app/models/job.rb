class Job < ApplicationRecord
  has_many_attached :images, service: :amazon


end
