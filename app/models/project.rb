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

  has_many_attached :images, service: :amazon
  has_rich_text :description

  belongs_to :user
end
