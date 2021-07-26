class Job < ApplicationRecord
  has_many_attached :images, service: :amazon
  belongs_to :user

  JOB_TYPES = ["Full-Time", "Part-Time", "Contract", "Freelance"]
end
