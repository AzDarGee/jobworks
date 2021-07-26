class Job < ApplicationRecord
  acts_as_taggable_on :tags

  has_many_attached :images, service: :amazon
  has_rich_text :description
  belongs_to :user

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  validates :title,
            :url,
            :apply_url,
            :description,
            :job_type,
            :location,
            :job_author,
            :remote_ok,
            :salary_range, :presence => true

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

  def coordinates
    [longitude, latitude]
  end

  def to_feature
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": coordinates
      },
      "properties": {
        "job_id": id,
        "title": title,
        "description": description,
        "website": url,
        "apply_url": apply_url,
        "job_type": job_type,
        "location": location,
        "job_author": job_author,
        "remote": remote_ok,
        "salary_range": salary_range,
        "start_date": start_date,
        "info_window": ApplicationController.new.render_to_string(
          partial: "jobs/infowindow",
          locals: { job: self }
        )
      }
    }
  end

  def self.search(search)
    if search
      @parameter = search.downcase
      @results = Job.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
    else
      all
    end
  end
end
