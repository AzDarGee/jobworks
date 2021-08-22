class Project < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_project,
                  against: [:title, :description],
                  using: {
                    tsearch: {
                      prefix: true
                    }
                  }

  # Project Tags
  acts_as_taggable_on :tags
  ActsAsTaggableOn.delimiter = ' '
  ActsAsTaggableOn.force_lowercase = true

  # LIKE / UNLIKE / VOTABLE
  acts_as_votable

  # Project Views / Impressions
  is_impressionable

  has_many_attached :images, service: :amazon
  has_rich_text :description

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  belongs_to :user
end
