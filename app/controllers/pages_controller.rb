class PagesController < ApplicationController
  def home

  end

  def terms

  end

  def map
    @jobs = Job.where.not(latitude: nil, longitude: nil)
    @geojson = build_geojson
  end

  private

    def build_geojson
      {
        type: "FeatureCollection",
        features: @jobs.map(&:to_feature)
      }
    end
end
