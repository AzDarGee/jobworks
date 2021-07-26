class Job < ApplicationRecord

  has_many_attached :images, service: :amazon
  has_rich_text :description
  belongs_to :user

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  JOB_TYPES = ["Full-Time", "Part-Time", "Contract", "Freelance"]
  SALARY_RANGES = [
    "$20,000 - $50,000",
    "$50,000 - $75,000",
    "$75,000 - $90,000",
    "$90,000 - $110,000",
    "$110,000 - $150,000",
    "$150,000 - $200,000",
    "$200,000 +"
  ]
end
