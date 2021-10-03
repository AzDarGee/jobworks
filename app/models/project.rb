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
        "project_id": id,
        "title": title,
        "description": description,
        "price": price,
        "location": location,
        "start_date": start_date,
        "end_date": end_date,
        "info_window": ApplicationController.new.render_to_string(
          partial: "projects/infowindow",
          locals: { project: self }
        )
      }
    }
  end

  def most_used_tags
    ActsAsTaggableOn::Tag.most_used(5)
  end
end
