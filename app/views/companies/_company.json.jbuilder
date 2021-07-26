json.extract! company, :id, :name, :isPublic, :website, :address, :latitude, :longitude, :description, :created_at, :updated_at
json.url company_url(company, format: :json)
