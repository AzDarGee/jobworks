class PagesController < ApplicationController
  def home
    @featured_jobs = Job.all.limit(10)
    @curated_jobs = Job.all.limit(10)
  end

  def terms

  end

  def map
    @jobs = Job.where.not(latitude: nil, longitude: nil)
    @geojson = build_geojson
  end

  def pricing
    @subscription_prices = {
      free: 0,
      basic: 30,
      premium: 40,
      unlimited: 50
    }
  end

  def admin

  end


  private

    def build_geojson
      {
        type: "FeatureCollection",
        features: @jobs.map(&:to_feature)
      }
    end
end
