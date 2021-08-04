class Job < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_title, against: :title

  pg_search_scope :search_job,
                  against: [:title, :description, :job_author, :location],
                  using: {
                    tsearch: {
                      prefix: true
                    }
                  }

  # TAGS
  acts_as_taggable_on :tags
  ActsAsTaggableOn.delimiter = ' '
  ActsAsTaggableOn.force_lowercase = true

  # LIKE / UNLIKE / VOTABLE
  acts_as_votable

  # Job Views / Impressions
  is_impressionable

  has_many_attached :images, service: :amazon
  has_one_attached :company_logo, service: :amazon
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
            :industry,
            :start_date,
            :status,
            :num_employees,
            :salary_range,
            :status,
            :company_logo, :presence => true

  # JOB CONSTANTS
  TYPES = [
    "Full-Time",
    "Part-Time",
    "Contract",
    "Freelance",
    "Internship",
    "Temporary",
    "Comission",
    "Volunteer",
    "Casual",
    "Apprenticeship"
  ]
  STATUS = [
    "Active",
    "Archived"
  ]
  SALARY_RANGE = [
    "$20,000 - $50,000",
    "$50,000 - $75,000",
    "$75,000 - $90,000",
    "$90,000 - $110,000",
    "$110,000 - $150,000",
    "$150,000 - $200,000",
    "$200,000 +"
  ]
  INDUSTRIES = [
    "Advertising",
    "Agriculture",
    "Communications",
    "Construction",
    "Creative",
    "Education",
    "Entertainment",
    "Farming",
    "Fashion",
    "Finance",
    "Green",
    "Heavy",
    "Hospitality",
    "Information",
    "Information Technology",
    "Infrastructure",
    "Light",
    "Manufacturing",
    "Materials",
    "Media",
    "Music",
    "Publishing",
    "Retail",
    "Robotics",
    "Service",
    "Space",
    "Technology",
    "Telecom"
  ]
  NUM_EMPLOYEES = [
    "1 - 10",
    "10 - 50",
    "50 - 200",
    "200 - 1,000",
    "1,000 - 10,000",
    "10,000 +"
  ]
  BENEFITS = [
    "Extended Health Care",
    "Dental Care",
    "Vision Care",
    "RRSP Match",
    "Unlimited Paid Time Off (UPTO)",
    "Casual Dress",
    "Life Insurance",
    "Disability Insurance",
    "Flexible Schedule",
    "Company Pension",
    "On-site Parking",
    "Work From Home",
    "Discounted or Free Food",
    "Wellness Program",
    "Profit Sharing",
    "Company Events",
    "On-site Gym",
    "Company Car",
    "Tuition Reimbursement",
    "Stock Options",
    "On-site Childcare",
    "Employee Assistance Program",
    "Commuter Benefits",
    "Employee Stock Purchase Plan",
    "Store Discount",
    "None"
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

  def most_used_tags
    ActsAsTaggableOn::Tag.most_used(5)
  end
end
